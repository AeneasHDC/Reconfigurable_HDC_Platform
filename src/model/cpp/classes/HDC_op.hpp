/**
 * @file HDC_class.hpp
 * @brief C++ class for instantiating and handling classification problems
 *        in the Hyperdimensional Computing (HDC) framework.
 *        This class instantiates the HDC model according to the configuration
 *        parameters specified in the config_cpp.hpp file and provides all the necessary
 *        methods to train, retrain and test the model.
 *        The class is highly customizable, allowing the user to verify the
 *        performance of the HDC model with different configurations in terms of:
 *        - HV dimensionality
 *        - HV data type (binary or bipolar)
 *        - HV mode (dense or sparse)
 *        - HV level type (linear, approximately linear, thermometer)
 *        - HV similarity method (Hamming, DotProduct, Cosine)
 *        - HV Encoding techniques:
 *             - BaseHV+LevelHV, denoted as record-based.          
 *             - LevelHV+Permutation, denoted as N-gram based      # NEW
 *        - Encoding of temporal sequences (N-gram encoding)       # NEW
 *        - HV clipping techniques(both for encoding and classification):
 *             - Binary clipping
 *             - Bipolar clipping
 *             - Ternary clipping
 *             - Quantized clipping
 *             - Power of Two clipping                             # NEW
 *             - No clipping
 *        - Retraining                                             # NEW
 *        - Learning rate                                          # NEW
 *        - Learning Rate decay:
 *             - data-dependent decay (different learning rate as a function of similarity)                     # NEW
 *             - iteration-dependent decay (different learning rate as a function of the number of iterations)  # NEW
 *        - etc.
 *        More information about the HDC model can be found in the following
 *        accompanying research paper: paper_citation

 * @author Marco Angioli and Saeid Jamili
 * @email marco.angioli@uniroma1.it and saeid.jamili@uniroma1.it
 * @date Created on: 21th August 2023
 * @date Last updated on: 6th January 2024
 * @institution Sapienza University of Rome
 * @ref :
 * https://doi.org/10.xxxx/yyyyy
 *
 * @section LICENSE
 * Copyright [2023] Sapienza University of Rome
 *  SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
 *  Licensed under the Solderpad Hardware License v 2.1 (the “License”); you
 *  may not use this file except in compliance with the License, or, at your
 *  option, the Apache License version 2.0. You may obtain a copy of the
 *  License at
 *  https://solderpad.org/licenses/SHL-2.1/
 *  Unless required by applicable law or agreed to in writing, any work
 *  distributed under the License is distributed on an “AS IS” BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 * @section CHANGELOG
 * @version 1
 * @date 16th August  2023
 * - Initial release by MA
 * - Added the generate_BaseHVs method to use the LFSR random generator for 
 *   base vector generation on hardware by SJ 
 *
 */
#ifndef HDC_CLASS_HPP
#define HDC_CLASS_HPP
#include "../../config/config_cpp.hpp"
#include "auxiliary_functions.hpp"
#include "load_datasets.hpp"
#include "rnd_gen.hpp"
#include <map>
#define HV_ELEMENT_BIT_WIDTH 8                  // Hyper Dimensional Vector element width in bits
#define TEST 0


// Hyper Dimensional Vector
class HDC_op
{
    public:
        int D;                        // HV size
        int HV_type;                  // HV type: binary or bipolar
        int num_levels;               // Number of levels used in the model
        int num_features;             // Number of features used in the model
        int num_classes;              // Number of classes used in the model
        int lv_technique;             // Level vector technique: 0: linear, 1: approximately linear, 2: thermometer encoding
        int density;                  // Density of the HV: 0: dense, 1: sparse
        float sparsity_factor;        // Sparsity factor of the HV (used only for sparse HVs)
        int HV_similarity;            // HV similarity: 0: Hamming distance, 1: Cosine similarity

