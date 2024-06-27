#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <fstream>
#include <math.h>
#include <random>
#include <iostream>
#include <string>   
#include <sstream>  
#include <ctime>
#include "../../config/config_cpp.hpp"
#include "load_datasets.hpp"
#define HV_ELEMENT_BIT_WIDTH 8                  // Hyper Dimensional Vector element width in bits
#define TEST 0


struct HV {
    int data[HD_DIM];

    // Default constructor: Initializes all data elements to zero
    HV() {
        for (int i = 0; i < HD_DIM; ++i) {
            data[i] = 0;
        }
    }

    // Define the assignment operator
    HV& operator=(const HV& other) {
        if (this != &other) {
            for (int i = 0; i < HD_DIM; ++i) {
                data[i] = other.data[i];
            }
        }
        return *this;
    }
};

// ----------------------------
// OTHER FUNCTIONS
// Function to generate the quantization levels
// Input: min, max, levels
// Output: LevelList (array of thresholds for each quantization level)
// Example: min = 0, max = 1, levels = 4
//-----------------------------
void generate_quantization_levels(float min, float max,int levels, float LevelList[HD_LV_LEN])
{
    double length = max - min;
    double gap = length / levels;
    for (int level = 0; level < levels-1; ++level) {
        LevelList[level] = min + level * gap;
    }
    LevelList[levels-1] = max;
}

// Function to get the quantized level for a given value
int get_quantized_level(float value, float quantization_levels[HD_LV_LEN], int levels) {
    
    if (value <= quantization_levels[0]) 
        return 0;

    for (int i = 1; i < levels; ++i) 
        if (value <= quantization_levels[i]) 
            return i-1;

    return levels - 1;
}


HV rollIntArray(HV arr, int positions) {
    HV temp;

    // Calculate the index from which the rolling starts
    int startIndex = (HD_DIM - positions) % HD_DIM;

    // Copy the elements after the rolled section to the temporary array
    for (int i = 0; i < HD_DIM; ++i) {
        temp.data[i] = arr.data[(startIndex + i) % HD_DIM];
    }

    // Copy the rolled values back to the original array
    for (int i = 0; i < HD_DIM; ++i) {
        arr.data[i] = temp.data[i];
    }
    return arr;
}

// Hyper Dimensional Vector
class HDC_op
{
    public:
        int D;                        // HV size
        int HV_type;                  // HV type: binary or bipolar
        int num_levels;               // Number of levels used in the model
        int num_features;             // Number of features used in the model
        int lv_technique;             // Level vector technique: 0: linear, 1: approximately linear, 2: thermometer encoding
        int density;                  // Density of the HV (dense or sparse)
        float sparsity_factor;        // Sparsity factor of the HV (used only for sparse HVs)
        int HV_similarity;            // HV similarity: 0: Cosine, 1: Dot product, 2: Hamming distance
        int quant_min;
        int quant_max;
        int base_value;               // Base value of the HV (used only for bipolar HVs)
        
        // Constructor
        HDC_op( int dimensionality, int type, int dense, float sparsity,  int features, int levels, int lv_tech,  int similarity, int q_min, int q_max)
        {
            D = dimensionality;
            HV_type = type;
            num_levels = levels;
            num_features = features;
            lv_technique = lv_tech;
            density = dense;
            sparsity_factor = sparsity;
            HV_similarity = similarity;
            quant_min = q_min;
            quant_max = q_max;

            // The base constructur initializes the HV to all 1s or all -1s (according to the HD_DATA_TYPE)
            if (HV_type == 1)                
                base_value = -1;                     // Bipolar
            else
                base_value= 0;                       // Binary
            
        }

        HV random_HV()
        {
            HV HV1;
            std::random_device rd;
            std::mt19937 gen(rd());
            // Create a uniform distribution for integer values between 0 and HD_DIM-1
            std::uniform_int_distribution<int> dis(0, HD_DIM - 1);

            // initialize the HV to base values
            for (int i = 0; i < D; i++)
                HV1.data[i] = base_value;

            // Number of bits to be flipped, according to the sparsity factor
            int change_ratio;
            if (HD_MODE == 1)
                change_ratio = D * sparsity_factor;          
            else
                change_ratio = D / 2;                 

            // Flipping random change_ratio bits
            for (int i = 0; i < change_ratio; i++)
            {
                int index = dis(gen);
                HV1.data[index] = 1;
            }                
            return HV1;
        }
    

