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
#define HD_DIM 10000                            // Hyper Dimensional Vector size
#define HD_DATA_TYPE 1                          // 0: binary, 1: bipolar
#define HV_ELEMENT_BIT_WIDTH 8                  // Hyper Dimensional Vector element width in elements
#define DENSE 1                                 // FLAG -> 1: dense HV, 0: sparse HV
#define SPARSITY 0.5                            // Sparsity of the HV (if DENSE == 0)
#define READ_HVs_FROM_FILE 0                    // FLAG -> 1: read base HVs from file, 0: generate random base HVs
#define HD_LV_LEN 20                            // Number of level vectors 
#define HD_LV_TYPE 0                            // 0: linear, 1: approximately linear, 2: thermometer encoding
#define CLIPPING_MODE 1                         // 0: no clipping, 1: binary/bipolar clipping, 2: ternary clipping, 3: quantization
#define CLIPPING_ENCODING 1                     // 0: no clipping, 1: binary/bipolar clipping, 2: ternary clipping, 3: quantization
#define DS_FEATURE_SIZE 4                       // Number of features
#define DS_TRAIN_SIZE 37206                     // Number of training samples
#define DS_TEST_SIZE  148831                    // Number of test samples
#define TRAIN_DATASET_NAME "SAMPL_DATA_1.csv"   // Dataset name (for reading the dataset from a file)
#define TEST_DATASET_NAME "TS_COMPLETE_1.csv"   // Dataset name (for reading the dataset from a file)
#define TRAIN_LABELS_NAME "L_SAMPL_DATA_1.csv"  // Dataset name (for reading the dataset from a file)
#define TEST_LABELS_NAME "L_TS_COMPLETE_1.csv"  // Dataset name (for reading the dataset from a file)
#define NUM_OF_CLASSES 6                        // Number of classes
#define DEBUG 1                                 // FLAG -> 1: print debug info, 0: don't print debug info
#define HD_DATA_W_elements 1
#ifndef TEST    
    #define TEST 2                             // Tests: 0: random HV, 1: BaseHV, 2: LevelHVs, 2: Binding, 3: Bundling, 4: Permutation
#endif  
#define PROCESSED_ELEMENTS 1000                   // Number of elements processed per iteration
#define VERBOSE_L2 0                           // FLAG -> 1: print debug info, 0: don't print debug info
#define BASE_HV_FILE_NAME "baseHV.txt"          // Base HVs file name
#define LEVEL_HV_FILE_NAME "levelHV.txt"        // Level HVs file name