        // NEW
        int encoding_technique;       // Encoding technique: 0: record-based, 1: ngram-based
        int n_gram;                   // Temporal encoding: 0: no temporal encoding, 1: temporal encoding
        int n_gram_size;              // Size of the temporal window adopted in temporal encoding
        int clipping_encoding;        // Clipping technique for encoding: 0: no clipping, 1: binary clipping, 2: bipolar clipping, 3: quantized clipping
        int clipping_class;           // Clipping technique for classification: 0: no clipping, 1: binary clipping, 2: bipolar clipping, 3: quantized clipping
        int quant_min;                // Minimum value for quantization
        int quant_max;                // Maximum value for quantization
        int epochs;                   // Number of epochs for retraining
        int lr_max;                   // Maximum learning rate
        int lr_decay;                 // Learning rate decay: 0: no decay, 1: data-dependent decay, 2: iteration-dependent decay
        int beta_lr;                  // Number of iterations for learning rate decay
        int base_value;               // Base value of the HV (used only for bipolar HVs)
        
        // New LFSR related attributes
        LFSRParams lfsr_params_bhv_gen;
        LFSRParams lfsr_params_lhv_gen;
        LFSRParams approximate_lv_lsfr;

        // New LUT for power of two clipping
        std::map<int, std::pair<int, int>> lookupTable;


        // Class Constructor through initialization list
        HDC_op(int dimensionality=10000, int HV_type=1, int density=0, float sparsity_factor=0.5, 
               int num_features=4, int num_levels=10, int lv_tech=0, int similarity=0, 
               int quant_min=-1, int quant_max=1, int encoding_technique=0,
               int n_gram=0, int n_gram_size=2, int num_classes=10,
               int clipping_encoding=0, int clipping_class=1, int epochs=100,
               float lr_max=0.1, int lr_decay=0, int beta_lr=10)

        : D(dimensionality), HV_type(HV_type), density(density), sparsity_factor(sparsity_factor),
          num_features(num_features), num_levels(num_levels), lv_technique(lv_tech), HV_similarity(similarity),
          quant_min(quant_min), quant_max(quant_max), encoding_technique(encoding_technique),
          n_gram(n_gram), n_gram_size(n_gram_size), num_classes(num_classes), 
          clipping_encoding(clipping_encoding), clipping_class(clipping_class),
          epochs(epochs), lr_max(lr_max), lr_decay(lr_decay), beta_lr(beta_lr), 
          lfsr_params_bhv_gen(BV_RND_GEN_W_BITS, 3, 0, 2, 3, 4, 0),
          lfsr_params_lhv_gen(BV_RND_GEN_W_BITS, 3, 0, 2, 3, 4, 0),
          approximate_lv_lsfr(lfsr_params_lhv_gen),
          base_value(HV_type == 1 ? -1 : 0)
        {
            if (clipping_class==4 || clipping_class==5)
                generateExponentLookupTable(DO_CLASS_W_BITS);
        }