        // Print the HV
        void print_HV(HV HV1)
        {
            printf("= [");
            for (int i = 0; i < HD_DIM; i++)
                printf("%d ", HV1.data[i]);
            printf("]\n");
        }


        // --------------------Base HVs----------------------
        // Base Vectors: define the base vectors
        // If READ_HVs_FROM_FILE == 1, the base vectors are read from a file
        // If READ_HVs_FROM_FILE == 0, the base vectors are initialized randomly,
        // by instantiating HV elements and flipping a number of bits equal to HD_DIM * SPARSITY_FACTOR
        // --------------------------------------------------   
        void generate_BaseHVs(HV baseVectors[DS_FEATURE_SIZE])
        {                    
            //printf("Generating random base vectors...\n");  
            // The base vectors are obtained randomly flipping a number of bits dependent on the SPARSITY_FACTOR
            for (int vec = 0; vec < DS_FEATURE_SIZE; vec++)
                baseVectors[vec]=random_HV();
        }     
   

        // -----------------SIMILARITY--------------------
        // Computes the similarity between two HVs
        // that is Hamming distance for binary HVs
        // and cosine similarity for bipolar HVs
        // --------------------------------------------------
        float similarity(HV HV1, HV HV2, int technique=HD_SIMI_METHOD)
        {
            float sim = 0;
            if (technique == 2)
            {   
                // Hamming distance
                int hammingDistance = 0;
                for (int i = 0; i < HD_DIM; i++) {
                    if (HV1.data[i] != HV2.data[i]) {
                        hammingDistance++;
                    }
                }
                sim = (float)(hammingDistance) / HD_DIM;
            }
            else
            {
                float dot = 0.0, denom_a = 0.0, denom_b = 0.0 ;
                for (int i = 0; i < HD_DIM; i++)
                {
                    dot     += HV1.data[i] * HV2.data[i] ;
                    denom_a += HV1.data[i] * HV1.data[i] ;
                    denom_b += HV2.data[i] * HV2.data[i] ;
                }

                // Cosine or dot product
                if (technique==1)
                    sim=dot;
                else
                    sim = dot / (sqrt(denom_a) * sqrt(denom_b)) ;
            }
            return sim;
        }



        // Binding operator:
        // For Binary HVs, the binding is just a XOR operation
        // For Bipolar HVs, the binding is a vector element-wise multiplication operation
        HV bind(HV HV1,HV HV2)
        {
            HV Binded_HV;
            if (HV_type == 0)
            {
                // Binary binding
                for (int i = 0; i < D; i++)
                    Binded_HV.data[i] = HV1.data[i] ^ HV2.data[i];
            }
            else
            {
                // Bipolar binding
                for (int i = 0; i < D; i++)
                    Binded_HV.data[i] = HV1.data[i] * HV2.data[i];
            }
            return Binded_HV;
        }


        // Bundling operator:
        // For Binary HVs, the bundling is just a OR operation
        // For Bipolar HVs, the bundling is a vector element-wise addition operation
        HV bundle(HV HV1, HV HV2)
        {
            HV Bundled_HV;
            // Bipolar bundling
            for (int i = 0; i < D; i++)
                Bundled_HV.data[i] = HV1.data[i] + HV2.data[i];
            return Bundled_HV;
        }

        HV permutation(HV HV1, int positions)
        {
            HV Permuted_HV;
            Permuted_HV=rollIntArray(HV1, positions);
            return Permuted_HV;
        }

