/*Copyright 2024 Sapienza University of Rome

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
Authors: Marco Angioli & Saeid Jamili
*/

    
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
#define HV_SIZE 10000                           // Hyper Dimensional Vector size
#define HV_TYPE 1                               // 0: binary, 1: bipolar
#define HV_ELEMENT_BIT_WIDTH 8                  // Hyper Dimensional Vector element width in bits
#define DENSE 1                                 // FLAG -> 1: dense HV, 0: sparse HV
#define SPARSITY 0.5                            // Sparsity of the HV (if DENSE == 0)
#define READ_HVs_FROM_FILE 0                    // FLAG -> 1: read base HVs from file, 0: generate random base HVs
#define NUM_BASE_VECTORS 4                     // Number of base vectors 
#define NUM_LEVEL_VECTORS 20                    // Number of level vectors 
#define LEVEL_VECTOR_TECHNIQUE 0                // 0: linear, 1: approximately linear, 2: thermometer encoding
#ifndef TEST    
    #define TEST 3                              // Tests: 0: random HV, 1: BaseHV, 2: LevelHVs, 2: Binding, 3: Bundling, 4: Permutation
#endif  
#define CLIPPING_MODE 1                         // 0: no clipping, 1: binary/bipolar clipping, 2: ternary clipping, 3: quantization
#define CLIPPING_ENCODING 1                     // 0: no clipping, 1: binary/bipolar clipping, 2: ternary clipping, 3: quantization
#define NUM_OF_FEATURES 4                       // Number of features
#define NUM_OF_TRAIN_SAMPLES 37206                 // Number of training samples
#define NUM_OF_TEST_SAMPLES  148831              // Number of test samples
#define TRAIN_DATASET_NAME "SAMPL_DATA_1.csv"   // Dataset name (for reading the dataset from a file)
#define TEST_DATASET_NAME "TS_COMPLETE_1.csv"   // Dataset name (for reading the dataset from a file)
#define TRAIN_LABELS_NAME "L_SAMPL_DATA_1.csv"  // Dataset name (for reading the dataset from a file)
#define TEST_LABELS_NAME "L_TS_COMPLETE_1.csv"  // Dataset name (for reading the dataset from a file)
#define NUM_OF_CLASSES 6                        // Number of classes
#define DEBUG 0                                 // FLAG -> 1: print debug info, 0: don't print debug info


// TODO: replace all the int8_t with HV_element on HLS
// Hyper Dimensional Vector element
struct HV_element {
    unsigned int data : HV_ELEMENT_BIT_WIDTH;    // HV_ELEMENT_BIT_WIDTH-bit data (anonymous field, no name)
};


// Hyper Dimensional Vector
class HDC
{
    public:
        int HV[HV_SIZE];                        // Hyper Dimensional Vector


        // Constructor
        HDC()
        {
            // The base constructur initializes the HV to all 1s or all -1s (according to the HV_TYPE)
            if (HV_TYPE == 1)                
                for (int i = 0; i < HV_SIZE; i++)
                    HV[i] = -1;                     // Bipolar
            else
                for (int i = 0; i < HV_SIZE; i++)
                    HV[i] = 0;                      // Binary
        }

        // Constructor
        HDC(int value)
        {
            for (int i = 0; i < HV_SIZE; i++)
                HV[i] = value;                     
        }

        void random_HV()
        {
            std::random_device rd;
            std::mt19937 gen(rd());
            // Create a uniform distribution for integer values between 0 and HV_SIZE-1
            std::uniform_int_distribution<int> dis(0, HV_SIZE - 1);


            int change_ratio;
            if (DENSE == 0)
                change_ratio = HV_SIZE * SPARSITY;          
            else
                change_ratio = HV_SIZE / 2;                 

            // Flipping random change_ratio bits
            for (int i = 0; i < change_ratio; i++)
            {
                int index = dis(gen);
                HV[index] = 1;
            }                

        }