        // Method for generating the random HVs
        HV random_HV()
        {
            HV HV1;
            std::random_device rd;
            std::mt19937 gen(rd());

            // Create a uniform distribution for integer values between 0 and D-1
            std::uniform_int_distribution<int> dis(0, D - 1);

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
        void print_HV(const HV& HV1)
        {
            std::cout << "= [";
            for (int i = 0; i < D; i++)
                std::cout << HV1.data[i] << " ";
            std::cout << "]\n";
        }

        
        // Function to generate the exponent lookup table
        std::map<int, std::pair<int, int>> generateExponentLookupTable(int bits) {
            
            int maxVal = 1 << bits;
            int currentExponent = 0;
            int nextPowerOfTwo = 1;

            for (int i = 1; i <= maxVal; ++i) {
                if (i > nextPowerOfTwo) {
                    currentExponent++;
                    nextPowerOfTwo *= 2;
                }

                int nearestExponent = (std::abs(i - nextPowerOfTwo) < std::abs(i - (nextPowerOfTwo / 2))) ? currentExponent : currentExponent - 1;

                if (lookupTable.find(nearestExponent) == lookupTable.end()) {
                    lookupTable[nearestExponent] = std::make_pair(i, i);
                } else {
                    lookupTable[nearestExponent].second = i;
                }
            }

            return lookupTable;
        }

        // Function to quantize a single value to its exponent using the lookup table
        int quantizeToExponent(int value) {
            printf("Quantizing value: %d ---->",value);
            // If the value is 0, return 0
            if (value == 0){
                printf("0\n");
                return 0;
            }
    
            // Standard values
            for (const auto& kvp : lookupTable) {
                if (value >= kvp.second.first && value <= kvp.second.second) {
                    printf("%d\n",kvp.first);
                    return kvp.first;
                }
            }

            // Return the exponent of the last element in the lookup table if out of range
            printf("%d\n",lookupTable.rbegin()->first);
            return lookupTable.rbegin()->first;
        }

        /* --------------------Base HVs----------------------
            @brief Function to generate the BaseHVs.
            
            The BaseHVs are the hypervectors that will be used to encode the features.
            They are generated randomly to result in orthogonal hypervectors.
        
            @note Using the LFSR random generator for generating base vector on hardware 
            is a new approach, for more details, refer to our paper: 
                https://doi.org/10.xxxx/yyyyy

            @param BaseVectors: The array of BaseHVs.
        -------------------------------------------------- */
        void generate_BaseHVs(HV baseVectors[DS_FEATURE_SIZE])
        {                     
            // The base vectors are obtained randomly flipping a number of bits dependent on the SPARSITY_FACTOR
            #if (BV_MODE == BV_M_RND_GEN)
                // Setting a random seed for the LFSR
                std::random_device rd;
                std::mt19937 gen(rd());
                std::uniform_int_distribution<uint64_t> dist(1LL << (BV_RND_GEN_W_BITS - 2), 1LL << (BV_RND_GEN_W_BITS - 1));
                lfsr_params_bhv_gen.seed = dist(gen);

                // Initialize the LFSR with the generated seed
                LFSR<BV_RND_GEN_W_BITS, 3, 0, 2, 3, 4, 0>lfsr;
                lfsr.set_seed(lfsr_params_bhv_gen.seed);

                for (int i = 0; i < D; i += BV_RND_GEN_W_BITS) {
                    for (int j = 0; j < DS_FEATURE_SIZE; ++j) {
                        lfsr.randomize();
                        
                        for (int k = 0; k < BV_RND_GEN_W_BITS; ++k) {
                            std::cout << "Random number: " << lfsr.rnd_o[k] << std::endl;
                            baseVectors[j].data[i + k] = lfsr.rnd_o[k] ? 1 : base_value;
                        }
                    }
                }
                // printf("Base vectors generated using the LFSR random generator\n");
                // for (int i = 0; i < DS_FEATURE_SIZE; ++i) {
                //     printf("Base vector %d: ", i);
                //     for (int j = 0; j < D; ++j) {
                //         printf("%d ", baseVectors[i].data[j]);
                //     }
                //     printf("\n");
                // }
            #else
                for (int vec = 0; vec < DS_FEATURE_SIZE; vec++)
                    baseVectors[vec]=random_HV();
            #endif
            
        }     

        /* --------------------Level HVs----------------------
        The LevelHVs are the hypervectors that will be used to encode the value of a feature.
        They can be generated in three different ways:
          - if lv_technique == 0, the level vectors are initialized with the linear encoding
          - if lv_technique == 1, the level vectors are initialized with the approximately linearly encoding
          - if lv_technique == 2, the level vectors are initialized with the thermometer encoding

        @param LevelVectors: The array of LevelHVs.
        -------------------------------------------------- */
        void generate_LevelVectors(HV LevelVectors[HD_LV_LEN])
        {          
            printf("\e[92m----------\nGenerate_LevelVectors()\e[39m --> ");  
        
            printf("Generating random LHVs using the ");                
            if (lv_technique == 0)
            {
                printf("Linear encoding.\n");
                // Linear encoding
                // the first level vector is randomly initialized 
                int change_ratio;
                if (density == 1)
                    change_ratio = D * sparsity_factor;          
                else
                    change_ratio = D / 2;                 
                // Flipping random change_ratio bits
                for (int i = 0; i < change_ratio; i++)
                {
                    int index = rand() % D;
                    LevelVectors[0].data[index] = 1;
                }                
                // The other level vectors are obtained flipping a number of bits equal to int(HD_DIM / (2 * totalLevel))
                // starting from the previous level vector. However, the same element can not be flipped 2 times
                change_ratio = D / (2 * num_levels);
                int indexVector[HD_DIM];
                for (int i = 0; i < D; i++)
                    indexVector[i] = 1;
                for (int level = 1; level < num_levels; level++)
                {
                    LevelVectors[level] = LevelVectors[level - 1];
                    int i=0;
                    while (i < change_ratio)
                    {
                        int index = rand() % D;
                        if (indexVector[index] == 1)
                        {                
                            indexVector[index] = 0;
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


                // Random initialization of the first and last level HVs
                #if (LV_MODE == LV_M_LOGIC)
        
                    // Setting a random seed for the LFSR
                    std::random_device rd;
                    std::mt19937 gen(rd());
                    std::uniform_int_distribution<uint64_t> dist(1LL << (LV_M_APPROX_RND_GEN_W_BITS - 2), 1LL << (LV_M_APPROX_RND_GEN_W_BITS - 1));
                    approximate_lv_lsfr.seed = dist(gen);

                    // Initialize the LFSR with the generated seed
                    LFSR<BV_RND_GEN_W_BITS, 3, 0, 2, 3, 4, 0>lfsr_lv;
                    lfsr_lv.set_seed(approximate_lv_lsfr.seed);

                    for (int i = 0; i < HD_DIM; i += LV_M_APPROX_RND_GEN_W_BITS) {
                        lfsr_lv.randomize();
                        
                        
                        for (int k = 0; k < LV_M_APPROX_RND_GEN_W_BITS; ++k) {
                            LevelVectors[0].data[i + k] = lfsr_lv.rnd_o[k] ? 1 : base_value;
                            LevelVectors[num_levels - 1].data[i + k] = lfsr_lv.rnd_o[k] ? 1 : base_value;
                        }
                    }

                    // Replace 0s with base_value for the first and last levels
                    for (int i = 0; i < HD_DIM; ++i) {
                        if (LevelVectors[0].data[i] == 0) {
                            LevelVectors[0].data[i] = base_value;
                        }
                        if (LevelVectors[num_levels - 1].data[i] == 0) {
                            LevelVectors[num_levels - 1].data[i] = base_value;
                        }
                    }
            
                #else
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
                #endif


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
   

        // -----------------SIMILARITY--------------------
        // Computes the similarity between two HVs
        // that is Hamming distance for binary HVs
        // and cosine similarity for bipolar HVs
        // --------------------------------------------------
        float similarity(HV HV1, HV HV2)
        {
            float sim = 0;

            if (density==1) {
                // Sparse HV similarity
                int andCount = 0, hv1Count = 0;
                for (int i = 0; i < HD_DIM; i++) {
                    if (HV1.data[i] && HV2.data[i]) {
                        andCount++;
                    }
                    if (HV1.data[i]) {
                        hv1Count++;
                    }
                }
                sim = (float)(andCount) / hv1Count;
            }    
            else if ( HV_similarity == 2 )
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
                // Cosine or dot product
                float dot = 0.0, denom_a = 0.0, denom_b = 0.0 ;

                if ( clipping_class == 4|| clipping_class==6 )
                {
                    for (int i = 0; i < D; ++i) {
                        if (HV1.data[i] != 0 && HV2.data[i] != 0) {
                            dot += (HV1.data[i] << HV2.data[i]);
                        }
                        denom_a += HV1.data[i] != 0 ? 1 << (HV1.data[i]<<1) : 0;
                        denom_b += HV2.data[i] != 0 ? 1 << (HV2.data[i]<<1) : 0;
                    }
                }
                else
                {
                    for (int i = 0; i < HD_DIM; i++)
                    {
                        dot     += HV1.data[i] * HV2.data[i] ;
                        denom_a += HV1.data[i] * HV1.data[i] ;
                        denom_b += HV2.data[i] * HV2.data[i] ;
                    }
                }

                if ( HV_similarity == 1 )
                    // Dot product
                    sim=dot;
                else
                    // Cosine similarity
                    sim = dot / (sqrt(denom_a) * sqrt(denom_b)) ;
            }
            return sim;
        }



        // Binding operator ->
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
                // Bipolar or integer binding
                for (int i = 0; i < D; i++)
                    Binded_HV.data[i] = HV1.data[i] * HV2.data[i];
            }
            return Binded_HV;
        }


        // Superposition or bundling operator ->
        HV bundle(HV HV1, HV HV2)
        {
            HV Bundled_HV;
            // Bipolar bundling
            for (int i = 0; i < D; i++)
                Bundled_HV.data[i] = HV1.data[i] + HV2.data[i];
            return Bundled_HV;
        }

        // Permutation operator ->
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
        // - Generate a power of two vector in which each element is a power of two. This is done through LUT
        // - Generate a power of two quantized vector in which each element is a power of two. The values are clipped in the range [min, max]. This is done through LUT and thresholding
        // --------------------------------------------------
        HV clip(HV HV1, int min, int max, int clipping_type, int total_HVs)
        {
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
                    // Bipolar clipping
                    for (int i=0;i<HD_DIM;i++)
                        if (HV1.data[i]<=0)
                            HV1.data[i]=-1;
                        else
                            HV1.data[i]=1;   
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
                // Quantized clipping
                // Max value that can be represented with the given number of bits
                int max_val = (1 << DO_CLASS_W_BITS) - 1;
                int max_ds_val = DS_TRAIN_SIZE;

                // Scaling factor
                double scaling_factor = static_cast<double>(max_val) / max_ds_val;

                // Apply the quantization
                for (int i = 0; i < D; ++i) {
                    HV1.data[i] = static_cast<int>(std::round(HV1.data[i] * scaling_factor));
                }
            }

            else if (clipping_type == 4)
            {
                // Power of two clipping
                for (int i = 0; i < D; ++i)
                {
                   HV1.data[i]= quantizeToExponent(HV1.data[i]);
                }
            }
            else if (clipping_type == 5) {
                
                // Power of two quantized clipping
                // Max value that can be represented with the given number of bits
                int max_val = (1 << DO_CLASS_W_BITS) - 1;
                int max_ds_val = DS_TRAIN_SIZE;

                // Scaling factor
                double scaling_factor = static_cast<double>(max_val) / max_ds_val;

                // Apply the quantization
                for (int i = 0; i < D; ++i) {
                    HV1.data[i] = static_cast<int>(std::round(HV1.data[i] * scaling_factor));
                }

                for (int i = 0; i < D; ++i) {
                    HV1.data[i]  = quantizeToExponent(HV1.data[i]);
                }
            }
            else if (clipping_type == 6) {
                // Threshold clipping
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
           
        HV context_dependent_thinning(const HV& Z, int bundled_HVs, int thinning_steps) 
        {
            /**
             * @brief Context-Dependent Thinning (CDT).
             * 
             * Mathematical function used for sparse HVs that is performed after a bundling.
             * It reduces the resulting sparsity factor, keeping it constant.
             * 
             * @param Z The input Hyperdimensional Vector (HV).
             * @param bundled_HVs Number of bundled HVs.
             * @param thinning_steps Number of thinning steps to perform.
             * @return The thinned HV.
             */
            HV thinned_HV;
            HV permuted_HV;

            // Context-dependent Thinning:
            for (int i = 0; i < thinning_steps; ++i) {
                permuted_HV = permutation(Z, i + 1);
                for (int j = 0; j < D; ++j) {
                    thinned_HV.data[j] = thinned_HV.data[j] || permuted_HV.data[j];
                }
            }

            HV result;
            for (int i = 0; i < D; ++i) {
                result.data[i] = Z.data[i] && thinned_HV.data[i];
            }
        
            return result;
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
            /**
            * @brief Encoding function
            *
            * Function that encodes the input feature vector into a hypervector.
            * The encoding can be performed using two different techniques:
            * - BaseHV+LevelHV, denoted as record-based.
            * - LevelHV+Permutation, denoted as N-gram based
            * More information about the encoding techniques can be found in the reference
            * documentation.
            */
            HV Encoded_HV;

            // 1) Compute the quantization level of each feature using get_quantized_level function
            int quantized_features[DS_FEATURE_SIZE];

            for (int i = 0; i < DS_FEATURE_SIZE; i++)
                quantized_features[i] = get_quantized_level(FeatureVector[i], LevelList, HD_LV_LEN);

            if (density==1)
            {
                // Sparse HV encoding
                for (int i = 0; i < DS_FEATURE_SIZE; i++) {
                    int index = quantized_features[i];
                    // Element-wise OR operation
                    for (int j = 0; j < D; j++) {
                        Encoded_HV.data[j] = Encoded_HV.data[j] || LevelVectors[index].data[j];
                    }
                }
                Encoded_HV = context_dependent_thinning(Encoded_HV, DS_FEATURE_SIZE, DS_FEATURE_SIZE * 5); // Context-dependent thinning
            }
            else{
                // 2) BIND the level vector with the corresponding base vector 
                HV binded_feature[DS_FEATURE_SIZE];
                for (int i = 0; i < DS_FEATURE_SIZE; i++)
                {
                    if (encoding_technique==0)
                        binded_feature[i] = bind(LevelVectors[quantized_features[i]], BaseVectors[i]);
                    else
                        binded_feature[i] = permutation(LevelVectors[quantized_features[i]], i);
                }
                // 3) Bundle all the level vectors together to obtain the HDC vector representation of the input feature vector
                for (int i = 0; i < DS_FEATURE_SIZE; i++)
                    Encoded_HV = bundle(Encoded_HV,binded_feature[i]);
            }

            // 4) Clip the HDC vector
            Encoded_HV=clip(Encoded_HV, -1, 1, CLIPPING_ENCODING,DS_FEATURE_SIZE);

            // 4) Bundle all the level vectors together to obtain the HDC vector representation of the input feature vector
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
                if (n_gram == 0) {
                    // 4.1) Encode the training data
                    Encoded_HV = encoding(train_data[i],
                                        BaseHVs,
                                        LevelHVs,
                                        LevelList,
                                        clipping_encoding,
                                        encoding_technique);

                    // 4.2) Accumulation: Class HVs
                    int label = train_labels[i];
                    ClassHVs[label] = bundle(ClassHVs[label],Encoded_HV);
                    bundled_labels[label] +=1;
                }
                else
                {
                    // Temporal Encoding
                    HV n_gram_HV;
                    for (int j = 0; j < n_gram_size * DS_FEATURE_SIZE; j++) {
                        int feature_index = j / n_gram_size;
                        int permute_step = j % n_gram_size;
                        int level_index = get_quantized_level(train_data[i + permute_step][feature_index], LevelList, quant_levels);
                        HV temp_HV      = bind(BaseHVs[feature_index], LevelHVs[level_index]);
                        temp_HV         = permutation(temp_HV, permute_step);
                        n_gram_HV       = bundle(n_gram_HV, temp_HV);
                    }
                    n_gram_HV = clip(n_gram_HV, quant_min, quant_max, clipping_encoding, n_gram_size * DS_FEATURE_SIZE);
                    
                    int label = train_labels[i];
                    ClassHVs[label] = bundle(ClassHVs[label], n_gram_HV);
                    bundled_labels[label]++;
                }
            }   

            // 5) Normalize the Class HVs
            for (int i=0;i<num_classes;i++)
                ClassHVs[i] = clip(ClassHVs[i],quant_min,quant_max,clipping_class,bundled_labels[i]);
        }


        PredictionResult predict(float test_data[DS_TEST_SIZE][DS_FEATURE_SIZE], int test_labels[DS_TEST_SIZE], int num_classes, float *quantized_levels, int quant_levels,HV BaseHVs[DS_FEATURE_SIZE], HV LevelHVs[HD_LV_LEN], HV ClassHVs[DS_CLASSES_SIZE], int clipping_encoding, int verbose, int n_gram, int n_gram_size,int encoding_technique)
        {
            float similarities[DS_CLASSES_SIZE];
            int correct=0; int actual_class; int estimated_class;
            HV testedHV;
            std::vector<int> estimated_classes(DS_TEST_SIZE);

            for (int i=0;i<DS_TEST_SIZE;i++)
            {
                // 1) Encode the training data
                if (n_gram == 0)
                {
                    // Spatial encoding    
                    testedHV = encoding(test_data[i], 
                                        BaseHVs,
                                        LevelHVs,
                                        quantized_levels, 
                                        clipping_encoding,
                                        encoding_technique);
                }
                else
                {
                    // Temporal encoding
                    HV n_gram_HV;
                    for (int j = 0; j < n_gram_size * DS_FEATURE_SIZE; j++) {
                        int feature_index = j / n_gram_size;
                        int permute_step = j % n_gram_size;
                        int level_index = get_quantized_level(test_data[i + permute_step][feature_index], 
                                                            quantized_levels, quant_levels);
                        HV temp_HV = bind(BaseHVs[feature_index], LevelHVs[level_index]);
                        temp_HV = permutation(temp_HV, permute_step);
                        n_gram_HV = bundle(n_gram_HV, temp_HV);
                    }
                    n_gram_HV = clip(n_gram_HV, quant_min, quant_max, clipping_encoding, n_gram_size * DS_FEATURE_SIZE);
                    testedHV = n_gram_HV;
                }

                actual_class = test_labels[i];

                // 2) Compute the similarity between the encoded HV and the Class HVs
                for (int j=0;j<num_classes;j++)
                    similarities[j] = similarity(testedHV,ClassHVs[j]);

                // 3) Find the max/min similarity 
                estimated_class=0;
                if (HV_similarity==0 || HV_similarity==1 || density==1)
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
                estimated_classes[i] = estimated_class;
            }
            float accuracy=float(correct*100)/DS_TEST_SIZE;
            printf("Accuracy: %f\n",accuracy);
            return {accuracy, estimated_classes};
        }

        void retrain(float retrain_data[DS_TRAIN_SIZE][DS_FEATURE_SIZE], int retrain_labels[DS_TEST_SIZE], float test_data[DS_TEST_SIZE][DS_FEATURE_SIZE], int test_labels[DS_TEST_SIZE], int num_classes, float *quantized_levels, int quant_levels, HV BaseHVs[DS_FEATURE_SIZE], HV LevelHVs[HD_LV_LEN], HV ClassHVs[DS_CLASSES_SIZE], int clipping_encoding, int verbose, int n_gram, int n_gram_size,int encoding_technique, int clipping_class, int epochs, float starting_accuracy, int lr_max, int beta_lr,int learning_rate_decay, HV best_ClassHVs[DS_CLASSES_SIZE])
        {
            // Initializations:
            float accuracy_before = starting_accuracy;
            float new_accuracy;
            int corrections=10;
            float error_rate[BETA_LR];
            int learning_rate=lr_max;
            int iterations=0;
            float similarities[DS_CLASSES_SIZE];
            int actual_class, estimated_class;
            int learning_rate_data;

            int bundled_labels[DS_CLASSES_SIZE];
            int best_bundled_labels[DS_CLASSES_SIZE];
            int best_epoch=0;
            int beta=0;
            std::vector<int> estimated_classes(DS_TEST_SIZE);
            
            
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
                                          clipping_encoding,
                                          encoding_technique);
                    
                    actual_class = retrain_labels[i];

                    // Similatiry between the encoded HV and the Class HVs
                    for (int j=0;j<num_classes;j++)
                        similarities[j] = similarity(Encoded_HV,ClassHVs[j]);

                    // 1.2) Find the max/min similarity
                    estimated_class=0;
                    if (HV_similarity==0 || HV_similarity==1 || density==1)
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
                PredictionResult new_data = predict(test_data,            // Test dataset
                                      test_labels,          // Test labels
                                      num_classes,      // Number of classes
                                      quantized_levels,     // LevelList
                                      quant_levels,         // Number of quantization levels
                                      BaseHVs,              // BaseHVs
                                      LevelHVs,             // LevelHVs
                                      ClassHVs,             // ClassHVs
                                      clipping_encoding,    // Clipping encoding (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                                      1,                    // Verbose
                                      n_gram,               // N-gram (0: no n-gram, 1: n-gram)
                                      n_gram_size,          // N-gram size
                                      ENCODING_TECHNIQUE);  // Encoding technique (0: record-based, 1: ngram-based)
                new_accuracy = new_data.accuracy;
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
#endif