        // --------------------CLIPPING-----------------------
        // Cliping operator:
        // Function applied to the HV to clip the values in a custom range
        // From the integer ClassHVs you can:
        // - Generate a binary vector by clipping the values in the range [0, 1]. This is done through a thresholding operation
        // - Generate a bipolar vector by clipping the values in the range [-1, 1]. This is done through a modified sign function
        // - Generate a ternary vector by clipping the values in the range [-1, 0, 1]. This is done through a sign function
        // - Generate a quantized vector by clipping the values in the range [min, max]. This is done through a thresholding operation
        // --------------------------------------------------
        HV clip(HV HV1, int min, int max, int clipping_type, int total_HVs)
        {
            if (clipping_type==0)
                printf("\e[93mClipping mode:\e[39m No clipping mode, integer output HVs\n");
            else if(clipping_type==1)
            {
                //printf("\e[93mClipping mode:\e[39m Binary clipping mode\n");
                std::random_device rd;
                std::mt19937 gen(rd());
                if (HD_DATA_TYPE==0)
                {
                    //printf("\e[93mClipping mode:\e[39m Majority voting based on the number of features\n");
                    // Binary clipping
                    for (int i=0;i<D;i++)
                    {
                        if (HV1.data[i]<total_HVs/2)
                            HV1.data[i]=0;
                        else if (HV1.data[i]>total_HVs/2)
                            HV1.data[i]=1;
                        else{
                            // Create a uniform distribution for integer values between 0 and HD_DIM-1
                            std::uniform_int_distribution<int>dis(0, 1);
                            HV1.data[i] = dis(gen); // Randomly choose 0 or 1
                        }
                    }
                }
                else
                {
                    // Bipolar clipping
                    for (int i=0;i<HD_DIM;i++)
                        if (HV1.data[i] < 0)
                            HV1.data[i] =- 1;
                        else if (HV1.data[i] > 0)
                            HV1.data[i] = 1;   
                        else{
                            // Create a uniform distribution for integer values between 0 and HD_DIM-1
                            std::uniform_int_distribution<int>dis(0, 1);
                            if (dis(gen)==0)
                                HV1.data[i] = -1;
                            else
                                HV1.data[i] = 1; // Randomly choose 0 or 1

                        }
                }
            }
            else if(clipping_type==2)
            {
                printf("\e[93mClipping mode:\e[39m Ternary clipping mode\n");
                // Ternary clipping
                for (int i=0;i<D;i++)
                    if (HV1.data[i]<0)
                        HV1.data[i]=-1;
                    else if (HV1.data[i]>0)
                        HV1.data[i]=1;
                    else
                        HV1.data[i]=0;
            }
            else if(clipping_type==3)
            {
                printf("\e[93mClipping mode:\e[39m Quantized clipping mode\n");
                // Quantized clipping
                for (int i=0;i<D;i++)
                    if (HV1.data[i]<min)
                        HV1.data[i]=min;
                    else if (HV1.data[i]>max)
                        HV1.data[i]=max;
            }
            else
                printf("ERROR: Invalid clipping mode!\n");
        return HV1;
        }
        


    
        // --------------------Level HVs----------------------
        // Level Vectors: define the level vectors
        // If READ_HVs_FROM_FILE == 1, the level vectors are read from a file
        // If READ_HVs_FROM_FILE == 0, the level vectors are initialized accoring to the HD_LV_TYPE,
        // if HD_LV_TYPE == 0, the level vectors are initialized with the linear encoding
        // if HD_LV_TYPE == 1, the level vectors are initialized with the approximately linearly encoding
        // if HD_LV_TYPE == 2, the level vectors are initialized with the thermometer encoding
        // --------------------------------------------------
        void generate_LevelVectors(HV LevelVectors[HD_LV_LEN])
        {          
            printf("\e[92m----------\nGenerate_LevelVectors()\e[39m --> ");  
        
            printf("Generating random LHVs using the ");                
            if (lv_technique == 0)
            {
                printf("Linear encoding.\n");
                // Linear encoding
                // --------------------------------------------------
                // the first level vector is randomly initialized 
                int change_ratio;
                if (density == 1)
                    change_ratio = D * sparsity_factor;          
                else
                    change_ratio = D / 2;     
                for (int i = 0; i < change_ratio; i++)      // Flipping random change_ratio bits
                {
                    int index = rand() % D;
                    LevelVectors[0].data[index] = 1;
                }    
                // --------------------------------------------------            
                // The other level vectors are obtained flipping a number of bits equal to int(HD_DIM / (2 * totalLevel))
                // starting from the previous level vector. However, the same element can not be flipped 2 times
                change_ratio = D / (2 * num_levels);
                int indexVector[HD_DIM];
                for (int i = 0; i < D; i++)
                    indexVector[i] = 1;      // Index vector initialized to 1

                for (int level = 1; level < num_levels; level++)
                {
                    LevelVectors[level] = LevelVectors[level - 1];      // Copy the previous level vector
                    int i=0;
                    while (i < change_ratio)                            // Flipping random change_ratio bits
                    {
                        int index = rand() % D;                         // Random selection of the HV element
                        if (indexVector[index] == 1)                    // When the element has not been flipped yet
                        {                
                            indexVector[index] = 0;                     // The element can be flipped
                            i++;
                            if (HD_DATA_TYPE==0)
                                if (LevelVectors[level - 1].data[index] == 0)
                                    LevelVectors[level].data[index] = 1;
                                else
                                    LevelVectors[level].data[index] = 0;
                            else
                                if (LevelVectors[level - 1].data[index] == -1)
                                    LevelVectors[level].data[index] = 1;
                                else
                                    LevelVectors[level].data[index] = -1;
                        }
                    }
                }
            }
            else if (lv_technique==1)
            {
                printf("Approximately linear encoding.\n");
                // Approximately linear encoding:
                // two random level vectors are initialized (the first and last one), and the other level vectors are obtained taking
                // int(np.ceil(D * (1 - level / totalLevel))) from the first level vector and
                // int(D-(D * (1 - level / totalLevel))) from the second level vector
                int change_ratio;
                if (density == 1)
                    change_ratio = D * sparsity_factor;
                else
                    change_ratio = D / 2;                
                // Random initialization of the first level vector
                for (int i = 0; i < change_ratio; i++)
                {
                    int index = rand() % D;
                    LevelVectors[0].data[index] = 1;
                }
                // Random initialization of the last level vector
                for (int i = 0; i < change_ratio; i++)
                {
                    int index = rand() % D;
                    LevelVectors[num_levels-1].data[index] = 0;
                }
                // Intermediate level vectors
                for (int level = 1; level<num_levels-1;level++)
                {
                    int fromFirst = int((D * (1 - (float)level/num_levels)));
                    int fromSecond = D - fromFirst;
                    printf("Level %d: %d bits from first vector, %d bits from second vector\n",level,fromFirst,fromSecond);
                    for (int i = 0; i < D; i++)
                    {
                        if (i<fromFirst)
                            LevelVectors[level].data[i] = LevelVectors[0].data[i];
                        else
                            LevelVectors[level].data[i] = LevelVectors[num_levels-1].data[i];                            
                    }
                }                                   
            }
            else if (lv_technique==2)
            {
                printf("Thermometer encoding.\n");
                // Thermometer encoding:
                // the first level vector has all zero elements,
                // in the others intermediate levels, the first int((level + 1) * HD_DIM / (2 * HD_LV_LEN)) elements are set to 1
                // the last level vector has HD_DIM/2 elements set to 1
                for (int level = 0; level < num_levels; level++)
                {
                    for (int i = 0; i < D; i++)
                    {
                        if (level == 0)
                            LevelVectors[level].data[i] = 0;
                        else
                        {
                            if (i < int((level + 1) * D / (2 * num_levels)))
                                LevelVectors[level].data[i] = 1;
                            else
                                if (HV_type==0)
                                    LevelVectors[level].data[i] = 0;
                                else
                                    LevelVectors[level].data[i] = -1;
                                
                        }
                    }
                }
            }   
            else 
                printf("not known level_technique: %d\n", lv_technique);
            printf("\e[92m----------\n\e[39m");
        }    