        void print_HV()
        {
            printf("= [");
            for (int i = 0; i < HV_SIZE; i++)
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
        for (int i = 0; i < HV_SIZE; i++)
        {
            this->HV[i] = other.HV[i];
        }

        // Return *this to allow for chained assignments (e.g., a = b = c)
        return *this;
    }

   

        // -----------------SIMILARITY--------------------
        // Computes the similarity between two HVs
        // that is Hamming distance for binary HVs
        // and cosine similarity for bipolar HVs
        // --------------------------------------------------
        float similarity(HDC HV2)
        {
            float sim = 0;
            if (HV_TYPE == 0)
            {
            int hammingDistance = 0;
                for (int i = 0; i < HV_SIZE; i++) {
                    if (HV[i] != HV2.HV[i]) {
                        hammingDistance++;
                    }
                }
                sim = (float)(hammingDistance) / HV_SIZE;

            }
            else
            {
                // Cosine similarity using the formula: sim = (A*B)/(||A||*||B||)
                float dot = 0.0, denom_a = 0.0, denom_b = 0.0 ;
                for (int i = 0; i < HV_SIZE; i++)
                {
                    dot += HV[i] * HV2.HV[i] ;
                    denom_a += HV[i] * HV[i] ;
                    denom_b += HV2.HV[i] * HV2.HV[i] ;
                }
                sim = dot / (sqrt(denom_a) * sqrt(denom_b)) ;
            }
        return sim;
        }



        // Binding operator:
        // For Binary HVs, the binding is just a XOR operation
        // For Bipolar HVs, the binding is a vector element-wise multiplication operation
        HDC bind(HDC HV1)
        {
            HDC Binded_HV;
            if (HV_TYPE == 0)
            {
                // Binary binding
                for (int i = 0; i < HV_SIZE; i++)
                    Binded_HV.HV[i] = HV1.HV[i] ^ this->HV[i];
            }
            else
            {
                // Bipolar binding
                for (int i = 0; i < HV_SIZE; i++)
                    Binded_HV.HV[i] = HV1.HV[i] * this->HV[i];
            }
            return Binded_HV;
        }