// Hyper Dimensional Vector
template <int IN_DATA_WIDTH, int OUT_DATA_WIDTH, int LEN>class HDC
{
    public:
        int HV[HD_DIM];                        // Hyper Dimensional Vector


        // Constructor
        HDC()
        {   
            // The base constructur initializes the HV to all 1s or all -1s (according to the HD_DATA_TYPE)
            if (HD_DATA_TYPE == 1)                
                for (int i = 0; i < HD_DIM; i++)
                    HV[i] = -1;                     // Bipolar
            else
                for (int i = 0; i < HD_DIM; i++)
                    HV[i] = 0;                      // Binary
        }

        // Constructor
        HDC(int value)
        {
            for (int i = 0; i < HD_DIM; i++)
                HV[i] = value;                     
        }

        /**
         * @brief Generate a random HV, starting from starting_index to end_index
         * 
         * @param starting_index    Starting index
         * @param change_ratio      Number of elements to flip
         * @return int 
         */
        int random_HV(int starting_index,  int &change_ratio)  // Generate a random HV, starting from starting_index to end_index
        {
            int end_index = starting_index + PROCESSED_ELEMENTS;
            std::random_device rd;
            std::mt19937 gen(rd());
            std::uniform_int_distribution<int> dis(0, HD_DIM - 1);

            int max_change_ratio;
            if (DENSE == 0)
                max_change_ratio = HD_DIM * SPARSITY;          
            else
                max_change_ratio = HD_DIM / 2;       

            // Flipping random change_ratio elements
            for (int i = starting_index; i < end_index; i++)
            {
                if (change_ratio == max_change_ratio)
                    break;
                int index = dis(gen);
                if (HV[index] == -1 || HV[index] == 0)
                {
                    HV[index] = 1;
                    change_ratio++;
                    //printf("Flip bit %d\n", index);
                }
                
                
            }            
            return change_ratio;

        }

        void print_HV()
        {
            printf("= [");
            for (int i = 0; i < HD_DIM; i++)
                printf("%d ", HV[i]);
            printf("]\n");
        }

    // Assignment operator
    HDC& operator=(const HDC& other)
    {
        if (this == &other)
        {
            // If assigning to itself, just return *this (no need to do anything)
            return *this;
        }

        // Perform the assignment
        for (int i = 0; i < HD_DIM; i++)
        {
            this->HV[i] = other.HV[i];
        }

        // Return *this to allow for chained assignments (e.g., a = b = c)
        return *this;
    }

   

        // -----------------SIMILARITY--------------------
        // Computes the similarity between two HVs
        // that is Hamming distance for binary HVs
        // and cosine similarity for bipolar HVs.
        // This function is splitted in two phases
        // to allows element-wise similarity computation
        // Note that if you want to compute the dot product
        // as a similarity metric, you can just launch the 
        // first phase of the similarity function
        // --------------------------------------------------
        /**
         * @brief 
         * 
         * @param starting_index 
         * @param HV2 
         * @param sim 
         * @param denom_a 
         * @param denom_b 
         * @return float 
         */
        float similarity_phase1(int starting_index, HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS>  HV2, float &sim, float &denom_a, float &denom_b)
        {
            int end_index = starting_index + PROCESSED_ELEMENTS;
            if (HD_DATA_TYPE == 0)
            {
                for (int i = starting_index; i < end_index; i++) {
                    if (HV[i] != HV2.HV[i]) {
                        sim++;
                    }
                }
            }
            else
            {
                //printf("sim: %f, denom_a: %f, denom_b: %f\n", sim, denom_a, denom_b);
                // Cosine similarity using the formula: sim = (A*B)/(||A||*||B||)
                for (int i = starting_index; i < end_index; i++) {
                    sim += HV[i] * HV2.HV[i];
                    denom_a += HV[i] * HV[i];
                    denom_b += HV2.HV[i] * HV2.HV[i] ;
                }

            }
        }

        /**
         * @brief 
         * 
         * @param sim 
         * @param denom_a 
         * @param denom_b 
         * @return float 
         */
        float similarity_phase2(float &sim, float &denom_a, float &denom_b)
        {
            if (HD_DATA_TYPE == 0)
                sim = (sim) / HD_DIM;
            else
                sim = sim / (sqrt(denom_a) * sqrt(denom_b)) ;
        }


        // -----------------BUNDLING--------------------
        // Binding operator:
        //____________________________________________
        // Inputs:
        // starting_index: the starting index of the binding operation
        // HV1: the HV to be binded with the current HV
        // Binded_HV: the result of the binding operation
        // Output:
        // Binded_HV: the result of the binding operation
        //____________________________________________
        // For Binary HVs, the binding is just a XOR operation
        // For Bipolar HVs, the binding is a vector element-wise multiplication operation
        //____________________________________________
        /**
         * @brief 
         * 
         * @param starting_index 
         * @param HV1 
         * @param Binded_HV 
         * @return HDC 
         */
        HDC bind(int starting_index, HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS>  HV1, HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS>  Binded_HV)
        {
            int end_index = starting_index + PROCESSED_ELEMENTS;
            
            if (HD_DATA_TYPE == 0)
            {
                // Binary binding
                for (int i = starting_index; i < end_index ; i++)
                    Binded_HV.HV[i] = HV1.HV[i] ^ HV[i];
            }
            else
            {
                // Bipolar binding
                for (int i = starting_index; i < end_index ; i++)
                    Binded_HV.HV[i] = HV1.HV[i] * HV[i];
                //printf("processed elements: %d - %d\n", starting_index, end_index);
            }
            return Binded_HV;
        }


        // Bundling operator:
        // For Binary HVs, the bundling is just a OR operation
        // For Bipolar HVs, the bundling is a vector element-wise addition operation
        HDC bundle(int starting_index, HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS>  HV1,  HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS>Bundled_HV)
        {
            int end_index = starting_index + PROCESSED_ELEMENTS;
            // Bipolar bundling
            for (int i = starting_index; i < end_index ; i++)
                Bundled_HV.HV[i] = HV1.HV[i] + HV[i];

           // printf("processed elements: %d - %d\n", starting_index, end_index);

            return Bundled_HV;
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
        void clip(int min, int max, int clipping_type, int total_HVs, int starting_index)
        {
            int end_index = starting_index + PROCESSED_ELEMENTS;
            if (clipping_type==0) 
                printf("\e[93mClipping mode:\e[39m No clipping mode, integer output HVs\n");
            else if(clipping_type==1)
            {
                //printf("\e[93mClipping mode:\e[39m Binary clipping mode\n");
                if (HD_DATA_TYPE==0)
                {
                    std::random_device rd;
                    std::mt19937 gen(rd());
                    //printf("\e[93mClipping mode:\e[39m Majority voting based on the number of features\n");
                    // Binary clipping
                    for (int i=starting_index;i<end_index;i++)
                    {
                        if (HV[i]<total_HVs/2)
                            HV[i]=0;
                        else if (HV[i]>total_HVs/2)
                            HV[i]=1;
                        else
                        {
                            // Create a uniform distribution for integer values between 0 and HD_DIM-1
                            std::uniform_int_distribution<int>dis(0, 1);
                            HV[i] = dis(gen); // Randomly choose 0 or 1
                        }
                    }
                }
                else
                    // Bipolar clipping
                    for (int i=starting_index;i<end_index;i++)
                        if (HV[i]<=0)
                            HV[i]=-1;
                        else
                            HV[i]=1;   
            }
            else if(clipping_type==2)
            {
                printf("\e[93mClipping mode:\e[39m Ternary clipping mode\n");
                // Ternary clipping
                for (int i=starting_index;i<end_index;i++)
                    if (HV[i]<0)
                        HV[i]=-1;
                    else if (HV[i]>0)
                        HV[i]=1;
                    else
                        HV[i]=0;
            }
            else if(clipping_type==3)
            {
                printf("\e[93mClipping mode:\e[39m Quantized clipping mode\n");
                // Quantized clipping
                for (int i=starting_index;i<end_index;i++)
                    if (HV[i]<min)
                        HV[i]=min;
                    else if (HV[i]>max)
                        HV[i]=max;
            }
            else
                printf("ERROR: Invalid clipping mode!\n");
        }

};

// --------------------Base HVs----------------------
// Base Vectors: define the base vectors
// If READ_HVs_FROM_FILE == 1, the base vectors are read from a file
// If READ_HVs_FROM_FILE == 0, the base vectors are initialized randomly,
// by instantiating HV elements and flipping a number of elements equal to HD_DIM * SPARSITY
// --------------------------------------------------   
void generate_BaseHVs(int starting_index, HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> baseVectors[DS_FEATURE_SIZE], int &change_ratio)
{            
    if (READ_HVs_FROM_FILE == 1)
    {

        printf("Reading base vectors from file...\n");
        std::ifstream infile(BASE_HV_FILE_NAME);
        if (infile)
        {
            for (int i = 0; i < DS_FEATURE_SIZE; i++)
                for (int j = 0; j < HD_DIM; j++)
                    infile >> baseVectors[i].HV[j];
            infile.close();
        }
        else
            printf("\e[91mERROR:\e[39m Failed to open file for reading base vectors.\n");
    }
    else
    {              
        //printf("Generating random base vectors...\n");  
        // The base vectors are obtained randomly flipping a number of elements dependent on the sparsity
        int out_change_ratio=0;
        for (int vec = 0; vec < DS_FEATURE_SIZE; vec++)
        {
                out_change_ratio=change_ratio;
                out_change_ratio=baseVectors[vec].random_HV(starting_index,out_change_ratio);
                #if VERBOSE_L2==1
                    printf("Generated %d elements, change ratio: %d\n", PROCESSED_ELEMENTS, change_ratio);
                #endif
                if (vec==DS_FEATURE_SIZE-1)
                    change_ratio =out_change_ratio; 
        }
        
        #if VERBOSE_L2==1 
            printf("Done!\n");
            printf("Base vectors:\n");
            for (int vec = 0; vec < DS_FEATURE_SIZE; vec++)
            {
                printf("Base vector %d: ", vec);
                baseVectors[vec].print_HV();
            }
        #endif
    }
}

// --------------------Level HVs----------------------
// Level Vectors: define the level vectors
// If READ_HVs_FROM_FILE == 1, the level vectors are read from a file
// If READ_HVs_FROM_FILE == 0, the level vectors are initialized accoring to the HD_LV_TYPE,
// if HD_LV_TYPE == 0, the level vectors are initialized with the linear encoding
// if HD_LV_TYPE == 1, the level vectors are initialized with the approximately linearly encoding
// if HD_LV_TYPE == 2, the level vectors are initialized with the thermometer encoding
// --------------------------------------------------
/**
 * @brief 
 * 
 * @param starting_index 
 * @param LevelVectors 
 * @param level_id 
 * @param change_ratio 
 */
void generate_LevelVectors(int starting_index,HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> LevelVectors[DS_FEATURE_SIZE], int level_id, int &change_ratio, int *indexVector)
{          
      
    if (READ_HVs_FROM_FILE == 1)
    {
        printf("Reading Level vectors from file...\n");
        std::ifstream infile(LEVEL_HV_FILE_NAME);
        if (infile)
        {
            for (int i = 0; i < DS_FEATURE_SIZE; i++)
                for (int j = 0; j < HD_DIM; j++)
                    infile >> LevelVectors[i].HV[j];
            infile.close();
        }
        else
            printf("\e[91mERROR:\e[39m Failed to open file for reading Level vectors.\n");
    }
    else
    {

        #if VERBOSE_L2==1
            printf("Generating Level Vector [%d] using the ", level_id);
        #endif  
    
        if (HD_LV_TYPE == 0)
        {
            #if VERBOSE_L2==1
                printf("linear encoding...\n");
            #endif
   
            // Linear encoding
            // the first level vector is randomly initialized 
            if (level_id==0)
            {
                LevelVectors[0].random_HV(starting_index,change_ratio);
            }
            else
            {
                std::random_device rd;
                std::mt19937 gen(rd());
                std::uniform_int_distribution<int> dis(0, HD_DIM - 1);
                // The other level vectors are obtained flipping a number of elements equal to int(HD_DIM / (2 * totalLevel))
                // starting from the previous level vector. However, the same element can not be flipped 2 times              
                int max_change_ratio= HD_DIM / (2 * HD_LV_LEN);

                // Flipping random change_ratio elements
                int end_index = starting_index + PROCESSED_ELEMENTS;
                int count=0;
                while (count < PROCESSED_ELEMENTS)
                {
                    if (change_ratio > max_change_ratio)
                        break;
                    
                    int index = dis(gen);

                    if (indexVector[index] == 1)
                    {             
                        change_ratio++;   
                        indexVector[index] = 0;
                        if (HD_DATA_TYPE==0)
                            if (LevelVectors[level_id-1].HV[index] == 0)
                                LevelVectors[level_id].HV[index] = 1;
                            else
                                LevelVectors[level_id].HV[index] = 0;
                        else
                            if (LevelVectors[level_id-1].HV[index] == -1)
                                LevelVectors[level_id].HV[index] = 1;
                            else
                                LevelVectors[level_id].HV[index] = -1;

                    }
                    count++;

                    
                }     
                #if VERBOSE_L2==1
                    printf("Generated %d elements, change ratio: %d\n", PROCESSED_ELEMENTS, change_ratio);
                #endif

            }
        }
        else if (HD_LV_TYPE==1)
        {
            #if VERBOSE_L2==1
                printf("Approximately linear encoding.\n");
            #endif
            // Approximately linear encoding:
            // two random level vectors are initialized (the first and last one), and the other level vectors are obtained taking
            // int(np.ceil(D * (1 - level / totalLevel))) from the first level vector and
            // int(D-(D * (1 - level / totalLevel))) from the second level vector
            if (level_id==0 || level_id==HD_LV_LEN-1)
            {
                //printf("Generating the first level vector randomly\n");
                LevelVectors[level_id].random_HV(starting_index,change_ratio);
            }
            else
            {
                //printf("Generating the level vector %d\n",level_id);
                int fromFirst = int((HD_DIM * (1 - (float)level_id/HD_LV_LEN)));
                int fromSecond = HD_DIM - fromFirst;
                #if VERBOSE_L2==1
                printf("Level %d: %d elements from first vector, %d elements from second vector\n",level_id,fromFirst,fromSecond);
                #endif
                for (int i = starting_index; i < starting_index + PROCESSED_ELEMENTS; i++)
                {
                    if (i<fromFirst)
                        LevelVectors[level_id].HV[i] = LevelVectors[0].HV[i];
                    else
                        LevelVectors[level_id].HV[i] = LevelVectors[HD_LV_LEN-1].HV[i];                            

                }
            }                              
        }
        else if (HD_LV_TYPE==2)
        {
            #if VERBOSE_L2==1
                printf("Thermometer encoding.\n");
            #endif
            // Thermometer encoding:
            // the first level vector has all zero elements,
            // in the others intermediate levels, the first int((level + 1) * HD_DIM / (2 * HD_LV_LEN)) elements are set to 1
            // the last level vector has HD_DIM/2 elements set to 1

                for (int i = starting_index; i < starting_index + PROCESSED_ELEMENTS; i++)
                {
                    if (level_id == 0)
                        LevelVectors[level_id].HV[i] = 0;
                    else
                    {
                        if (i < int((level_id + 1) * HD_DIM / (2 * HD_LV_LEN)))
                            LevelVectors[level_id].HV[i] = 1;
                        else
                            if (HD_DATA_TYPE==0)
                                LevelVectors[level_id].HV[i] = 0;
                            else
                                LevelVectors[level_id].HV[i] = -1;
                            
                    }
                }
        }        
    }
    #if VERBOSE_L2 == 1
    printf("\e[92m----------\n\e[39m");
    #endif
}     

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
    for (int level = 0; level < levels; ++level) {
        LevelList[level] = min + level * gap;
    }
    LevelList[levels] = max;
}