        // ENCODING FUNCTIONS
        // From a given input feature vector, generate the corresponding HDC vector
        // This is done as follows:
        // 1) Compute the quantization level of each feature
        // 2) Generate the corresponding level vector
        // 3) BIND the level vector with the corresponding base vector (dependent by the number of the feature)
        // 4) Bundle all the level vectors together to obtain the HDC vector representation of the input feature vector
        // Input: FeatureVector, BaseVectors, LevelVectors, quantized_levels (array of thresholds for each quantization level)
        // Output: HDC vector
        HV encoding(float FeatureVector[DS_FEATURE_SIZE], HV BaseVectors[DS_FEATURE_SIZE], HV LevelVectors[HD_LV_LEN], float *LevelList, int clipping_encoding, int encoding_technique)
        {
            HV Encoded_HV;

            // 1) Compute the quantization level of each feature using get_quantized_level function
            int quantized_features[DS_FEATURE_SIZE];
            for (int i = 0; i < DS_FEATURE_SIZE; i++)
                quantized_features[i] = get_quantized_level(FeatureVector[i], LevelList, HD_LV_LEN);

            // 2) 
            // If record-based: BIND the level vector (dependent by the quantized_feature[i]) with the corresponding base vector (dependent by the feature index)
            // If N-gram: permute the level vector (dependent by the quantized_feature[i]) by the feature index
            HV binded_feature[DS_FEATURE_SIZE];
            for (int i = 0; i < DS_FEATURE_SIZE; i++)
            {
                // printf("Feature %d: %f -> Level %d\n", i, FeatureVector[i], quantized_features[i]);
                if (encoding_technique==0)
                    binded_feature[i] = bind(LevelVectors[quantized_features[i]], BaseVectors[i]);  // Record-based encoding
                else
                    binded_feature[i] = permutation(LevelVectors[quantized_features[i]], i);        // N-gram encoding
                // printf("Binding Level %d --> ", quantized_features[i]);
                // print_HV(LevelVectors[quantized_features[i]]);
                // printf("with Base %d --> ", i);
                // print_HV(BaseVectors[i]);  
                // printf("Result --> ");
                // print_HV(binded_feature[i]);
            }

            // 3) Bundle all the binded vectors together to obtain the HDC vector representation of the input feature vector
            for (int i = 0; i < DS_FEATURE_SIZE; i++)
                Encoded_HV = bundle(Encoded_HV,binded_feature[i]);
            // printf("Bundled HV --> "); print_HV(Encoded_HV);

            // 4) Clip the HDC vector
            Encoded_HV=clip(Encoded_HV, -1, 1, clipping_encoding, DS_FEATURE_SIZE);
            // printf("Final Encoded HV --> "); print_HV(Encoded_HV);
            return Encoded_HV;
        }