        // Bundling operator:
        // For Binary HVs, the bundling is just a OR operation
        // For Bipolar HVs, the bundling is a vector element-wise addition operation
        HDC bundle(HDC HV1)
        {
            HDC Bundled_HV;

            // Bipolar bundling
            for (int i = 0; i < HV_SIZE; i++)
                Bundled_HV.HV[i] = HV1.HV[i] + this->HV[i];
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
        void clip(int min, int max, int clipping_type, int total_HVs)
        {
            if (clipping_type==0)
                printf("\e[93mClipping mode:\e[39m No clipping mode, integer output HVs\n");
            else if(clipping_type==1)
            {
                //printf("\e[93mClipping mode:\e[39m Binary clipping mode\n");
                if (HV_TYPE==0)
                {
                    std::random_device rd;
                    std::mt19937 gen(rd());
                    //printf("\e[93mClipping mode:\e[39m Majority voting based on the number of features\n");
                    // Binary clipping
                    for (int i=0;i<HV_SIZE;i++)
                    {
                        if (HV[i]<total_HVs/2)
                            HV[i]=0;
                        else if (HV[i]>total_HVs/2)
                            HV[i]=1;
                        else{

                            // Create a uniform distribution for integer values between 0 and HV_SIZE-1
                            std::uniform_int_distribution<int>dis(0, 1);
                            HV[i] = dis(gen); // Randomly choose 0 or 1
                        }
                    }
                }
                else
                    // Bipolar clipping
                    for (int i=0;i<HV_SIZE;i++)
                        if (HV[i]<=0)
                            HV[i]=-1;
                        else
                            HV[i]=1;   
            }
            else if(clipping_type==2)
            {
                printf("\e[93mClipping mode:\e[39m Ternary clipping mode\n");
                // Ternary clipping
                for (int i=0;i<HV_SIZE;i++)
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
                for (int i=0;i<HV_SIZE;i++)
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
// by instantiating HV elements and flipping a number of bits equal to HV_SIZE * SPARSITY
// --------------------------------------------------   
void generate_BaseHVs(HDC baseVectors[NUM_BASE_VECTORS], const char* filename = "base_vectors.txt")
{            
    if (READ_HVs_FROM_FILE == 1)
    {
        printf("Reading base vectors from file...\n");
        std::ifstream infile(filename);
        if (infile)
        {
            for (int i = 0; i < NUM_BASE_VECTORS; i++)
                for (int j = 0; j < HV_SIZE; j++)
                    infile >> baseVectors[i].HV[j];
            infile.close();
        }
        else
            printf("\e[91mERROR:\e[39m Failed to open file for reading base vectors.\n");
    }
    else
    {              
        //printf("Generating random base vectors...\n");  
        // The base vectors are obtained randomly flipping a number of bits dependent on the sparsity
        for (int vec = 0; vec < NUM_BASE_VECTORS; vec++)
            baseVectors[vec].random_HV();
        
        #if DEBUG==1 
            printf("Done!\n");
            printf("Base vectors:\n");
            for (int vec = 0; vec < NUM_BASE_VECTORS; vec++)
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
// If READ_HVs_FROM_FILE == 0, the level vectors are initialized accoring to the LEVEL_VECTOR_TECHNIQUE,
// if LEVEL_VECTOR_TECHNIQUE == 0, the level vectors are initialized with the linear encoding
// if LEVEL_VECTOR_TECHNIQUE == 1, the level vectors are initialized with the approximately linearly encoding
// if LEVEL_VECTOR_TECHNIQUE == 2, the level vectors are initialized with the thermometer encoding
// --------------------------------------------------
void generate_LevelVectors(HDC LevelVectors[NUM_BASE_VECTORS],const char* filename = "base_vectors.txt")
{          
    printf("\e[92m----------\nGenerate_LevelVectors()\e[39m --> ");  
    if (READ_HVs_FROM_FILE == 1)
    {
        printf("Reading Level vectors from file...\n");
        std::ifstream infile(filename);
        if (infile)
        {
            for (int i = 0; i < NUM_BASE_VECTORS; i++)
                for (int j = 0; j < HV_SIZE; j++)
                    infile >> LevelVectors[i].HV[j];
            infile.close();
        }
        else
            printf("\e[91mERROR:\e[39m Failed to open file for reading Level vectors.\n");
    }
    else
    {
        printf("Generating random LHVs using the ");                
        if (LEVEL_VECTOR_TECHNIQUE == 0)
        {
            printf("Linear encoding.\n");
            // Linear encoding
            // the first level vector is randomly initialized 
            int change_ratio;
            if (DENSE == 0)
                change_ratio = HV_SIZE * SPARSITY;          
            else
                change_ratio = HV_SIZE / 2;                 
            // Flipping random change_ratio bits
            for (int i = 0; i < change_ratio; i++)
            {
                int index = rand() % HV_SIZE;
                LevelVectors[0].HV[index] = 1;
            }                
            // The other level vectors are obtained flipping a number of bits equal to int(HV_size / (2 * totalLevel))
            // starting from the previous level vector. However, the same element can not be flipped 2 times
            change_ratio = HV_SIZE / (2 * NUM_LEVEL_VECTORS);
            int indexVector[HV_SIZE];
            for (int i = 0; i < HV_SIZE; i++)
                indexVector[i] = 1;

            for (int level = 1; level < NUM_LEVEL_VECTORS; level++)
            {
                LevelVectors[level] = LevelVectors[level - 1];
                int i=0;
                
                while (i < change_ratio)
                {
                    int index = rand() % HV_SIZE;
                    if (indexVector[index] == 1)
                    {                
                        indexVector[index] = 0;
                        i++;
                        if (HV_TYPE==0)
                            if (LevelVectors[level - 1].HV[index] == 0)
                                LevelVectors[level].HV[index] = 1;
                            else
                                LevelVectors[level].HV[index] = 0;
                        else
                            if (LevelVectors[level - 1].HV[index] == -1)
                                LevelVectors[level].HV[index] = 1;
                            else
                                LevelVectors[level].HV[index] = -1;
                    }
                }
            }
        }
        else if (LEVEL_VECTOR_TECHNIQUE==1)
        {
            printf("Approximately linear encoding.\n");
            // Approximately linear encoding:
            // two random level vectors are initialized (the first and last one), and the other level vectors are obtained taking
            // int(np.ceil(D * (1 - level / totalLevel))) from the first level vector and
            // int(D-(D * (1 - level / totalLevel))) from the second level vector
            int change_ratio;
            if (DENSE == 0)
                change_ratio = HV_SIZE * SPARSITY;
            else
                change_ratio = HV_SIZE / 2;                
            // Random initialization of the first level vector
            for (int i = 0; i < change_ratio; i++)
            {
                int index = rand() % HV_SIZE;
                LevelVectors[0].HV[index] = 1;
            }

            // Random initialization of the last level vector
            for (int i = 0; i < change_ratio; i++)
            {
                int index = rand() % HV_SIZE;
                LevelVectors[NUM_LEVEL_VECTORS-1].HV[index] = 0;
            }

            // Intermediate level vectors
            for (int level = 1; level<NUM_LEVEL_VECTORS-1;level++)
            {
                int fromFirst = int((HV_SIZE * (1 - (float)level/NUM_LEVEL_VECTORS)));
                int fromSecond = HV_SIZE - fromFirst;
                printf("Level %d: %d bits from first vector, %d bits from second vector\n",level,fromFirst,fromSecond);
                for (int i = 0; i < HV_SIZE; i++)
                {
                    if (i<fromFirst)
                        LevelVectors[level].HV[i] = LevelVectors[0].HV[i];
                    else
                        LevelVectors[level].HV[i] = LevelVectors[NUM_LEVEL_VECTORS-1].HV[i];                            
                }
            }                                   
        }
        else if (LEVEL_VECTOR_TECHNIQUE==2)
        {
            printf("Thermometer encoding.\n");
            // Thermometer encoding:
            // the first level vector has all zero elements,
            // in the others intermediate levels, the first int((level + 1) * HV_SIZE / (2 * NUM_LEVEL_VECTORS)) elements are set to 1
            // the last level vector has HV_SIZE/2 elements set to 1
            for (int level = 0; level < NUM_LEVEL_VECTORS; level++)
            {
                for (int i = 0; i < HV_SIZE; i++)
                {
                    if (level == 0)
                        LevelVectors[level].HV[i] = 0;
                    else
                    {
                        if (i < int((level + 1) * HV_SIZE / (2 * NUM_LEVEL_VECTORS)))
                            LevelVectors[level].HV[i] = 1;
                        else
                            if (HV_TYPE==0)
                                LevelVectors[level].HV[i] = 0;
                            else
                                LevelVectors[level].HV[i] = -1;
                            
                    }
                }
            }
        }        
    }
    printf("\e[92m----------\n\e[39m");
}     

// ----------------------------
// OTHER FUNCTIONS
// Function to generate the quantization levels
// Input: min, max, levels
// Output: LevelList (array of thresholds for each quantization level)
// Example: min = 0, max = 1, levels = 4
//-----------------------------
void generate_quantization_levels(float min, float max,int levels, float LevelList[NUM_LEVEL_VECTORS])
{
    double length = max - min;
    double gap = length / levels;
    for (int level = 0; level < levels; ++level) {
        LevelList[level] = min + level * gap;
    }
    LevelList[levels] = max;
}

// Function to get the quantized level for a given value
int get_quantized_level(float value, float quantization_levels[NUM_LEVEL_VECTORS], int levels) {
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
HDC encoding(float FeatureVector[NUM_OF_FEATURES], HDC BaseVectors[NUM_BASE_VECTORS], HDC LevelVectors[NUM_LEVEL_VECTORS], float LevelList[NUM_LEVEL_VECTORS])
{
    HDC Encoded_HV;
    #if DEBUG==1 
        printf("\e[92m----------\n\e[39m");
        printf("Encoding...\n");
        printf("Feature vector: ");
        for (int i = 0; i < NUM_OF_FEATURES; i++)
            printf("%f ", FeatureVector[i]);
        printf("\n");
    #endif
    // 1) Compute the quantization level of each feature using get_quantized_level function
    int quantized_features[NUM_OF_FEATURES];
    for (int i = 0; i < NUM_OF_FEATURES; i++)
        quantized_features[i] = get_quantized_level(FeatureVector[i], LevelList, NUM_LEVEL_VECTORS);
    #if DEBUG==1
        printf("Quantized features: ");
        for (int i = 0; i < NUM_OF_FEATURES; i++)
            printf("%d\n", quantized_features[i]);
    #endif
        
    // 2) BIND the level vector with the corresponding base vector (dependent by the number of the feature)
    HDC binded_feature[NUM_OF_FEATURES];
    for (int i = 0; i < NUM_OF_FEATURES; i++)
    {
        binded_feature[i] = LevelVectors[quantized_features[i]].bind(BaseVectors[i]);
        #if DEBUG==1
            printf("Binding...\n");
            printf("Level vector %d: ", quantized_features[i]);
            for (int j = 0; j < HV_SIZE; j++)
                printf("%d ", LevelVectors[quantized_features[i]].HV[j]);
            printf("\n");
            printf("Base vector %d: ", i);
            for (int j = 0; j < HV_SIZE; j++)
                printf("%d ", BaseVectors[i].HV[j]);
            printf("\n");
            printf("Binded level vector %d with base vector %d: ", quantized_features[i], i);
        #endif
    }
    
    // 3) Bundle all the level vectors together to obtain the HDC vector representation of the input feature vector
    for (int i = 0; i < NUM_OF_FEATURES; i++){
        Encoded_HV = Encoded_HV.bundle(binded_feature[i]);
        //printf("Bundled level vector %d\n", i);
    }
    //printf("Encoded HV\n");
    //Encoded_HV.print_HV();

    // 4) Clip the HDC vector
    Encoded_HV.clip(-1,1, CLIPPING_ENCODING,NUM_OF_FEATURES);
    //printf("Clipped HV\n");
    //Encoded_HV.print_HV();
    //printf("Clipped\n");

    // 4) Bundle all the level vectors together to obtain the HDC vector representation of the input feature vector
    return Encoded_HV;
}

// LOAD DATASET
// Function to load the dataset from a given file
// Input: filename
// Output: dataset (array of feature vectors)
void load_train_dataset(const std::string& filename, float dataset[NUM_OF_TRAIN_SAMPLES][NUM_OF_FEATURES])
{
    std::ifstream file(filename);
    if (!file) {
        printf("\e[91mERROR:\e[39m Failed to open file '%s'\n", filename.c_str());
        return;
    }

    int row = 0;
    std::string line;
    while (std::getline(file, line) && row < NUM_OF_TRAIN_SAMPLES) {
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

        if (col != NUM_OF_FEATURES) {
            printf("\e[91mERROR:\e[39m Inconsistent number of features in row %d\n", row + 1);
            printf("Expected %d, found %d\n", NUM_OF_FEATURES, col); 
            return;
        }

        row++;
        //printf("Loaded row %d\n", row);
    }
    printf("Loaded %d samples with %d features each.\n", row, NUM_OF_FEATURES);

    if (row != NUM_OF_TRAIN_SAMPLES) {
        printf("\e[91mERROR:\e[39m Inconsistent number of features in the dataset.\n");
        printf("Expected %d, found %d\n", NUM_OF_TRAIN_SAMPLES, row);
    } else {
        printf("\e[92mDataset loaded successfully.\e[39m\n");
    }
}

void load_test_dataset(const std::string& filename, float dataset[NUM_OF_TEST_SAMPLES][NUM_OF_FEATURES])
{
    std::ifstream file(filename);
    if (!file) {
        printf("\e[91mERROR:\e[39m Failed to open file '%s'\n", filename.c_str());
        return;
    }

    int row = 0;
    std::string line;
    while (std::getline(file, line) && row < NUM_OF_TEST_SAMPLES) {
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

        if (col != NUM_OF_FEATURES) {
            printf("\e[91mERROR:\e[39m Inconsistent number of features in row %d\n", row + 1);
            printf("Expected %d, found %d\n", NUM_OF_FEATURES, col); 
            return;
        }

        row++;
        //printf("Loaded row %d\n", row);
    }
    printf("Loaded %d samples with %d features each.\n", row, NUM_OF_FEATURES);

    if (row != NUM_OF_TEST_SAMPLES) {
        printf("\e[91mERROR:\e[39m Inconsistent number of features in the dataset.\n");
        printf("Expected %d, found %d\n", NUM_OF_TEST_SAMPLES, row);
    } else {
        printf("\e[92mDataset loaded successfully.\e[39m\n");
    }
}



void load_train_labels(const std::string& filename, int labels[NUM_OF_TRAIN_SAMPLES])
{
    std::ifstream file(filename);
    if (!file) {
        printf("\e[91mERROR:\e[39m Failed to open file '%s'\n", filename.c_str());
        return;
    }

    int idx = 0;
    std::string line;
    while (std::getline(file, line) && idx < NUM_OF_TRAIN_SAMPLES) {
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

    if (idx != NUM_OF_TRAIN_SAMPLES) {
        printf("\e[91mERROR:\e[39m Inconsistent number of labels in the file.\n");
        printf("Expected %d, found %d\n", NUM_OF_TRAIN_SAMPLES, idx);
    } else {
        printf("\e[92mLabels loaded successfully.\e[39m\n");
    }
}

void load_test_labels(const std::string& filename, int labels[NUM_OF_TEST_SAMPLES])
{
    std::ifstream file(filename);
    if (!file) {
        printf("\e[91mERROR:\e[39m Failed to open file '%s'\n", filename.c_str());
        return;
    }

    int idx = 0;
    std::string line;
    while (std::getline(file, line) && idx < NUM_OF_TEST_SAMPLES) {
        try {
            float label = std::stoi(line);
            labels[idx] = label;
            idx++;
        } catch (const std::exception& e) {
            printf("\e[91mERROR:\e[39m Unable to convert label value '%s' to float.\n", line.c_str());
            return;
        }
    }

    if (idx != NUM_OF_TEST_SAMPLES) {
        printf("\e[91mERROR:\e[39m Inconsistent number of labels in the file.\n");
        printf("Expected %d, found %d\n", NUM_OF_TEST_SAMPLES, idx);
    } else {
        printf("\e[92mLabels loaded successfully.\e[39m\n");
    }
}


// -----------------MAIN--------------------
// test the HDC class
int main()
{

    #if TEST==0 
        printf("\e[93mRANDOM HVs TEST\e[39m\n");
        // Generate a random HV
        HDC HV1;
        HV1.random_HV();

        // Generate a random HV
        HDC HV2;
        HV2.random_HV();

        // Compute the similarity between the two HVs
        float sim = HV1.similarity(HV2);
        printf("Similarity: %f\n", sim);

    #elif TEST==1
        printf("\e[93mBASE VECTOR TEST\e[39m\n");
        // Test the Base Vectors generation and similarity
        HDC BaseVectors[NUM_BASE_VECTORS];
        generate_BaseHVs(BaseVectors);   
        for (int i = 1; i < NUM_BASE_VECTORS; i++)
        {
            float sim = BaseVectors[0].similarity(BaseVectors[i]);
            printf("Similarity between base vector 0 and %d: %f\n", i, sim);
        }
    

    #elif TEST==2
        printf("\e[93mLEVEL VECTOR TEST\e[39m\n");
        // Test the Level Vectors generation and similarity
        HDC LevelVectors[NUM_LEVEL_VECTORS];
        generate_LevelVectors(LevelVectors);
        
        // similarity between each level vector
        float similarity[NUM_LEVEL_VECTORS][NUM_LEVEL_VECTORS];
        printf("similarities = [");
        for (int i = 0; i < NUM_LEVEL_VECTORS; i++)
        {
            printf("[");

            for (int j = 0; j < NUM_LEVEL_VECTORS; j++)
            {
                similarity[i][j]= LevelVectors[i].similarity(LevelVectors[j]);
                if (j==NUM_LEVEL_VECTORS-1)
                    printf("%f", similarity[i][j]);
                else
                    printf("%f,", similarity[i][j]);
            }
            printf("]\n");
        }
        printf("]\n");
    #elif TEST==3
        //Testing the binding
        printf("\e[93mBINDING TEST\e[39m\n");
        HDC HV1;
        HV1.random_HV();
        HDC HV2;
        HV2.random_HV();
        printf("Similarity between HV1 and HV2: %f\n", HV1.similarity(HV2));
        HDC binded_HV;
        binded_HV = HV1.bind(HV2);
        printf("Similarity between HV1 and binded_HV: %f\n", HV1.similarity(binded_HV));
        printf("Similarity between HV2 and binded_HV: %f\n", HV2.similarity(binded_HV));
    #elif TEST==4
        // Testing the bundling    
        printf("\e[93mBUNDLING TEST\e[39m\n");
        HDC HV1;
        HV1.random_HV();
        HDC HV2;
        HV2.random_HV();
        printf("Similarity between HV1 and HV2: %f\n", HV1.similarity(HV2));
        HDC bundled_HV;
        bundled_HV = HV1.bundle(HV2);
        printf("bundled HV\n");
        bundled_HV.print_HV();
        int total_HVs=2;
        bundled_HV.clip(0,1,CLIPPING_ENCODING,total_HVs);
        printf("bundled HV after clipping\n");
        bundled_HV.print_HV();
        
        printf("Similarity between HV1 and bundled_HV: %f\n", HV1.similarity(bundled_HV));
        printf("Similarity between HV2 and bundled_HV: %f\n", HV2.similarity(bundled_HV));
    #elif TEST==5
        float FeatureVector[NUM_OF_FEATURES] = {10.0957,    0.6670,    3.0207,    1.2709};
        float LevelList[NUM_LEVEL_VECTORS];
        generate_quantization_levels(0, 21, NUM_LEVEL_VECTORS, LevelList);
        printf("Level List generated \n");
        HDC BaseVectors[NUM_BASE_VECTORS];
        generate_BaseHVs(BaseVectors);
        printf("Base Vectors generated \n");

        HDC LevelVectors[NUM_LEVEL_VECTORS];
        generate_LevelVectors(LevelVectors);
        printf("Level Vectors generated \n");



        HDC Encoded_HV;
        Encoded_HV = encoding(FeatureVector, BaseVectors, LevelVectors, LevelList);
        printf("Encoded HV: ");
        Encoded_HV.print_HV();
        printf("\n");

    #elif TEST==6
        printf("\e[93mLOAD DATASET TEST\e[39m\n");
        float dataset[NUM_OF_TRAIN_SAMPLES][NUM_OF_FEATURES];
        load_dataset(TRAIN_DATASET_NAME, dataset);
        int printed_rows = 2;
        int printed_columns = 5;
        printf("Dataset: \n");
        for (int i = 0; i < printed_rows; i++)
        {
            printf("[");
            for (int j = 0; j < printed_columns; j++)
            {
                if (j==NUM_OF_TRAIN_SAMPLES-1)
                    printf("%f", dataset[i][j]);
                else
                    printf("%f,", dataset[i][j]);
            }
            printf("]\n");
        }        
    #elif TEST==7
        printf("\e[93mClassification TEST\e[39m\n");
        float LevelList[NUM_LEVEL_VECTORS];
        generate_quantization_levels(0, 21, NUM_LEVEL_VECTORS, LevelList);
        printf("Level list generated.\n");
        float train_dataset[NUM_OF_TRAIN_SAMPLES][NUM_OF_FEATURES];
        load_train_dataset(TRAIN_DATASET_NAME, train_dataset);
        printf("Train dataset loaded.\n");

        float test_dataset[NUM_OF_TEST_SAMPLES][NUM_OF_FEATURES];
        load_test_dataset(TEST_DATASET_NAME, test_dataset);
        printf("Test dataset loaded.\n");



        int train_labels[NUM_OF_TRAIN_SAMPLES]={0};
        load_train_labels(TRAIN_LABELS_NAME, train_labels);
        printf("Train labels loaded.\n");
        printf("Train labels: \n");
        for (int i = 0; i < 10; i++)
        {
            printf("%d\n", train_labels[i]);
        }

        int test_labels[NUM_OF_TEST_SAMPLES];
        load_test_labels(TEST_LABELS_NAME, test_labels);
        printf("Test labels loaded.\n");

        HDC BaseVectors[NUM_BASE_VECTORS];
        generate_BaseHVs(BaseVectors);
        printf("Base vectors generated.\n");

        HDC LevelVectors[NUM_LEVEL_VECTORS];
        generate_LevelVectors(LevelVectors);
        printf("Level vectors generated.\n");


        HDC Encoded_HV;
        HDC ClassHVs[NUM_OF_CLASSES+1];
        for (int i = 0; i < NUM_OF_CLASSES+1; i++)
        {
            for (int j = 0; j < HV_SIZE; j++)
                ClassHVs[i].HV[j]=0;
            /*printf("Class %d HV initialized.\n", i);
            printf("Class %d HV: ", i);
            ClassHVs[i].print_HV();*/
        }
        int bundled_vectors[NUM_OF_CLASSES+1]={0};
        for (int i = 0; i < NUM_OF_TRAIN_SAMPLES; i++)
        {
            //printf("Iteration: %d\n",i);
            if(i%(NUM_OF_TRAIN_SAMPLES/20)==0)
                printf("Train dataset encoded percentage: %.2f%%\n", ceil((float)i/NUM_OF_TRAIN_SAMPLES*100));
            Encoded_HV = encoding(train_dataset[i], BaseVectors, LevelVectors, LevelList);
            #if DEBUG==1
            printf("Encoded HV: ");
            Encoded_HV.print_HV();
            printf("i:%d, Train label: %d\n",i, train_labels[i]);
            #endif
            ClassHVs[train_labels[i]]=ClassHVs[train_labels[i]].bundle(Encoded_HV);
            
            // count the number of encodedhv for each class
            bundled_vectors[train_labels[i]]++;
            
            #if DEBUG==1 
                printf("Class HV[%d]: ", train_labels[i]);
                ClassHVs[train_labels[i]].print_HV();
            #endif

        }
        printf("Train dataset encoded.\n");

        // Clipping
        for (int i = 1; i < NUM_OF_CLASSES+1; i++)
            ClassHVs[i].clip(-1,1, CLIPPING_MODE,bundled_vectors[i]);
        
        printf("Train dataset clipped.\n");

        #if DEBUG==1
            printf("Class HVs: \n");
            for (int i = 0; i < NUM_OF_CLASSES+1; i++)
            {
                printf("Class %d: ", i);
                ClassHVs[i].print_HV();
            }
        #endif
        
        // Classification
        int correct = 0;
        int predicted_label;
        float similarity;
        float top_similarity;
        for (int i = 0; i < NUM_OF_TEST_SAMPLES; i++)
        {
            if(i%(NUM_OF_TEST_SAMPLES/20)==0)
                printf("Test dataset classified percentage: %.2f%%\n", ceil((float)i/NUM_OF_TEST_SAMPLES*100));
            Encoded_HV = encoding(test_dataset[i], BaseVectors, LevelVectors, LevelList);
            predicted_label = 0;
            if (HV_TYPE==1)
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
                similarity = ClassHVs[j].similarity(Encoded_HV);
                //printf("similarity[%d]: %f\n",j, similarity);
                if (HV_TYPE==1)
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
            //printf("Predicted label: %d --- ", predicted_label);
            //printf("Actual label: %d\n", test_labels[i]);
        }
        printf("Test dataset classified.\n");
        printf("Accuracy: %.2f%%\n", (float)correct/NUM_OF_TEST_SAMPLES*100);
        
    #endif
    

    // Testing the bundling 

    
    
    return 0;
}