// Function to get the quantized level for a given value
int get_quantized_level(float value, float quantization_levels[HD_LV_LEN], int levels) {
    for (int i = 0; i < levels; ++i) 
        if (value <= quantization_levels[i]) 
            return i - 1;

    return levels - 1;
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
HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> encoding(float FeatureVector[DS_FEATURE_SIZE], HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> BaseVectors[DS_FEATURE_SIZE], HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> LevelVectors[HD_LV_LEN], float LevelList[HD_LV_LEN])
{
    HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> Encoded_HV;
    #if VERBOSE_L2==1 
        printf("\e[92m----------\n\e[39m");
        printf("Encoding...\n");
        printf("Feature vector: ");
        for (int i = 0; i < DS_FEATURE_SIZE; i++)
            printf("%f ", FeatureVector[i]);
        printf("\n");
    #endif

    // 1) Compute the quantization level of each feature using get_quantized_level function
    int quantized_features[DS_FEATURE_SIZE];
    for (int i = 0; i < DS_FEATURE_SIZE; i++)
        quantized_features[i] = get_quantized_level(FeatureVector[i], LevelList, HD_LV_LEN);

    #if VERBOSE_L2==1
        printf("Quantized features: ");
        for (int i = 0; i < DS_FEATURE_SIZE; i++)
            printf("%d\n", quantized_features[i]);
    #endif
        
    // 2) BIND the level vector with the corresponding base vector (dependent by the number of the feature)
    HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> binded_feature[DS_FEATURE_SIZE];
    for (int i = 0; i < DS_FEATURE_SIZE; i++)
    {
        
        for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
        {
            binded_feature[i] = LevelVectors[quantized_features[i]].bind(j, BaseVectors[i],binded_feature[i]); // TODO CHANGE
            #if VERBOSE_L2==1
                printf("Binded %d elements\n", i+PROCESSED_ELEMENTS);
            #endif
        }
        #if VERBOSE_L2==1
            printf("Binding...\n");
            printf("Level vector %d: ", quantized_features[i]);
            for (int j = 0; j < HD_DIM; j++)
                printf("%d ", LevelVectors[quantized_features[i]].HV[j]);
            printf("\n");
            printf("Base vector %d: ", i);
            for (int j = 0; j < HD_DIM; j++)
                printf("%d ", BaseVectors[i].HV[j]);
            printf("\n");
            printf("Binded level vector %d with base vector %d: ", quantized_features[i], i);
        #endif
    }
    
    // 3) Bundle all the level vectors together to obtain the HDC vector representation of the input feature vector
    for (int i = 0; i < DS_FEATURE_SIZE; i++){
        for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
        {
            Encoded_HV = Encoded_HV.bundle(j,binded_feature[i],Encoded_HV); 

            #if VERBOSE_L2==1
                printf("Bundled %d elements\n", i+PROCESSED_ELEMENTS);  
            #endif
        }

        //printf("Bundled level vector %d\n", i);
    }

    #if VERBOSE_L2==1  
        printf("Encoded HV\n");
        Encoded_HV.print_HV();
    #endif

    // 4) Clip the HDC vector
    for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
    {
        Encoded_HV.clip(-1,1, CLIPPING_ENCODING,DS_FEATURE_SIZE,j);
    }


    #if VERBOSE_L2==1  
        printf("Clipped HV\n");
        Encoded_HV.print_HV();
        printf("Clipped\n");
    #endif
    // 4) Bundle all the level vectors together to obtain the HDC vector representation of the input feature vector
    return Encoded_HV;
}

// LOAD DATASET
// Function to load the dataset from a given file
// Input: filename
// Output: dataset (array of feature vectors)
void load_train_dataset(const std::string& filename, float dataset[DS_TRAIN_SIZE][DS_FEATURE_SIZE])
{
    std::ifstream file(filename);
    if (!file) {
        printf("\e[91mERROR:\e[39m Failed to open file '%s'\n", filename.c_str());
        return;
    }

    int row = 0;
    std::string line;
    while (std::getline(file, line) && row < DS_TRAIN_SIZE) {
        std::stringstream ss(line);
        std::string cell;

        int col = 0;
        while (std::getline(ss, cell, ',')) {
            try {
                float value = std::stof(cell);
                dataset[row][col] = value;
                col++;
            } catch (const std::exception& e) {
                printf("\e[91mERROR:\e[39m Unable to convert cell value '%s' to float.\n", cell.c_str());
                return;
            }
        }

        if (col != DS_FEATURE_SIZE) {
            printf("\e[91mERROR:\e[39m Inconsistent number of features in row %d\n", row + 1);
            printf("Expected %d, found %d\n", DS_FEATURE_SIZE, col); 
            return;
        }

        row++;
        //printf("Loaded row %d\n", row);
    }
    printf("Loaded %d samples with %d features each.\n", row, DS_FEATURE_SIZE);

    if (row != DS_TRAIN_SIZE) {
        printf("\e[91mERROR:\e[39m Inconsistent number of features in the dataset.\n");
        printf("Expected %d, found %d\n", DS_TRAIN_SIZE, row);
    } else {
        printf("\e[92mDataset loaded successfully.\e[39m\n");
    }
}

void load_test_dataset(const std::string& filename, float dataset[DS_TEST_SIZE][DS_FEATURE_SIZE])
{
    std::ifstream file(filename);
    if (!file) {
        printf("\e[91mERROR:\e[39m Failed to open file '%s'\n", filename.c_str());
        return;
    }

    int row = 0;
    std::string line;
    while (std::getline(file, line) && row < DS_TEST_SIZE) {
        std::stringstream ss(line);
        std::string cell;

        int col = 0;
        while (std::getline(ss, cell, ',')) {
            try {
                float value = std::stof(cell);
                dataset[row][col] = value;
                col++;
            } catch (const std::exception& e) {
                printf("\e[91mERROR:\e[39m Unable to convert cell value '%s' to float.\n", cell.c_str());
                return;
            }
        }

        if (col != DS_FEATURE_SIZE) {
            printf("\e[91mERROR:\e[39m Inconsistent number of features in row %d\n", row + 1);
            printf("Expected %d, found %d\n", DS_FEATURE_SIZE, col); 
            return;
        }

        row++;
        //printf("Loaded row %d\n", row);
    }
    printf("Loaded %d samples with %d features each.\n", row, DS_FEATURE_SIZE);

    if (row != DS_TEST_SIZE) {
        printf("\e[91mERROR:\e[39m Inconsistent number of features in the dataset.\n");
        printf("Expected %d, found %d\n", DS_TEST_SIZE, row);
    } else {
        printf("\e[92mDataset loaded successfully.\e[39m\n");
    }
}



void load_train_labels(const std::string& filename, int labels[DS_TRAIN_SIZE])
{
    std::ifstream file(filename);
    if (!file) {
        printf("\e[91mERROR:\e[39m Failed to open file '%s'\n", filename.c_str());
        return;
    }

    int idx = 0;
    std::string line;
    while (std::getline(file, line) && idx < DS_TRAIN_SIZE) {
        try {
            int label = std::stoi(line); // Corrected: Use stoi for integer conversion
            labels[idx] = label;
            //printf("Loaded label %d, label: %d\n", labels[idx],label);
            idx++;
            
        } catch (const std::exception& e) {
            printf("\e[91mERROR:\e[39m Unable to convert label value '%s' to integer.\n", line.c_str());
            return;
        }
    }

    if (idx != DS_TRAIN_SIZE) {
        printf("\e[91mERROR:\e[39m Inconsistent number of labels in the file.\n");
        printf("Expected %d, found %d\n", DS_TRAIN_SIZE, idx);
    } else {
        printf("\e[92mLabels loaded successfully.\e[39m\n");
    }
}

void load_test_labels(const std::string& filename, int labels[DS_TEST_SIZE])
{
    std::ifstream file(filename);
    if (!file) {
        printf("\e[91mERROR:\e[39m Failed to open file '%s'\n", filename.c_str());
        return;
    }

    int idx = 0;
    std::string line;
    while (std::getline(file, line) && idx < DS_TEST_SIZE) {
        try {
            float label = std::stoi(line);
            labels[idx] = label;
            idx++;
        } catch (const std::exception& e) {
            printf("\e[91mERROR:\e[39m Unable to convert label value '%s' to float.\n", line.c_str());
            return;
        }
    }

    if (idx != DS_TEST_SIZE) {
        printf("\e[91mERROR:\e[39m Inconsistent number of labels in the file.\n");
        printf("Expected %d, found %d\n", DS_TEST_SIZE, idx);
    } else {
        printf("\e[92mLabels loaded successfully.\e[39m\n");
    }
}


// // -------------------------------------------MAIN--------------------------------------------------------
// main function that contains many tests:
// 0. generate random HVs and compute the similarity between them, (PROCESSED_ELEMENTS) per time
// 1. Generate (NUM_BASE_HVs) BaseHVs, (PROCESSED_ELEMENTS) per time
// 2. Generate NUM_LV_HVs LVs, (PROCESSED_ELEMENTS) per time. Linear encoding, approximate encoding, thermometer encoding
// 3. Generate two random HVs, bind them and compute the similarity, (PROCESSED_ELEMENTS) per time
// 4. Generate two random HVs, bundle them and compute the similarity, (PROCESSED_ELEMENTS) per time
// 5. Given an input feature vector, encode it into a hypervector, (PROCESSED_ELEMENTS) per time
// 6. Dataset loads
// 7. Complete classification procedure in the Hyperspace. Dataset load, encoding, train, inference, performance evaluation, (PROCESSED_ELEMENTS) per time
// ---------------------------------------------------------------------------------------------------------------
int main()
{

    #if TEST==0 
        printf("\e[93m------------------\e[39m\n");
        printf("\e[93mHypervector generation TEST\e[39m\n");
        printf("\e[93m------------------\e[39m\n");

        //--------------------------------------------------------------------------------
        // generate a random hypervector, HV1. PROCESSED_ELEMENTS elements are generated per iteration
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> HV1;
        printf("Generating random HV1, %d elements per time\n", PROCESSED_ELEMENTS);
        int change_ratio = 0;
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            change_ratio = HV1.random_HV(i,change_ratio);
            #if VERBOSE_L2==1
                printf("Generated %d elements, change ratio: %d\n", i+PROCESSED_ELEMENTS, change_ratio);
            #endif
        }
        printf("Generated HV1\n");
        HV1.print_HV();
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        // generate a random hypervector, HV2. PROCESSED_ELEMENTS elements are generated per iteration
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> HV2;
        printf("Generating random HV2, %d elements per time\n", PROCESSED_ELEMENTS);
        change_ratio = 0;
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            change_ratio = HV2.random_HV(i,change_ratio);
            #if VERBOSE_L2==1
                printf("Generated %d elements, change ratio: %d\n", i+PROCESSED_ELEMENTS, change_ratio);
            #endif
        }
        printf("Generated HV2\n");
        HV2.print_HV();
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        // compute the similarity between HV1 and HV2. PROCESSED_ELEMENTS elements are processed per iteration
        printf("Computing the similarity measure:\n");
        printf("Running Similarity phase 1\n");
        float similarity=0, denom_a=0,denom_b=0;
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            HV1.similarity_phase1(i, HV2, similarity, denom_a, denom_b);
            #if VERBOSE_L2==1
                printf("Processed %d elements\n", i+PROCESSED_ELEMENTS);
                printf("Similarity: %f, denom_a:%f, denom_b:%f\n", similarity, denom_a, denom_b);
            #endif
        }
        printf("Running Similarity phase 2\n");
        HV1.similarity_phase2(similarity, denom_a, denom_b);

        printf("Similarity between HV1 and HV2: %f\n", similarity);
        //--------------------------------------------------------------------------------

    #elif TEST==1
    
        printf("\e[93m------------------\e[39m\n");
        printf("\e[93mBASE VECTOR TEST\e[39m\n");
        printf("\e[93m------------------\e[39m\n");

        //--------------------------------------------------------------------------------
        // Base vector generation. PROCESSED_ELEMENTS elements are generated per iteration
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> BaseVectors[DS_FEATURE_SIZE];
    
        int change_ratio = 0;
        for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
        {
            generate_BaseHVs(j, BaseVectors, change_ratio);
            #if VERBOSE_L2==1
                printf("Generating random Base Vectors, %d elements per time\n", PROCESSED_ELEMENTS);
            #endif
        }
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        // compute the similarity between base vector 0 and the rest. PROCESSED_ELEMENTS elements are processed per iteration
        float sim=0, denom_a=0.0, denom_b=0.0;
        for (int i = 1; i < DS_FEATURE_SIZE; i++)
        {
            // Computing the similarity:
            for (int j = 0; j < HD_DIM; j+=PROCESSED_ELEMENTS)
            {
                BaseVectors[0].similarity_phase1(j,BaseVectors[i], sim, denom_a, denom_b);
                #if VERBOSE_L2==1
                    printf("Processed %d elements\n", j+PROCESSED_ELEMENTS);
                #endif
                
            }
            BaseVectors[0].similarity_phase2(sim, denom_a, denom_b);

            printf("Similarity between base vector 0 and %d: %f\n", i, sim);
        }
        //--------------------------------------------------------------------------------

    #elif TEST==2

        printf("\e[93m------------------\e[39m\n");
        printf("\e[93mLEVEL VECTOR TEST\e[39m\n");
        printf("\e[93m------------------\e[39m\n");

        //--------------------------------------------------------------------------------
        // Level vector generation. PROCESSED_ELEMENTS elements are generated per iteration
        // The test can work with any number of levels (HD_LV_LEN), and any level-generation technique (HD_LV_TYPE)
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> LevelVectors[HD_LV_LEN];
        
        int change_ratio = 0;
        int indexVector[HD_DIM]={1};
        
        printf("Generating Level Hyper Vectors, \e[93m%d\e[39m elements per time...", PROCESSED_ELEMENTS);
        #if HD_LV_TYPE==0
            printf("using the \e[92mLinear Encoding\e[39m\n");
        #elif HD_LV_TYPE==1
            printf("using the \e[92mApproximately Linear Encoding\e[39m\n");
        #else
            printf("using the \e[92mTermometer Encoding\e[39m\n");
        #endif
        printf("\n\n");
        for (int i=0;i<HD_DIM;i++)
            indexVector[i]=1;
        
        #if HD_LV_TYPE == 1
            // The first and the last level vectors are generated for first
            // in a random way
            change_ratio = 0; 
            for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
                generate_LevelVectors(0, LevelVectors, 0, change_ratio, indexVector);
            
            change_ratio = 0; 
            for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
                generate_LevelVectors(0, LevelVectors, HD_LV_LEN-1, change_ratio, indexVector);

            // The rest of the level vectors are generated in a linear way
            for (int i=1;i<HD_LV_LEN-1;i++)
            {
                for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
                    generate_LevelVectors(j, LevelVectors, i, change_ratio, indexVector);
            }
        #else            
            for (int i=0;i<HD_LV_LEN;i++)
            {
                change_ratio = 0;   
                #if VERBOSE_L2==1
                    printf("Generating Level Vectors, %d elements per time\n", PROCESSED_ELEMENTS);
                #endif
                for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS) // Note, in the case of linear one the loop has to continue until the change ratio is complete            
                    generate_LevelVectors(j, LevelVectors, i, change_ratio, indexVector);
                
                #if HD_LV_TYPE==0    
                    if (i<HD_LV_LEN-1)
                        LevelVectors[i+1] = LevelVectors[i];
                #endif
            }
        #endif
        //--------------------------------------------------------------------------------


        //--------------------------------------------------------------------------------
        // compute the similarity between each level vector. PROCESSED_ELEMENTS elements are processed per iteration
        float similarity[HD_LV_LEN][HD_LV_LEN]={0.0};
        float denom_a[HD_LV_LEN][HD_LV_LEN]={0.0};
        float denom_b[HD_LV_LEN][HD_LV_LEN]={0.0};
        printf("similarities = [");
        for (int i = 0; i < HD_LV_LEN; i++)
        {
            printf("[");

            for (int j = 0; j < HD_LV_LEN; j++)
            {

                // Computing the similarity:
                for (int k = 0; k < HD_DIM; k+=PROCESSED_ELEMENTS)
                {
                    LevelVectors[i].similarity_phase1(k,LevelVectors[j], similarity[i][j], denom_a[i][j], denom_b[i][j]);
                    //printf("Processed %d elements\n", j+PROCESSED_ELEMENTS);
                }
                LevelVectors[i].similarity_phase2(similarity[i][j], denom_a[i][j], denom_b[i][j]);
                if (j!=HD_LV_LEN-1)
                    printf("%f,", similarity[i][j]);
                else
                    printf("%f", similarity[i][j]);
            }
            printf("]\n");
        }
        printf("]\n");
        //--------------------------------------------------------------------------------

    #elif TEST==3
        
        //Testing the binding
        printf("\e[93m------------------\e[39m\n");
        printf("\e[93mBINDING TEST\e[39m\n");
        printf("\e[93m------------------\e[39m\n");

        //--------------------------------------------------------------------------------
        // Generating the HV1 and HV2, PROCESSED_ELEMENTS elements are generated per iteration
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> HV1;
        printf("1. Generating random HV1, %d elements per time\n", PROCESSED_ELEMENTS);
        int change_ratio = 0;
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            change_ratio = HV1.random_HV(i,change_ratio);
            #if VERBOSE_L2==1
            printf("Generated %d elements, change ratio: %d\n", i+PROCESSED_ELEMENTS, change_ratio);
            #endif
        }
        #if VERBOSE_L2==1
        printf("Generated HV1\n");
        HV1.print_HV();
        #endif


        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> HV2;
        printf("2. Generating random HV2, %d elements per time\n", PROCESSED_ELEMENTS);
        change_ratio = 0;
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            change_ratio = HV2.random_HV(i,change_ratio);
            #if VERBOSE_L2==1
            printf("Generated %d elements, change ratio: %d\n", i+PROCESSED_ELEMENTS, change_ratio);
            #endif
        }
        #if VERBOSE_L2==1
        printf("Generated HV2\n");
        HV2.print_HV();
        #endif
        //--------------------------------------------------------------------------------

        
        //--------------------------------------------------------------------------------
        // Binding the HV1 and HV2, PROCESSED_ELEMENTS elements are binded per iteration
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> binded_HV;
        printf("3. Binding HV1 and HV2, %d elements per time\n", PROCESSED_ELEMENTS);
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            binded_HV= HV1.bind(i,HV2,binded_HV);
            #if VERBOSE_L2==1
                printf("Binded %d elements\n", i+PROCESSED_ELEMENTS);
            #endif
        }
        #if VERBOSE_L2==1
            printf("Binded HV\n");
            binded_HV.print_HV();
        #endif
        printf("\n\nComputing the similarity measure:\n");
        printf("Running Similarity phase 1\n");
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        // Computing the similarity measure, PROCESSED_ELEMENTS elements are processed per iteration
        float similarity=0, denom_a=0,denom_b=0;
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            binded_HV.similarity_phase1(i, HV1, similarity, denom_a, denom_b);
            #if VERBOSE_L2==1
                printf("Processed %d elements\n", i+PROCESSED_ELEMENTS);
                printf("Similarity: %f, denom_a:%f, denom_b:%f\n", similarity, denom_a, denom_b);
            #endif
        }
        printf("Running Similarity phase 2\n");
        binded_HV.similarity_phase2(similarity, denom_a, denom_b);
        printf("Similarity between Binded_HV and HV1: %f\n", similarity);
        //--------------------------------------------------------------------------------
    #elif TEST==4
        // Testing the bundling    
        printf("\e[93m------------------\e[39m\n");
        printf("\e[93mBUNDLING TEST\e[39m\n");
        printf("\e[93m------------------\e[39m\n");

        //--------------------------------------------------------------------------------
        // Generating the HV1 and HV2, PROCESSED_ELEMENTS elements are generated per iteration
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> HV1;
        printf("1. Generating random HV1, %d elements per time\n", PROCESSED_ELEMENTS);
        int change_ratio = 0;
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            change_ratio = HV1.random_HV(i,change_ratio);
            #if VERBOSE_L2==1
            printf("Generated %d elements, change ratio: %d\n", i+PROCESSED_ELEMENTS, change_ratio);
            #endif
        }

        #if VERBOSE_L2==1
            printf("Generated HV1\n");
            HV1.print_HV();
        #endif

        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> HV2;
        printf("2. Generating random HV2, %d elements per time\n", PROCESSED_ELEMENTS);
        change_ratio = 0;
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            change_ratio = HV2.random_HV(i,change_ratio);
            #if VERBOSE_L2==1
                printf("Generated %d elements, change ratio: %d\n", i+PROCESSED_ELEMENTS, change_ratio);
            #endif
        }
        #if VERBOSE_L2==1
            printf("Generated HV2\n");
            HV2.print_HV();
        #endif
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        // Bundling the HV1 and HV2, PROCESSED_ELEMENTS elements are bundled per iteration
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> bundled_HV;
        printf("3. Bundling HV1 and HV2, %d elements per time\n", PROCESSED_ELEMENTS);
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            bundled_HV= HV1.bundle(i,HV2,bundled_HV);
            #if VERBOSE_L2==1
               printf("Bundled %d elements\n", i+PROCESSED_ELEMENTS);  
            #endif
        }
        #if VERBOSE_L2==1
            printf("bundled HV\n");
            bundled_HV.print_HV();
        #endif
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        // Clipping the bundled HV, PROCESSED_ELEMENTS elements are clipped per iteration
        int total_HVs=2;
        printf("4. Clipping the bundled HV, %d elements per time\n", PROCESSED_ELEMENTS);
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            bundled_HV.clip(0,1,CLIPPING_ENCODING,total_HVs, i);
        }
        
        #if VERBOSE_L2==1
            printf("bundled HV after clipping\n");
            bundled_HV.print_HV();
        #endif
        //--------------------------------------------------------------------------------
        
        //--------------------------------------------------------------------------------
        // Computing the similarity measure, PROCESSED_ELEMENTS elements are processed per iteration
        printf("\n\nComputing the similarity measure:\n");
        printf("Running Similarity phase 1\n");
        float similarity=0, denom_a=0,denom_b=0;
        for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
        {
            bundled_HV.similarity_phase1(i, HV1, similarity, denom_a, denom_b);
            #if VERBOSE_L2==1
                printf("Processed %d elements\n", i+PROCESSED_ELEMENTS);
                printf("Similarity: %f, denom_a:%f, denom_b:%f\n", similarity, denom_a, denom_b);
            #endif
        }
        printf("Running Similarity phase 2\n");
        bundled_HV.similarity_phase2(similarity, denom_a, denom_b);
        printf("Similarity between Bundled_V and HV1: %f\n", similarity);
        //--------------------------------------------------------------------------------

        
    #elif TEST==5
        
        printf("\e[93m----------------\nENCODING TEST\n----------------\n\e[39m");

        //--------------------------------------------------------------------------------
        // Generating the quantization levels
        float FeatureVector[DS_FEATURE_SIZE] = {10.0957,    0.6670,    3.0207,    1.2709};
        float LevelList[HD_LV_LEN];
        generate_quantization_levels(0, 21, HD_LV_LEN, LevelList);
        printf("1. Level List generated \n");
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        // BASE VECTORS GENERATION
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> BaseVectors[DS_FEATURE_SIZE];
        int change_ratio = 0;
        for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
        {
            generate_BaseHVs(j, BaseVectors, change_ratio);
            #if VERBOSE_L2==1
                printf("Generating random Base Vectors, %d elements per time\n", PROCESSED_ELEMENTS);
            #endif
        }
        printf("2. Base Vectors generated \n");
        //--------------------------------------------------------------------------------


        //--------------------------------------------------------------------------------
        // LEVEL VECTORS GENERATION
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> LevelVectors[HD_LV_LEN];
        change_ratio = 0; int indexVector[HD_DIM]={1};
        for (int i=0;i<HD_DIM;i++)
            indexVector[i]=1;
        for (int i=0;i<HD_LV_LEN;i++)
        {
            change_ratio = 0;   
            #if VERBOSE_L2==1
                printf("Generating Level Vectors, %d elements per time\n", PROCESSED_ELEMENTS);
            #endif
            for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS) // Note, in the case of linear one the loop has to continue until the change ratio is complete            
                generate_LevelVectors(j, LevelVectors, i, change_ratio, indexVector);
            
            #if HD_LV_TYPE==0    
                if (i<HD_LV_LEN-1)
                    LevelVectors[i+1] = LevelVectors[i];
            #endif
        }
        printf("3. Level Vectors generated \n");
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        // ENCODING
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> Encoded_HV;
        Encoded_HV = encoding(FeatureVector, BaseVectors, LevelVectors, LevelList);
        printf("4. Encoded HV: ");
        Encoded_HV.print_HV();
        printf("\n");
        //--------------------------------------------------------------------------------

    #elif TEST==6
        printf("\e[93m------------------\e[39m\n");
        printf("\e[93mLOAD DATASET TEST\e[39m\n");
        printf("\e[93m------------------\e[39m\n");
        float dataset[DS_TRAIN_SIZE][DS_FEATURE_SIZE];
        load_train_dataset(TRAIN_DATASET_NAME, dataset);
        int printed_rows = 2;
        int printed_columns = 5;
        printf("Dataset, first %d rows and %d cols \n", printed_rows, printed_columns);
        for (int i = 0; i < printed_rows; i++)
        {
            printf("[");
            for (int j = 0; j < printed_columns; j++)
            {
                if (j==DS_TRAIN_SIZE-1)
                    printf("%f", dataset[i][j]);
                else
                    printf("%f,", dataset[i][j]);
            }
            printf("]\n");
        }        
    #elif TEST==7
        
        printf("\e[93m------------------\e[39m\n");
        printf("\e[93mClassification TEST\e[39m\n");
        printf("\e[93m------------------\e[39m\n");

        //--------------------------------------------------------------------------------
        // Generating the quantization levels
        float LevelList[HD_LV_LEN];
        generate_quantization_levels(0, 21, HD_LV_LEN, LevelList);
        //--------------------------------------------------------------------------------

        //--------------------------------------------------------------------------------
        // DATASET LOAD
        printf("Level list generated.\n");
        float train_dataset[DS_TRAIN_SIZE][DS_FEATURE_SIZE];
        load_train_dataset(TRAIN_DATASET_NAME, train_dataset);
        printf("Train dataset loaded.\n");

        float test_dataset[DS_TEST_SIZE][DS_FEATURE_SIZE];
        load_test_dataset(TEST_DATASET_NAME, test_dataset);
        printf("Test dataset loaded.\n");

        int train_labels[DS_TRAIN_SIZE]={0};
        load_train_labels(TRAIN_LABELS_NAME, train_labels);
        printf("Train labels loaded.\n");

        int test_labels[DS_TEST_SIZE];
        load_test_labels(TEST_LABELS_NAME, test_labels);
        printf("Test labels loaded.\n");
        //--------------------------------------------------------------------------------


        //--------------------------------------------------------------------------------
        // BASE VECTORS GENERATION
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> BaseVectors[DS_FEATURE_SIZE];
        int change_ratio = 0;
        for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
        {
            generate_BaseHVs(j, BaseVectors, change_ratio);
            #if VERBOSE_L2==1
                printf("Generating random Base Vectors, %d elements per time\n", PROCESSED_ELEMENTS);
            #endif
        }
        printf("2. Base Vectors generated \n");
        //--------------------------------------------------------------------------------


        //--------------------------------------------------------------------------------
        // LEVEL VECTORS GENERATION
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> LevelVectors[HD_LV_LEN];
        change_ratio = 0; int indexVector[HD_DIM]={1};
        for (int i=0;i<HD_DIM;i++)
            indexVector[i]=1;
        for (int i=0;i<HD_LV_LEN;i++)
        {
            change_ratio = 0;   
            #if VERBOSE_L2==1
                printf("Generating Level Vectors, %d elements per time\n", PROCESSED_ELEMENTS);
            #endif
            for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS) // Note, in the case of linear one the loop has to continue until the change ratio is complete            
                generate_LevelVectors(j, LevelVectors, i, change_ratio, indexVector);
            
            #if HD_LV_TYPE==0    
                if (i<HD_LV_LEN-1)
                    LevelVectors[i+1] = LevelVectors[i];
            #endif
        }
        printf("3. Level Vectors generated \n");
        //--------------------------------------------------------------------------------


        //--------------------------------------------------------------------------------
        // TRAINING
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> Encoded_HV;
        HDC<HD_DATA_W_elements,HD_DATA_W_elements,PROCESSED_ELEMENTS> ClassHVs[NUM_OF_CLASSES+1];

        // ClassHVs initialization
        for (int i = 0; i < NUM_OF_CLASSES+1; i++)
        {
            for (int j = 0; j < HD_DIM; j++)
                ClassHVs[i].HV[j]=0;
        }

        // Iterative procedure: each input feature vector is encoded and added to the corresponding class HV
        // The class HVs are then normalized. PROCESSED_ELEMENTS are processed per iteration 
        int bundled_vectors[NUM_OF_CLASSES+1]={0};
        for (int i = 0; i < DS_TRAIN_SIZE; i++)
        {

            if(i%(DS_TRAIN_SIZE/20)==0)
                printf("Train dataset encoded percentage: %.2f%%\n", ceil((float)i/DS_TRAIN_SIZE*100));
            Encoded_HV = encoding(train_dataset[i], BaseVectors, LevelVectors, LevelList);
            #if VERBOSE_L2==1
                printf("Encoded HV: ");
                Encoded_HV.print_HV();
                printf("i:%d, Train label: %d\n",i, train_labels[i]);
            #endif

            for (int j=0;j<HD_DIM;j+=PROCESSED_ELEMENTS)
                ClassHVs[train_labels[i]]=ClassHVs[train_labels[i]].bundle(j,Encoded_HV,ClassHVs[train_labels[i]]);
            
            // count the number of encodedhv for each class
            bundled_vectors[train_labels[i]]++;
            
            #if VERBOSE_L2==1 
                printf("Class HV[%d]: ", train_labels[i]);
                ClassHVs[train_labels[i]].print_HV();
            #endif

        }
        printf("Train dataset encoded.\n");

        // Clipping
        for (int i = 1; i < NUM_OF_CLASSES+1; i++)
            for (int j = 0; j < HD_DIM; j+=PROCESSED_ELEMENTS)
                ClassHVs[i].clip(-1,1, CLIPPING_MODE,bundled_vectors[i],j);
        printf("Train dataset clipped.\n");

        #if VERBOSE_L2==1
            printf("Class HVs: \n");
            for (int i = 0; i < NUM_OF_CLASSES+1; i++)
            {
                printf("Class %d: ", i);
                ClassHVs[i].print_HV();
            }
        #endif
        //--------------------------------------------------------------------------------



        //--------------------------------------------------------------------------------
        // Classification
        int correct = 0;
        int predicted_label;
        float similarity;
        float top_similarity;
        for (int i = 0; i < DS_TEST_SIZE; i++)
        {
            if(i%(DS_TEST_SIZE/20)==0)
                printf("Test dataset classified percentage: %.2f%%\n", ceil((float)i/DS_TEST_SIZE*100));
            Encoded_HV = encoding(test_dataset[i], BaseVectors, LevelVectors, LevelList);
            predicted_label = 0;
            if (HD_DATA_TYPE==1)
            {
                similarity=0;
                top_similarity=0;
            }
            else
            {
                similarity=1;
                top_similarity=1;
            }
            //printf("similarity[0]: %f\n",similarity);
            for (int j = 1; j < NUM_OF_CLASSES; j++)
            {
                // SIMILARITY CALCULATION
                float similarity=0, denom_a=0,denom_b=0;
                for (int i=0;i<HD_DIM;i+=PROCESSED_ELEMENTS)
                {
                    ClassHVs[j].similarity_phase1(i, Encoded_HV, similarity, denom_a, denom_b);
                    #if VERBOSE_L2==1
                        printf("Processed %d elements\n", i+PROCESSED_ELEMENTS);
                        printf("Similarity: %f, denom_a:%f, denom_b:%f\n", similarity, denom_a, denom_b);
                    #endif
                }
                ClassHVs[j].similarity_phase2(similarity, denom_a, denom_b);


                //printf("similarity[%d]: %f\n",j, similarity);
                if (HD_DATA_TYPE==1)
                {
                    if (similarity > top_similarity)
                    {
                        top_similarity = similarity;
                        predicted_label = j;
                    }
                }
                else
                {
                    if (similarity < top_similarity)
                    {
                        top_similarity = similarity;
                        predicted_label = j;
                    }
                }
            }
            if (predicted_label == test_labels[i])
                correct++;
            
            #if VERBOSE_L2==1  
                printf("Predicted label: %d --- ", predicted_label);
                printf("Actual label: %d\n", test_labels[i]);
            #endif
        }
        printf("Test dataset classified.\n");
        printf("Accuracy: %.2f%%\n", (float)correct/DS_TEST_SIZE*100);
        //--------------------------------------------------------------------------------
    #endif
    
    return 0;
}