        // TRAIN FUNCTION:
        void train(float train_data[DS_TRAIN_SIZE][DS_FEATURE_SIZE], int train_labels[DS_TRAIN_SIZE], int num_classes, int quant_levels, int clipping_encoding, int clipping_class, int verbose,int n_gram,int n_gram_size, int encoding_technique, HV ClassHVs[DS_CLASSES_SIZE], float *LevelList, HV BaseHVs[DS_FEATURE_SIZE], HV LevelHVs[HD_LV_LEN])
        {

            HV Encoded_HV;
            
            int bundled_labels[DS_CLASSES_SIZE];

            // 1) Generate the base vectors
            generate_BaseHVs(BaseHVs);

            // 2) Generate the level vectors
            generate_LevelVectors(LevelHVs);

            // 3) Generate the quantization levels 
            generate_quantization_levels(DS_DATA_RANGE_MIN, DS_DATA_RANGE_MAX, quant_levels, LevelList);

            // 4) Training:
            for (int i=0;i<DS_TRAIN_SIZE;i++)
            {

                if (i % (DS_TRAIN_SIZE / 10) == 0 && verbose == 1) {
                    double percentage = (static_cast<double>(i) / DS_TRAIN_SIZE) * 100;
                    std::cout << "Iteration: " << i << " Progress: " << std::ceil(percentage) << "%" << std::endl;
                }

                // 4.1) Encode the training data
                Encoded_HV = encoding(train_data[i],
                                      BaseHVs,
                                      LevelHVs,
                                      LevelList,
                                      CLIPPING_ENCODING,
                                      ENCODING_TECHNIQUE);

                // 4.2) Accumulation: Class HVs
                int label = train_labels[i];
                ClassHVs[label] = bundle(ClassHVs[label],Encoded_HV);
                bundled_labels[label] +=1;
            }   

            // 5) Normalize the Class HVs
            for (int i=0;i<num_classes;i++)
                ClassHVs[i] = clip(ClassHVs[i],quant_min,quant_max,clipping_class,bundled_labels[i]);
        }


        float predict(float test_data[DS_TEST_SIZE][DS_FEATURE_SIZE], int test_labels[DS_TEST_SIZE], int num_classes, float *quantized_levels,HV BaseHVs[DS_FEATURE_SIZE], HV LevelHVs[HD_LV_LEN], HV ClassHVs[DS_CLASSES_SIZE], int clipping_encoding, int verbose, int n_gram, int n_gram_size,int encoding_technique, int retrain)
        {
            float similarities[DS_CLASSES_SIZE];
            int correct=0; int actual_class; int estimated_class;
            HV testedHV;
            for (int i=0;i<DS_TEST_SIZE;i++)
            {
                // 1) Encode the training data
                testedHV = encoding(test_data[i],
                                      BaseHVs,
                                      LevelHVs,
                                      quantized_levels,
                                      CLIPPING_ENCODING,
                                      ENCODING_TECHNIQUE); 
                actual_class = test_labels[i];

                // 2) Compute the similarity between the encoded HV and the Class HVs
                for (int j=0;j<num_classes;j++)
                    if (retrain==1)
                        similarities[j] = similarity(testedHV,ClassHVs[j], 0); // Always use cosine similarity in retraining, because the
                                                                             // Clipping is applied at the end of the retraining
                    else
                        similarities[j] = similarity(testedHV,ClassHVs[j]);

                // 3) Find the max/min similarity 
                estimated_class=0;
                if (HV_similarity==0 || HV_similarity==1 || density==1|| retrain==1)
                {
                    // Find class with max similarity
                    float max=0; int maxIndex;
                    for (int i = 0; i < DS_CLASSES_SIZE; i++) {
                        if (similarities[i] > max) {
                            max = similarities[i];
                            maxIndex = i;
                        }
                    }
                    estimated_class = maxIndex;
                }
                else
                {
                    // Find class with min similarity
                    float min=10000000; int minIndex;
                    for (int i = 0; i < DS_CLASSES_SIZE; i++) {
                        if (similarities[i] < min) {
                            min = similarities[i];
                            minIndex = i;
                        }
                    }
                    estimated_class = minIndex;                            
                }

                if (estimated_class == actual_class)
                    correct = correct + 1;
                
                if (i != 0 && i % (DS_TEST_SIZE / 10) == 0 && verbose == 1) {
                    double percentage = (static_cast<double>(i) / DS_TEST_SIZE) * 100;
                    double accuracy = (static_cast<double>(correct) / i) * 100;
                    std::cout << "Progress: " << std::ceil(percentage) << "% ---> accuracy: " << accuracy << "%" << std::endl;
                }                 

            }
            float accuracy=float(correct*100)/DS_TEST_SIZE;
            printf("Accuracy: %f\n",accuracy);
            return accuracy;
        }

        void retrain(float retrain_data[DS_TRAIN_SIZE][DS_FEATURE_SIZE], int retrain_labels[DS_TEST_SIZE], float test_data[DS_TEST_SIZE][DS_FEATURE_SIZE], int test_labels[DS_TEST_SIZE], int num_classes, float *quantized_levels,HV BaseHVs[DS_FEATURE_SIZE], HV LevelHVs[HD_LV_LEN], HV ClassHVs[DS_CLASSES_SIZE], int clipping_encoding, int verbose, int n_gram, int n_gram_size,int encoding_technique, int clipping_class, int epochs, float starting_accuracy, int lr_max, int beta_lr,int learning_rate_decay, HV best_ClassHVs[DS_CLASSES_SIZE])
        {
            // Initializations:
            float accuracy_before = starting_accuracy;
            float new_accuracy;
            int corrections=10;
            float error_rate[beta_lr];
            int learning_rate=lr_max;
            int iterations=0;
            float similarities[DS_CLASSES_SIZE];
            int actual_class, estimated_class;
            int learning_rate_data;

            int bundled_labels[DS_CLASSES_SIZE];
            int best_bundled_labels[DS_CLASSES_SIZE];
            int best_epoch=0;
            int beta=0;
            
            
            // 1) Retraining:
            while ((iterations < epochs) && (corrections > 0))
            {
                // Learning rate decider:
                if (learning_rate_decay != LR_CONSTANT)
                    if (beta == beta_lr-1)
                    {
                        // Learning rate is assigned to the average of error_rate
                        float sum=0;
                        for (int i=0;i<beta_lr;i++)
                            sum += error_rate[i];
                        learning_rate = sum/beta_lr;
                        
                        beta=0;
                        if (learning_rate > lr_max)
                            learning_rate = lr_max;
                    }

                // Training:
                HV Encoded_HV;
                for (int i=0;i<DS_TRAIN_SIZE;i++)
                {
                    if (i % (DS_TRAIN_SIZE / 10) == 0 && verbose == 1) {
                        double percentage = (static_cast<double>(i) / DS_TRAIN_SIZE) * 100;
                        std::cout << "Iteration: " << i << " Progress: " << std::ceil(percentage) << "%" << std::endl;
                    }    

                    // 1.1) Encode the training data
                    Encoded_HV = encoding(retrain_data[i],
                                          BaseHVs,
                                          LevelHVs,
                                          quantized_levels,
                                          CLIPPING_ENCODING,
                                          ENCODING_TECHNIQUE);
                    
                    actual_class = retrain_labels[i];

                    // Similatiry between the encoded HV and the Class HVs
                    for (int j=0;j<num_classes;j++)
                        similarities[j] = similarity(Encoded_HV,ClassHVs[j], 0); // Always use cosine similarity in retraining, because the
                                                                                 // Clipping is applied at the end of the retraining

                    // 1.2) Find the max/min similarity
                    estimated_class=0;

                    // Find class with max similarity
                    float max=0; int maxIndex;
                    for (int i = 0; i < DS_CLASSES_SIZE; i++) {
                        if (similarities[i] > max) {
                            max = similarities[i];
                            maxIndex = i;
                        }
                    }
                    estimated_class = maxIndex;


                    // 1.3) Update the Class HVs
                    if (estimated_class != actual_class)
                    {
                        corrections++;
                        if (learning_rate_decay==LR_DATA || learning_rate_decay==LR_HYBRID)
                        {
                            //learning_rate_data=int((similarities[estimated_class]-similarities[actual_class])*100000)
                            learning_rate_data = int((similarities[estimated_class]-similarities[actual_class])*100000);
                            if (learning_rate_data > lr_max)
                                learning_rate_data = lr_max;
                            
                            if (learning_rate_decay==LR_HYBRID)
                            {
                                learning_rate=(learning_rate+learning_rate_data)/2;
                                if (learning_rate > lr_max)
                                    learning_rate = lr_max;
                            }
                            else
                                learning_rate=learning_rate_data;
                        }

                        // Update the Class HVs
                        for (int i=0;i<HD_DIM;i++)
                        {
                            ClassHVs[actual_class].data[i] = ClassHVs[actual_class].data[i] + learning_rate*Encoded_HV.data[i];
                            ClassHVs[estimated_class].data[i] = ClassHVs[estimated_class].data[i] - learning_rate*Encoded_HV.data[i];
                        }
                        bundled_labels[actual_class] += 1*learning_rate;
                        bundled_labels[estimated_class] += 1*learning_rate;
                    } 
                }
                new_accuracy= predict(test_data,            // Test dataset
                                      test_labels,          // Test labels
                                      DS_CLASSES_SIZE,      // Number of classes
                                      quantized_levels,     // LevelList
                                      BaseHVs,              // BaseHVs
                                      LevelHVs,             // LevelHVs
                                      ClassHVs,             // ClassHVs
                                      CLIPPING_ENCODING,    // Clipping encoding (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                                      1,                    // Verbose
                                      N_GRAM,               // N-gram (0: no n-gram, 1: n-gram)
                                      N_GRAM_SIZE,          // N-gram size
                                      ENCODING_TECHNIQUE,   // Encoding technique (0: record-based, 1: ngram-based)
                                      1);                   // Retrain flag 
                if (verbose==1)
                    printf("Epoch: %d finished --> Corrections: %d, Accuracy: %f %%\n", iterations, corrections, new_accuracy);
                iterations++;

                if (new_accuracy > accuracy_before)
                {
                    if (verbose==1)
                        printf("Accuracy Improved --> Previous Accuracy: %f %%, New Accuracy: %f %%\n", accuracy_before, new_accuracy);
                    accuracy_before = new_accuracy;
                    best_epoch = iterations;
                    for (int i=0;i<DS_CLASSES_SIZE;i++)
                    {
                        best_ClassHVs[i] = ClassHVs[i];
                        best_bundled_labels[i] = bundled_labels[i];
                    }
                }

                error_rate[beta] = corrections*100/DS_TRAIN_SIZE;
                if (beta_lr!=1)
                    beta++;

            }
            
            printf("------------------RETRAINING RECAP----------------------\n");
            printf("Retraining finished -->\n Starting accuracy: %f \nBest obtained accuracy: %f %%\n", starting_accuracy, accuracy_before);
            printf("Best epoch: %d\n", best_epoch);
            for (int i=0;i<DS_CLASSES_SIZE;i++)
                best_ClassHVs[i] = clip(best_ClassHVs[i], quant_min, quant_max, clipping_class, best_bundled_labels[i]);
            printf("Applying clipping to ClassHVs and testing again...\n");

        }
};






