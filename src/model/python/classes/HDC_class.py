"""
/**
 * @file HDC_class.py
 * @brief Python class for instantiating and handling classification problems
 *        in the Hyperdimensional Computing (HDC) framework.
 *        This class instantiates the HDC model according to the configuration
 *        parameters specified in the config_py.py file and provides all the necessary
 *        methods to train and test the model.
 *        The class is highly customizable, allowing the user to verify the
 *        performance of the HDC model with different configurations in terms of:
 *        - HV dimensionality
 *        - HV data type (binary or bipolar)
 *        - HV mode (dense or sparse)
 *        - HV level type (linear, approximately linear, thermometer)
 *        - HV similarity method (Hamming, DotProduct, Cosine)
 *        - HV Encoding techniques:
 *             - BaseHV+LevelHV, denoted as record-based.          
 *             - LevelHV+Permutation, denoted as N-gram based      
 *        - Encoding of temporal sequences (N-gram encoding) 
 *        - HV clipping techniques(both for encoding and classification):
 *             - Binary clipping
 *             - Bipolar clipping
 *             - Quantized clipping
 *             - No clipping
 *        - Retraining                                             
 *        - Learning rate                                          
 *        - Learning Rate decay:
 *             - data-dependent decay (different learning rate as a function of similarity)                     
 *             - iteration-dependent decay (different learning rate as a function of the number of iterations)  
 *        - etc.
 *        More information about the HDC model can be found in the accompanying research paper

 * @author Marco Angioli and Saeid Jamili
 * @email marco.angioli@uniroma1.it and saeid.jamili@uniroma1.it
 * @note Author names are listed in alphabetical order.
 * @date Created on: 12th August 2023
 * @date Last updated on: 5th May 2024
 * @institution Sapienza University of Rome
 *
 * @section LICENSE
    Copyright 2024 Sapienza University of Rome

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

 * @section CHANGELOG
 * @version 1.0.2
 * @date May 2024
 */
"""

import numpy as np
import random
import copy
import sys
sys.path.append("../")
import config_py as config
import auxiliary_functions
import math
from classes.rnd_gen import LFSR 
from sklearn.metrics.cluster import normalized_mutual_info_score
from sklearn.metrics import mean_squared_error

# Hypervector class
class HDC_op:
    test = 0 
    
    def __init__(self, Dimensionality=10000, HV_type='bipolar', density='dense', sparsity_factor=0.5, Number_of_features=4,Number_of_levels=10, LevelTechnique="LINEAR", similarity="SIMI_HAM", encoding_technique="ENCODING_RECORD", clipping_encoding="CLIPPING_BINARY", n_gram=0, n_gram_size=2, num_classes=10, quantization_min=-1, quantization_max=1, clipping_class="CLIPPING_CLASS", epochs=100, lr_max=0.1, lr_decay="LR_CONSTANT", beta_lr=10):
        
     
        self.D                     =   Dimensionality
        self.HV_type               =   HV_type
        self.num_levels            =   Number_of_levels
        self.num_features          =   Number_of_features
        self.lv_technique          =   LevelTechnique
        self.density               =   density
        self.HV_similarity         =   similarity
        self.sparsity_factor       =   sparsity_factor
        self.num_classes           =   num_classes
        self.quant_min             =   quantization_min
        self.quant_max             =   quantization_max
        self.n_gram                =   n_gram
        self.n_gram_size           =   n_gram_size
        self.clipping_encoding     =   clipping_encoding
        self.encoding_technique    =   encoding_technique
        self.clipping_class        =   clipping_class
        self.epochs                =   epochs
        self.lr_max                =   lr_max
        self.lr_decay              =   lr_decay
        self.beta_lr               =   beta_lr

        # LFSR related parameters for BV  
        self.lfsr_params_bhv_gen = {
            'OUT_BWIDTH': config.BV_RND_GEN_W_BITS,
            'N_OF_REM_FBITS': 3,
            'b1': 0,
            'b2': 2,
            'b3': 3,
            'b4': 4,
            'seed': 0
        }

        # LFSR related parameters for LV   
        self.lfsr_params_lhv_gen = {
            'OUT_BWIDTH': config.BV_RND_GEN_W_BITS,
            'N_OF_REM_FBITS': 3,
            'b1': 0,
            'b2': 2,
            'b3': 3,
            'b4': 4,
            'seed': 0
        }
    
        self.lookup_table = auxiliary_functions.create_lut_efficient(config.DO_CLASS_W_BITS)
        # print the lut
        for key, value in self.lookup_table.items():
            print(key, ' : ', value)

        self.approximate_lv_lsfr = self.lfsr_params_lhv_gen.copy()#SJ:updated
        # Setting the base value for the hypervectors
        if (HV_type==config.BIPOLAR):
            self.baseValue=-1
        elif(HV_type==config.BINARY):
            self.baseValue=0
        else:
            print("Error: Not supported data type.", HV_type,"provided, but you can only choose between binary and bipolar")
            exit()
        
        
    
    def get_bv_lfsr_params(self):
        """
       @brief Get the LFSR parameters.

       @return A dictionary containing the LFSR parameters including the seed value.

       @note This method is used to retrieve the LFSR parameters, including the seed value, 
       that were used for random generation.
       """
        return self.lfsr_params_bhv_gen

    def get_lv_lfsr_params(self):
        """
       @brief Get the LFSR parameters used for generating LevelHVs.

       @return A dictionary containing the LFSR parameters including the seed value.

       @note This method is used to retrieve the LFSR parameters, including the seed value, 
       that were used for random generation.
       """
        return self.approximate_lv_lsfr
        
    
    def get_clip_lut(self):
        """
       @brief Get the clipping lookup table.

       @return A dictionary containing the clipping lookup table.

       @note This method is used to retrieve the clipping lookup table.
       """
        return self.lookup_table

    def generate_BaseHVs(self):
        """
        @brief Generate the BaseHVs.
        
        The BaseHVs are the hypervectors that will be used to encode the features.
        They are generated randomly to result in orthogonal hypervectors.
        
        @note Using the LFSR random generator for generating base vector on hardware 
        is a new approach, for more details, refer to our paper: 
            https://doi.org/10.xxxx/yyyyy
        
        """
        
        baseHVs = np.zeros((self.num_features,self.D))
        
        if config.BV_MODE == config.BV_M_RND_GEN:  
        
      
            self.lfsr_params_bhv_gen['seed'] = random.randrange(1 << (config.BV_RND_GEN_W_BITS-2), 1 << (config.BV_RND_GEN_W_BITS-1))#SJ:updated
            self.lfsr = LFSR( **self.lfsr_params_bhv_gen )

            
            for i in range(0, config.HD_DIM, config.BV_RND_GEN_W_BITS):
                for j in range(config.DS_FEATURE_SIZE):
                    
                    self.lfsr.randomize()
                    baseHVs[j, i:i+config.BV_RND_GEN_W_BITS] = list(format(self.lfsr.rnd_o, f'0{config.BV_RND_GEN_W_BITS}b'))
        
            # Replace 0s with baseValue
            baseHVs[baseHVs == 0] = self.baseValue
            
            
        else:
            
            indexVector = range(self.D)
            
            if (self.density==config.DENSE):
                change = int(self.D/2)
            else:
                change = int(self.D*self.sparsity_factor)
                
            for i in range(self.num_features):
                baseVector = np.full(self.D, self.baseValue)               # First a vector of -1 or 0 is created
                toOne = np.random.permutation(indexVector)[:change]        # Then D/2 random elements are flipped
                for index in toOne:
                    baseVector[index] = 1
                baseHVs[i] = baseVector      

        return baseHVs


    def generate_LevelVector(self):
        """
        @brief Generate the LevelHVs.

        The LevelHVs are the hypervectors that will be used to encode the value of a feature.
        They can be generated in three different ways:
        - Linear encoding
        - Thermometer encoding
        - Approximate linear encoding
        More information about the level encoding techniques can be found in the reference
        documentation.
        
        """
        
        # Linear encoding:
        if self.lv_technique == config.LINEAR:
            levelHVs = np.zeros((self.num_levels, self.D))
            indexVector = list(range(self.D))
            nextLevel = int(self.D / (2 * self.num_levels))
            
            if self.density==config.DENSE:
                change = int(self.D / 2)
            else:
                change = int(self.D * self.sparsity_factor)

            for level in range(self.num_levels):
                # First random HV
                if level == 0:
                    baseVector = np.full(self.D, self.baseValue)
                    toOne = np.random.permutation(indexVector)[:change]
                else:
                    if self.density==config.DENSE:
                        toOne = np.random.permutation(indexVector)[:nextLevel]
                    else:
                        zero_indeces=[index for index in range(self.D) if baseVector[index]==0]         # Half of the flipped elements was zeros,
                        one_indeces=[index for index in range(self.D) if baseVector[index]!=0]          # Half of them was ones
                        toZero = np.random.permutation(indexVector and one_indeces)[:nextLevel // 2]    # This preserve the HV's sparsity
                        indexVector = [index for index in indexVector if index not in toZero]
                        toOne = np.random.permutation(indexVector and zero_indeces)[:nextLevel // 2]


                indexVector = [index for index in indexVector if index not in toOne]

                # Build the other levels by flipping an increasing number of bits
                # from the first one. NOTE: you can not flip the same bit two times
                if self.HV_type == config.BIPOLAR:
                    for index in toOne:
                        baseVector[index] = baseVector[index] * -1
                    if self.density==config.SPARSE and level!=0:
                        for index2 in toZero:
                            baseVector[index2] = 0
                else:
                    for index in toOne:
                        if baseVector[index] == 0:
                            baseVector[index] = 1
                        else:
                            baseVector[index] = 0
                    if self.density==config.SPARSE and level!=0:
                        for index2 in toZero:
                            baseVector[index2] = 0

                levelHVs[level] = baseVector
            return levelHVs


        # Thermometer encoding:
        elif self.lv_technique == config.THERMOMETER:

            # First level is set to zero
            if self.HV_type == 'bipolar':
                 levelHVs = np.full((self.num_levels, self.D), -1)
            else:
                levelHVs = np.zeros((self.num_levels, self.D))
            
            # Build the other levels
            for level in range(self.num_levels):
                if level!=0:
                    num_ones = int((level + 1) * self.D / (2 * self.num_levels))
                    levelHVs[level][:num_ones] = 1
            return levelHVs
        
        
        # Approximate linear encoding: 
        elif self.lv_technique==config.APPROX:

            # Initializations
            levelHVs = np.zeros((self.num_levels, self.D))
            indexVector = range(self.D)
            if (self.density==config.DENSE):
                change = int(self.D/2)
            else:
                change = int(self.D*self.sparsity_factor)

            # Random generation of the first and the last level
            if config.LV_MODE == config.LV_M_LOGIC: #SJ: this part updated 
        
                self.approximate_lv_lsfr['seed'] = random.randrange(1 << (config.LV_M_APPROX_RND_GEN_W_BITS-2), 1 << (config.LV_M_APPROX_RND_GEN_W_BITS-1))#SJ:updated
                lfsr_lv = LFSR( **self.approximate_lv_lsfr )

                
                for i in range(0, config.HD_DIM, config.LV_M_APPROX_RND_GEN_W_BITS): #SJ:updated this part
                    lfsr_lv.randomize()
                    levelHVs[0, i:i+config.LV_M_APPROX_RND_GEN_W_BITS] = list(format(lfsr_lv.rnd_o, f'0{config.LV_M_APPROX_RND_GEN_W_BITS}b'))

                for i in range(0, config.HD_DIM, config.LV_M_APPROX_RND_GEN_W_BITS):
                    lfsr_lv.randomize()
                    levelHVs[self.num_levels-1, i:i+config.LV_M_APPROX_RND_GEN_W_BITS] = list(format(lfsr_lv.rnd_o, f'0{config.LV_M_APPROX_RND_GEN_W_BITS}b'))
            
                # Replace 0s with baseValue
                levelHVs[0][levelHVs[0] == 0] = self.baseValue
                levelHVs[self.num_levels-1][levelHVs[self.num_levels-1] == 0] = self.baseValue
                
            
            else:

            
                # First random HV
                toOne = np.random.permutation(indexVector)[:change]
                levelHVs[0]= np.full(self.D, self.baseValue)
                for index in toOne:
                    levelHVs[0][index] = 1
                
                # Last Random HVm ->
                toOne = np.random.permutation(indexVector)[:change]
                levelHVs[self.num_levels-1]=np.full(self.D, self.baseValue)
                for index in toOne:
                    levelHVs[self.num_levels-1][index] = 1
            
            
            # Build the other levels
            for level in range(1, self.num_levels-1):
                
                # Calculate the number of elements to take from levelHVs[0]
                #num_elements_from_first = int(np.ceil(self.D * (1 - level / self.num_levels)))  #SJ:updated
                num_elements_from_first = int((self.D - ((level * self.D) / self.num_levels)))  
                num_elements_from_last  = int(self.D -(self.D * (1 - level / self.num_levels))) 
                
                # Take the required elements from both arrays using array slicing
                first_part = levelHVs[0, :num_elements_from_first]
                second_part = levelHVs[self.num_levels - 1, -(self.D - num_elements_from_first):]

                # Concatenate the two parts
                levelHVs[level] = np.concatenate((first_part, second_part))
            return levelHVs
             
    
    
    # Similarity Distances
    def similarity(self, HV1, HV2, retrain_finished=1):
        if self.density==config.SPARSE:
            and_vector=np.logical_and(HV1,HV2)
            similarity=np.sum(and_vector)/np.sum(HV1)  
        else:
            if (self.HV_similarity == config.SIMI_HAM and retrain_finished==1):
                # HAMMING DISTANCE
                HV1 = np.array(HV1, dtype=np.uint8)
                HV2 = np.array(HV2, dtype=np.uint8)
                # Calculate the Hamming distance using vectorized operations
                hamming_distance = np.sum(HV1 != HV2)
                # Calculate similarity
                similarity = hamming_distance / len(HV1)
            else:

                if config.CLIPPING_CLASS==config.CLIPPING_POWERTWO or  \
                   config.CLIPPING_CLASS==config.CLIPPING_QUANTIZED_POWERTWO:
                    # Calculate dot product with bitwise shift
                    HV1     = HV1.astype(int)
                    HV2     = HV2.astype(int)
                    dot     = sum((HV1[i] << HV2[i]) if HV1[i] != 0 and HV2[i] != 0 else 0 for i in range(len(HV1)))
                    denom_a = np.sqrt(sum(1 << (x<<1) if x != 0 else 0 for x in HV1))
                    denom_b = np.sqrt(sum(1 << (x<<1) if x != 0 else 0 for x in HV2))
                else:
                    # Standard dot product
                    HV1     = HV1.astype(float)
                    HV2     = HV2.astype(float)
                    dot     = np.dot(HV1, HV2)
                    denom_a = np.linalg.norm(HV1)
                    denom_b = np.linalg.norm(HV2)

                if self.HV_similarity == config.SIMI_DPROD: # DOT PRODUCT
                    similarity = dot
                elif (self.HV_similarity == config.SIMI_COS or retrain_finished==0): # COSINE SIMILARITY
                    similarity = dot / (denom_a * denom_b)

        return similarity


    # Binding ->
    def bind(self,HV1, HV2):
        if (self.HV_type==config.BINARY):
            return (HV1.astype(np.uint8)^HV2.astype(np.uint8))
        else:
            return HV1*HV2
    
    # Permutation ->
    def permutation(self, HV, positions):
        return np.roll(HV, positions)
    
    # Superposition or buindling ->
    def bundle(self, HV1, HV2):
        return HV1 + HV2
    
    # Clipping ->
    def clip(self, HV1, min_val=-1, max_val=1, clipping_type=config.CLIPPING_BINARY, bundled_HVs = 2):
        result = np.zeros(self.D)
        if clipping_type == config.CLIPPING_DISABLE:
            result = HV1

        elif clipping_type == config.CLIPPING_BINARY:
            if self.HV_type == config.BINARY:
                # # Binary clipping
                # print("Clipping mode --> Binary clipping mode")
                # random_array = np.random.choice([0, 1], size=result.shape)
                # result[HV1 >  bundled_HVs / 2] = 1
                # result[HV1 == bundled_HVs / 2] = random_array[HV1 == bundled_HVs / 2]
                # result[HV1 <  bundled_HVs / 2] = 0
                result[HV1 >  bundled_HVs / 2] = 1
                result[HV1 <=  bundled_HVs / 2] = 0
            else: #changed by SJ
                # Bipolar Clipping
                # print("Clipping mode --> Bipolar clipping mode")
                #result = np.sign(HV1)
                #random_array = np.random.choice([-1, 1], size=result.shape)
                #result[result == 0] = random_array[result == 0]  
                result[HV1 > 0] = 1
                result[HV1 <= 0] = -1

        elif clipping_type == config.CLIPPING_TERNARY:
            # Ternary clipping
            print("Clipping mode --> Ternary clipping mode")
            result=np.sign(HV1)

        elif clipping_type == config.CLIPPING_THRESHOLD:
            # Threshold clipping
            print("Clipping mode --> Threshold clipping mode")
            result[HV1<min_val] = min_val
            result[HV1>max_val] = max_val

        elif clipping_type == config.CLIPPING_QUANTIZED:
            # Quantized clipping
            print("Clipping mode --> Quantized clipping mode")
            
            # Max value that can be represented with the given number of bits
            max_val = 2**config.CV_DATA_W_BITS - 1
            max_ds_val=config.DS_TRAIN_SIZE*config.EPOCH

            # Scaling factor
            scaling_factor = max_val / max_ds_val

            result = np.array([round(value * scaling_factor) for value in HV1])
            result = result.astype(int)

        elif clipping_type == config.CLIPPING_POWERTWO:
            print("Clipping mode --> Power of two clipping mode")
            result = [auxiliary_functions.get_closest_poweroftwo_using_lut(self.lookup_table,num.astype(int)) for num in HV1]
            
        
        elif clipping_type == config.CLIPPING_QUANTIZED_POWERTWO: 
            print("Clipping mode --> Quantized Power of Two clipping mode")
            
            # Max value that can be represented with the given number of bits
            max_val = 2**config.CV_DATA_W_BITS - 1
            max_ds_val=config.DS_TRAIN_SIZE

            # Scaling factor
            scaling_factor = max_val / max_ds_val

            quantized_HV1 = np.array([round(value * scaling_factor) for value in HV1])
            quantized_HV1 = quantized_HV1.astype(int)

            
            # Power of two clipping
            result = [auxiliary_functions.get_closest_poweroftwo_using_lut(self.lookup_table,num) for num in quantized_HV1]

            # print the first 10 elements of the original hv, the quantized one and the final
            print("HV1: ", HV1[:10])
            print("quantized_HV1: ", quantized_HV1[:10])
            print("result: ", result[:10])
        else:
            print("ERROR: Invalid clipping mode!")

        return result


    def context_dependent_thinning(self, Z, bundled_HVs, thinning_steps):
        """
        @brief Context-Dependent Thinning (CDT). 
        
        Mathmeatical function used for sparse HVs that is performed after a bundling.
        It reduces the resulting sparsity factor, keeping it constant.
        
        """
        thinned_HV = np.zeros(self.D)
        permuted_HV = np.zeros(self.D)

        # Context-dependent Thinning:
        for i in range (thinning_steps):
            permuted_HV = self.permutation(Z, i+1)  
            thinned_HV=np.logical_or(thinned_HV,permuted_HV)
            

        result=np.logical_and(Z,thinned_HV)       
        return result
    
    def encoding(self, feature_vector, BaseHVs, LevelHVs, quant_levels, clipping_type=config.CLIPPING_BINARY, encoding_technique=config.ENCODING_RECORD):
        """
        @brief Encoding function
        
        Function that encodes the input feature vector into a hypervector.
        The encoding can be performed using two different techniques:
        - BaseHV+LevelHV, denoted as record-based.
        - LevelHV+Permutation, denoted as N-gram based
        More information about the encoding techniques can be found in the reference
        documentation.
        
        """
        out_HVs = np.zeros(self.D)
        self.num_levels=np.zeros(self.num_features)
        encoded_t=np.zeros(self.D)
        
        if self.density==config.SPARSE:
            for i in range(self.num_features):
                self.num_levels[i]=auxiliary_functions.get_quantized_level(feature_vector[i], quant_levels)
                index=int(self.num_levels[i])
                encoded_t=np.logical_or(encoded_t,LevelHVs[index])         # Bundling
            encoded_t=self.context_dependent_thinning(encoded_t, bundled_HVs=self.num_features, thinning_steps=self.num_features*5) # Context-dependent thinning
        else:
            if (self.encoding_technique == config.ENCODING_RECORD):
                # Binding:
                for i in range(self.num_features):
                    self.num_levels[i]=auxiliary_functions.get_quantized_level(feature_vector[i], quant_levels)
                    index=int(self.num_levels[i])
                    out_HVs=self.bind(BaseHVs[i], LevelHVs[index])   # Binding between LHVs and BHVs
                    # print("Feature", i, "binding Base[",i,"], Level[",index,"]")
                    encoded_t=self.bundle(out_HVs,encoded_t)         # Bundling
                # print("EncodedHV:",encoded_t)
            else:
                # Binding:
                # print("num_features: ", self.num_features)
                for i in range(self.num_features):
                    self.num_levels[i]=auxiliary_functions.get_quantized_level(feature_vector[i], quant_levels)
                    index=int(self.num_levels[i])
                    out_HVs=self.permutation(LevelHVs[index], i)     # Permutation of the LHVs
                    encoded_t=self.bundle(out_HVs,encoded_t)         # Bundling
                    
            #Clipping
            # print("EncodedHV pre clipping: ",encoded_t)
            encoded_t=self.clip(HV1=encoded_t, min_val=self.quant_min, max_val=self.quant_max, clipping_type=clipping_type, bundled_HVs=self.num_features)
        # if model.density=="sparse":
        #     encoded_t=context_dependent_thinning(model.HV_type, S_t, limitated=limitedbipolar, tripolar=tripolar_flag, thinning_steps=1)
        return encoded_t
    
    
    def train(self, train_data, train_labels, verbose, ds_min_value, ds_max_value, clip_class=config.CLIPPING_CLASS):
       
        num_train_samples=train_data.shape[0]
        #quant_min = np.min(train_data)
        #quant_max = np.max(train_data)
        

        # Initializations
        encoded_HVs=np.zeros(self.D)
        ClassHVs=np.zeros((self.num_classes,self.D))
        bundled_labels=np.zeros(self.num_classes)
        self.n_gram_HV=np.zeros(self.D)
        temporal_HV=np.zeros((self.n_gram_size,self.D))
    
        # 1. Base HVs
        BaseHVs = self.generate_BaseHVs()

        # 2. Level HVs
        LevelHVs = self.generate_LevelVector()
        
        # 3. Generate Quantization levels
        quant_levels = auxiliary_functions.quantization_levels(min_value= ds_min_value,
                                                               max_value= ds_max_value,
                                                               levels=self.num_levels)
       
        # print("Quant_levels: [", quant_levels,"]")
        # 4. Training
        for i in range(num_train_samples):

            if i % (num_train_samples // 10) == 0 and verbose == 1:
                percentage = (i / num_train_samples) * 100
                print("Iteration:", i, "Progress:", np.ceil(percentage), "%")
                
            if self.n_gram==0:
                
                
                # Encoding
                encoded_HVs=self.encoding(feature_vector=train_data[i],
                                            BaseHVs=BaseHVs,
                                            LevelHVs=LevelHVs,
                                            quant_levels=quant_levels,
                                            clipping_type=self.clipping_encoding,
                                            encoding_technique=self.encoding_technique)
                
                

                # Accumulation: Class HVs
                label=train_labels[i]    
                ClassHVs[label]=self.bundle(ClassHVs[label], encoded_HVs)
                bundled_labels[label]+=1              
                
            else: 
                self.num_levels=np.zeros(self.num_features*config.N_GRAM_SIZE)
                self.n_gram_HV=np.zeros(self.D)

                # N-gram:
                for j in range(train_data.shape[1]):
                    
                    self.num_levels[j]   = auxiliary_functions.get_quantized_level(train_data[i][j], quant_levels)   
                    index                = int(self.num_levels[j])
                    # print("encoding the number:", train_data[i][j], "index:", index)
                    out_HVs              = self.bind(BaseHVs[j//config.N_GRAM_SIZE], LevelHVs[index])     # Binding between LHVs and BHs
                    temporal_HV          = self.permutation(out_HVs, j%config.N_GRAM_SIZE)                # Additional step for n-gram
                    self.n_gram_HV       = self.bundle(temporal_HV, self.n_gram_HV)                       # Bundling
                    # print("id:", i, "BaseHVs:",j//config.N_GRAM_SIZE, "permuted by:",j%config.N_GRAM_SIZE )
                    
                self.n_gram_HV       = self.clip(HV1=self.n_gram_HV, min_val=self.quant_min, max_val=self.quant_max, clipping_type=self.clipping_encoding,bundled_HVs=self.num_features*config.N_GRAM_SIZE) 

                ClassHVs[train_labels[i]]=self.bundle(ClassHVs[train_labels[i]], self.n_gram_HV)
                bundled_labels[train_labels[i]]+=1
                    
        # print("ClassHVs before clipping", ClassHVs)

        for i in range(len(ClassHVs)):
            ClassHVs[i]=self.clip(HV1= ClassHVs[i], min_val=ds_min_value, max_val=ds_max_value,clipping_type=clip_class, bundled_HVs=bundled_labels[i])
        return quant_levels, BaseHVs, LevelHVs, ClassHVs, bundled_labels


    def predict(self, test_data, test_labels, BaseHVs, LevelHVs, ClassHVs, quant_levels, verbose=1, retrain_finished=1):

        # Extract data information
        num_test_samples = test_data.shape[0]

        # initializations
        estimated_class=np.zeros(num_test_samples)
        actual_class=np.zeros(num_test_samples)
        self.n_gram_HV=np.zeros(self.D)
        testedHV=np.zeros(self.D)

        if self.HV_type==config.BIPOLAR or self.density==config.SPARSE:
                similarities=np.zeros(self.num_classes)
        else:
                similarities=np.ones(self.num_classes)

        #print("self.num_levels:",self.num_levels)
        correct=0
        for i in range(num_test_samples):
            actual_class[i]=test_labels[i]
            
            if self.n_gram==0:
                testedHV=self.encoding(feature_vector=test_data[i],
                                        BaseHVs=BaseHVs,
                                        LevelHVs=LevelHVs,
                                        quant_levels=quant_levels,
                                        clipping_type=self.clipping_encoding,
                                        encoding_technique=self.encoding_technique)
            
            else:
                # N-gram:
                self.num_levels=np.zeros(test_data.shape[1])
                self.n_gram_HV=np.zeros(self.D)
                for j in range(test_data.shape[1]):
                    self.num_levels[j]   = auxiliary_functions.get_quantized_level(test_data[i][j], quant_levels)   
                    index                = int(self.num_levels[j])
                    # print("encoding the number:", train_data[i][j], "index:", index)
                    out_HVs              = self.bind(BaseHVs[j//config.N_GRAM_SIZE], LevelHVs[index])               # Binding between LHVs and BHs
                    temporal_HV          = self.permutation(out_HVs, j%config.N_GRAM_SIZE)                          # Additional step for n-gram
                    # print("feature: ",j," encoded_hv:", temporal_HV)
                    self.n_gram_HV       = self.bundle(temporal_HV, self.n_gram_HV)                                 # Bundling
                    # print("id:", i, "BaseHVs:",j//config.N_GRAM_SIZE, "permuted by:",j%config.N_GRAM_SIZE )
                # print("encoded_hv:",self.n_gram_HV)
                testedHV = self.clip(HV1=self.n_gram_HV, min_val=self.quant_min, max_val=self.quant_max, clipping_type=self.clipping_encoding,bundled_HVs=self.num_features*config.N_GRAM_SIZE) 


            for j in range(self.num_classes):
                similarities[j]=self.similarity(ClassHVs[j],np.array(testedHV), retrain_finished)
                
            if (self.HV_similarity==config.SIMI_COS or self.HV_similarity==config.SIMI_DPROD or self.density==config.SPARSE) or retrain_finished==0:
                estimated_class[i]=np.argmax(similarities) 
            else:
                estimated_class[i]=np.argmin(similarities)
                
            if estimated_class[i] == actual_class[i]:
                correct = correct + 1
                
            if i!=0 and i % (num_test_samples // 10) == 0 and verbose == 1:
                percentage = (i / num_test_samples) * 100
                print("Progress:", np.ceil(percentage), "% ---> accuracy:",correct*100/i,"%")

        if(verbose==1):      
            print("\n\nAccuracy:",correct*100/num_test_samples,"%")
        accuracy=correct*100/num_test_samples
        return accuracy,estimated_class



    def retrain(self, retrain_data, retrain_labels, test_data, test_label, BaseHVs, LevelHVs, ClassHVs, quant_levels, verbose, starting_accuracy, bundled_labels):
        
        iterations=0
        # Extract data information
        num_retrain_samples = retrain_data.shape[0]
        
        # Initializations
        accuracy_before=starting_accuracy
        corrections=10
        best_ClassHVs=copy.deepcopy(ClassHVs)
        beta=0
        best_epoch=0
        error_rate=np.zeros(self.beta_lr)
        best_bundled_labels=bundled_labels
        learning_rate=self.lr_max
        total_corrections=0
        while iterations < self.epochs and corrections>0 :
            
            # Learning rate decider
            if (self.lr_decay!=config.LR_CONSTANT):
                if beta==self.beta_lr-1:
                    learning_rate = np.mean(error_rate)*1000
                    beta=0
                    if learning_rate>self.lr_max:
                                learning_rate=self.lr_max
                
            # Initializations
            encoded_HVs=np.zeros(self.D)
            self.n_gram_HV=np.zeros(self.D)
            temporal_HV=np.zeros((self.n_gram_size,self.D))
            actual_class=0
            if self.HV_type==config.BIPOLAR or self.density==config.SPARSE:
                    similarities=np.zeros(self.num_classes)
            else:
                    similarities=np.ones(self.num_classes)
            corrections=0

            # Training
            for i in range(num_retrain_samples):

                if i % (num_retrain_samples // 10) == 0 and verbose == 1:
                    percentage = (i / num_retrain_samples) * 100
                    print("Iteration:", i, "Progress:", np.ceil(percentage), "%")
    
                if self.n_gram==0:
                    encoded_HVs=self.encoding(feature_vector=retrain_data[i],
                                              BaseHVs=BaseHVs,
                                              LevelHVs=LevelHVs,
                                              quant_levels=quant_levels,
                                              clipping_type=self.clipping_encoding, 
                                              encoding_technique=self.encoding_technique) 
                
                else:
                    # N-gram:
                    self.num_levels=np.zeros(retrain_data.shape[1])
                    self.n_gram_HV=np.zeros(self.D)
                    for j in range(retrain_data.shape[1]):
                        self.num_levels[j]   = auxiliary_functions.get_quantized_level(retrain_data[i][j], quant_levels)   
                        index                = int(self.num_levels[j])
                        # print("encoding the number:", train_data[i][j], "index:", index)
                        out_HVs              = self.bind(BaseHVs[j//config.N_GRAM_SIZE], LevelHVs[index])               # Binding between LHVs and BHs
                        temporal_HV          = self.permutation(out_HVs, j%config.N_GRAM_SIZE)                          # Additional step for n-gram
                        self.n_gram_HV       = self.bundle(temporal_HV, self.n_gram_HV)                                 # Bundling
                        # print("id:", i, "BaseHVs:",j//config.N_GRAM_SIZE, "permuted by:",j%config.N_GRAM_SIZE )
                        
                    encoded_HVs = self.clip(HV1=self.n_gram_HV, min_val=self.quant_min, max_val=self.quant_max, clipping_type=self.clipping_encoding,bundled_HVs=self.num_features*config.N_GRAM_SIZE) 

                actual_class=retrain_labels[i]               
                    
                # SIMILARITY evaluation, we always use cosine here
                for j in range(self.num_classes):
                    similarities[j]=self.similarity(ClassHVs[j],np.array(encoded_HVs), retrain_finished=0)
                    
                estimated_class=np.argmax(similarities)


                # ClassHVs update:
                if  (actual_class != estimated_class):
                    corrections+=1
                    if (self.lr_decay==config.LR_DATA or self.lr_decay==config.LR_HYBRID):
                        learning_rate_data=int((similarities[estimated_class]-similarities[actual_class])*1000)
                        if learning_rate_data>self.lr_max:
                                learning_rate_data=self.lr_max
                        if (self.lr_decay==config.LR_HYBRID):
                            learning_rate=learning_rate+learning_rate_data/2
                            if learning_rate>self.lr_max:
                                learning_rate=self.lr_max
                        else:
                            learning_rate=learning_rate_data
                        #print("Difference between similarities: ",similarities[estimated_class]-similarities[actual_class],"Adopted Learning_rate:",learning_rate)
                        ClassHVs[estimated_class] = ClassHVs[estimated_class] - learning_rate*encoded_HVs
                        ClassHVs[actual_class]    = ClassHVs[actual_class]    + learning_rate*encoded_HVs
                    else:
                        total_corrections+=1
                        ClassHVs[estimated_class] = ClassHVs[estimated_class] - learning_rate*encoded_HVs
                        ClassHVs[actual_class] = ClassHVs[actual_class] + learning_rate*encoded_HVs

                        
                    bundled_labels[estimated_class]-=1*learning_rate
                    bundled_labels[actual_class]+=1*learning_rate
            
            

            new_accuracy, new_predicted_label = self.predict(test_data=test_data,
                                                             test_labels=test_label,
                                                             BaseHVs=BaseHVs,
                                                             LevelHVs=LevelHVs,
                                                             ClassHVs=ClassHVs,
                                                             quant_levels=quant_levels,                                                    
                                                             verbose=1,
                                                             retrain_finished=0)
            if(verbose==1):     
                print("Epoch",iterations, "finished --> Corrections:",corrections, "Accuracy:",new_accuracy,"%")
            iterations+=1
            if (new_accuracy >= accuracy_before):
                if(verbose==1):     
                    print("Accuracy improved --> Previous Accuracy:",accuracy_before,"New accuracy:",new_accuracy,"%")
                accuracy_before=new_accuracy
                predicted_label=copy.deepcopy(new_predicted_label)
                best_epoch=iterations
                best_ClassHVs=copy.deepcopy(ClassHVs)
                best_bundled_labels=copy.deepcopy(bundled_labels)
            else:
                if(verbose==1):     
                    print("Accuracy not improved --> Previous Accuracy:",accuracy_before,"New accuracy:",new_accuracy,"%")
                #ClassHVs=copy.deepcopy(ClassHVs_before)
            if (self.lr_decay==config.LR_DATA or self.lr_decay==config.LR_HYBRID):
                error_rate[beta]=(corrections*100/num_retrain_samples)
                if(self.beta_lr!=1):
                    beta+=1
                
        print("------------------RETRAINING RECAP----------------------")
        print("Retraining finished -->\n Starting accuracy:",starting_accuracy,"\nBest obtained accuracy:",accuracy_before,"%")
        print("Best epoch:",best_epoch)  
        print("Total corrections:", total_corrections)         
        for i in range(len(best_ClassHVs)):
            print("Class",i)
            # print the first 10 elements of the original hv, the quantized one and the final
            print("Best_ClassHVs:", best_ClassHVs[i][:10])
            print("Best_bundled_labels:", best_bundled_labels[i])
            best_ClassHVs[i]=self.clip(HV1= best_ClassHVs[i], min_val=self.quant_min, max_val=self.quant_max, clipping_type=self.clipping_class, bundled_HVs=best_bundled_labels[i])
            print("Clipped best_ClassHVs:", best_ClassHVs[i][:10])


            
        print("Applying clipping to ClassHVs and testing again...")

        return best_ClassHVs,new_predicted_label


    #----------------------------------#
    # Clustering
    #----------------------------------#
    def clustering(self, clustering_data, clustering_labels, ds_min_value, ds_max_value, clip_class, verbose):
    
        # Extract data information
        num_dataset_samples = clustering_data.shape[0]
        
        # Initializations
        encoded_HVs=np.zeros(self.D)
        self.n_gram_HV=np.zeros(self.D)
        temporal_HV=np.zeros((self.n_gram_size,self.D))

        ClassHVs=np.zeros((self.num_classes,self.D))
        new_ClassHVs=np.zeros((self.num_classes,self.D))
        bundled_labels=np.zeros(self.num_classes)

    
        # 1. Base HVs
        BaseHVs = self.generate_BaseHVs()

        # 2. Level HVs
        LevelHVs = self.generate_LevelVector()
        
        # 3. Generate Quantization levels
        quant_levels = auxiliary_functions.quantization_levels(min_value= ds_min_value,
                                                               max_value= ds_max_value,
                                                               levels=self.num_levels)


        estimated_class=np.zeros(num_dataset_samples)
        iterations=0
        accuracy_before=0

        # Random initialization of the centroids
        for i in range(self.num_classes):
            
            if self.n_gram==0:
                ClassHVs[i]=self.encoding(feature_vector=clustering_data[random.randint(0, num_dataset_samples-1)],
                                                        BaseHVs=BaseHVs,
                                                        LevelHVs=LevelHVs,
                                                        quant_levels=quant_levels,
                                                        clipping_type=self.clipping_encoding, 
                                                        encoding_technique=self.encoding_technique)
            else:
                # N-gram:
                self.num_levels=np.zeros(clustering_data.shape[1])
                self.n_gram_HV=np.zeros(self.D)
                for j in range(clustering_data.shape[1]):
                    self.num_levels[j]   = auxiliary_functions.get_quantized_level(clustering_data[random.randint(0, num_dataset_samples-1)][j], quant_levels)   
                    index                = int(self.num_levels[j])
                    # print("encoding the number:", train_data[i][j], "index:", index)
                    out_HVs              = self.bind(BaseHVs[j//config.N_GRAM_SIZE], LevelHVs[index])
                    temporal_HV          = self.permutation(out_HVs, j%config.N_GRAM_SIZE)
                    self.n_gram_HV       = self.bundle(temporal_HV, self.n_gram_HV)
                    # print("id:", i, "BaseHVs:",j//config.N_GRAM_SIZE, "permuted by:",j%config.N_GRAM_SIZE )
                
                ClassHVs[i] = self.clip(HV1=self.n_gram_HV, min_val=self.quant_min, max_val=self.quant_max, clipping_type=self.clipping_encoding,bundled_HVs=self.num_features*config.N_GRAM_SIZE)

            bundled_labels[i]+=1
        
        # The clustering procedure consists in the following steps:
        # - N cluster are created, initializing the with the HV of a random pattern in the dataset;
        # - The CLUSTER_MEMORY, containing the centroids of each cluster is initialzied and duplicated;
        # - For the entire dataset:
        #   - The first one is used to perform the clustering: each pattern is assigned to the cluster with the most similar centroid. A similarity measure is used to evaluate the similarity between the pattern and the centroid.
        #   - The centroids of the second CLUSTER_MEMORY are updated summing the encoded HV to the selected centroidHVs. 
        # - The first CLUSTER_MEMORY is updated with the new centroids (the second CLUSTER_MEMORY).
        # - The second CLUSTER_MEMORY is duplicated.
        # - The procedure is repeated for the number of epochs.
        while iterations < self.epochs:
            
            estimated_class=np.zeros(num_dataset_samples)
            

            similarities=np.zeros(self.num_classes)
             
                                          
            # Clustering
            for i in range(num_dataset_samples):

                if i % (num_dataset_samples // 10) == 0 and verbose == 1:
                    percentage = (i / num_dataset_samples) * 100
                    print("Iteration:", i, "Progress:", np.ceil(percentage), "%")
    
                #------------------------------------------------#
                # Encoding phase
                if self.n_gram==0:
                    encoded_HVs=self.encoding(feature_vector=clustering_data[i],
                                              BaseHVs=BaseHVs,
                                              LevelHVs=LevelHVs,
                                              quant_levels=quant_levels,
                                              clipping_type=self.clipping_encoding, 
                                              encoding_technique=self.encoding_technique) 
                
                else:
                    # N-gram:
                    self.num_levels=np.zeros(clustering_data.shape[1])
                    self.n_gram_HV=np.zeros(self.D)
                    for j in range(clustering_data.shape[1]):
                        self.num_levels[j]   = auxiliary_functions.get_quantized_level(clustering_data[i][j], quant_levels)   
                        index                = int(self.num_levels[j])
                        out_HVs              = self.bind(BaseHVs[j//config.N_GRAM_SIZE], LevelHVs[index])               # Binding between LHVs and BHs
                        temporal_HV          = self.permutation(out_HVs, j%config.N_GRAM_SIZE)                          # Additional step for n-gram
                        self.n_gram_HV       = self.bundle(temporal_HV, self.n_gram_HV)                                 # Bundling
                        
                        
                    encoded_HVs = self.clip(HV1=self.n_gram_HV, min_val=self.quant_min, max_val=self.quant_max, clipping_type=self.clipping_encoding,bundled_HVs=self.num_features*config.N_GRAM_SIZE)                
                #------------------------------------------------#
                    
                #------------------------------------------------#    
                # Clustering phase (assigning the pattern to the most similar cluster)
                for j in range(self.num_classes):
                    similarities[j]=self.similarity(ClassHVs[j],np.array(encoded_HVs))

                if self.HV_similarity==config.SIMI_COS or self.HV_similarity==config.SIMI_DPROD or self.density==config.SPARSE:
                    estimated_class[i]=np.argmax(similarities)
                else:
                    estimated_class[i]=np.argmin(similarities)
                
                #------------------------------------------------#
                    
                #------------------------------------------------#
                # Centroids update phase
                new_ClassHVs[int(estimated_class[i])] = new_ClassHVs[int(estimated_class[i])] + encoded_HVs
                bundled_labels[int(estimated_class[i])]+=1
                # print("Estimated_class:", estimated_class[i], "real_one: %",clustering_labels[i,0])
            
            accuracy=normalized_mutual_info_score(clustering_labels[:,0], estimated_class)
            
            if(verbose==1):     
                print("Epoch",iterations, "finished --> Accuracy:",accuracy,"%")
            
            ClassHVs=copy.deepcopy(new_ClassHVs)
                
            iterations+=1

        print("ClassHVs before clipping", ClassHVs)
        
        for i in range(len(ClassHVs)):
            ClassHVs[i]=self.clip(HV1= ClassHVs[i], min_val=ds_min_value, max_val=ds_max_value,clipping_type=clip_class, bundled_HVs=bundled_labels[i])

        print("ClassHVs after clipping", ClassHVs)       
        print("------------------CLUSTERING RECAP ----------------------")
        print("Clustering finished -->\n ACCURACY:",accuracy,"%")

        return quant_levels, BaseHVs, LevelHVs, ClassHVs, estimated_class
    

    
    def single_model_regression(self, regression_data, regression_labels, test_data, test_labels, learning_rate, ds_min_value, ds_max_value, clip_class, verbose):
        # The regression procedure consists in the following steps:
        # - A single model (MHV) is created, initialized with all zeros;
        # - The input feature vector is encoded into a hypervector;
        # - The dot product between the MHV and the encoded HV is calculated;
        # - The result is the estimated value y_hat.
        # - The estimatex value y_hat is compared with the real value y and the error is calculated, E = y - y_hat;
        # - The MHV is updated summing the encoded HV multiplied by the error, MHV = MHV + E * encoded_HV;
        # - Eventually, a learning rate can be applied to the update rule, MHV = MHV + learning_rate * E * encoded_HV;
        # - The procedure is repeated for the number of epochs.
        # - The MHV is returned.

        # Extract data information
        num_dataset_samples = regression_data.shape[0]

        # Initializations
        encoded_HVs=np.zeros(self.D)
        model_HV=np.zeros(self.D)
        Class_HVs = np.zeros((2,self.D))
        y_pred=np.zeros(num_dataset_samples)

        # 1. Base HVs
        BaseHVs = self.generate_BaseHVs()

        # 2. Level HVs
        LevelHVs = self.generate_LevelVector()

        # 3. Generate Quantization levels
        quant_levels = auxiliary_functions.quantization_levels(min_value= ds_min_value,
                                                               max_value= ds_max_value,
                                                               levels=self.num_levels)
        
        if config.RETRAIN==1:
            lim=self.epochs
        else:
            lim=1
        for e in range (lim):

            # 4. Training
            for i in range(num_dataset_samples):

                if i % (num_dataset_samples // 10) == 0 and verbose == 1:
                    percentage = (i / num_dataset_samples) * 100
                    print("Iteration:", i, "Progress:", np.ceil(percentage), "%")

                # Encoding
                encoded_HVs=self.encoding(feature_vector=regression_data[i],
                                            BaseHVs=BaseHVs,
                                            LevelHVs=LevelHVs,
                                            quant_levels=quant_levels,
                                            clipping_type=self.clipping_encoding,
                                            encoding_technique=self.encoding_technique)

                
                # Prediction through Dot product
                # print("DOTP between: ",model_HV, "and:", encoded_HVs)
     
                y_hat = np.dot(model_HV, encoded_HVs)
                y_pred[i] = y_hat

                # Error
                error = regression_labels[i] - y_hat
                # print("error: ",regression_labels[i],"-",y_hat," = ", error)
                
                # Update
                model_HV = model_HV + ((error * encoded_HVs).astype(int)>>7)
                  

            print("y_pred: ", y_pred)
            print("regression_labels: ", regression_labels.T)
            
            # Compute MSE using sklearn
            mse = 0
            mse = mean_squared_error(regression_labels, y_pred)
                
            if(verbose==1):     
                print("Epoch: ", e, "MSE: ", mse/10**2)
        
        # Last test:
        y_pred = np.zeros(test_data.shape[0])
        for i in range(test_data.shape[0]):
            encoded_HVs=self.encoding(feature_vector=test_data[i],
                                            BaseHVs=BaseHVs,
                                            LevelHVs=LevelHVs,
                                            quant_levels=quant_levels,
                                            clipping_type=self.clipping_encoding,
                                            encoding_technique=self.encoding_technique)
            # print("encoded_HVs",encoded_HVs)
            y_hat = np.dot(model_HV, encoded_HVs)

            y_pred[i] = y_hat
        print("y_pred: ", y_pred)
        print("regression_labels: ", test_labels.T)
        mse = 0
        mse = mean_squared_error(test_labels, y_pred)
        print("MSE: ", mse/10**2)
        Class_HVs[0]=model_HV
            

        return quant_levels, BaseHVs, LevelHVs, Class_HVs, y_pred



    def multi_model_regression(self, regression_data, regression_labels, learning_rate, ds_min_value, ds_max_value, clip_class, verbose):
        # The multimodel regression, exploits multiple hypervectors to store the information of datapoint with different patterns
        # The main idea behind this approach is to cluster input data and create a seperate model for each input cluster

        # The regression procedure consists in the following steps:
        # - N models (MHV) are created, initialized with all zeros;
        # - The input feature vector is encoded into a hypervector;
        # - The encodedHV is assigned to a cluster C_i, carrying out a clustering procedure;
        # - Each cluster C_i has a corresponding model MHV_i;
        # - The dot product between each Model and the encoded HV is calculated;
        # - The result is the estimated value y_hat;
        # - The estimatex value y_hat is compared with the real value y and the error is calculated, E = y - y_hat;
        # - The MHV_i is updated summing the encoded HV multiplied by the error, MHV_i = MHV_i + E * encoded_HV;
        # - The result is the estimated value y_hat;
        # - The estimatex value y_hat is compared with the real value y and the error is calculated, E = y - y_hat;
        # - The MHV_i is updated summing the encoded HV multiplied by the error, MHV_i = MHV_i + E * encoded_HV;
        # - Eventually, a learning rate can be applied to the update rule, MHV_i = MHV_i + learning_rate * E * encoded_HV;
        # - The encodedHV is added to the selected cluster C_i;


        # Extract data information
        num_dataset_samples = regression_data.shape[0]

        # Initializations
        encoded_HVs=np.zeros(self.D)
        model_HVs=np.zeros((self.num_classes,self.D))
        ClusterHVs=np.zeros((self.num_classes,self.D))
        y_pred=np.zeros(num_dataset_samples)
        

        # 1. Base HVs
        BaseHVs = self.generate_BaseHVs()

        # 2. Level HVs
        LevelHVs = self.generate_LevelVector()

        # 3. Generate Quantization levels
        quant_levels = auxiliary_functions.quantization_levels(min_value= ds_min_value,
                                                               max_value= ds_max_value,
                                                               levels=self.num_levels)
        
        # 4. Random initialization of the centroids
        for i in range(self.num_classes):
            ClusterHVs[i]=self.encoding(feature_vector=regression_data[random.randint(0, num_dataset_samples-1)],
                                        BaseHVs=BaseHVs,
                                        LevelHVs=LevelHVs,
                                        quant_levels=quant_levels,
                                        clipping_type=self.clipping_encoding, 
                                        encoding_technique=self.encoding_technique)
            
        
        # 5. Training
        for i in range(num_dataset_samples):

            if i % (num_dataset_samples // 10) == 0 and verbose == 1:
                percentage = (i / num_dataset_samples) * 100
                print("Iteration:", i, "Progress:", np.ceil(percentage), "%")

            # Encoding
            encoded_HVs=self.encoding(feature_vector=regression_data[i],
                                        BaseHVs=BaseHVs,
                                        LevelHVs=LevelHVs,
                                        quant_levels=quant_levels,
                                        clipping_type=self.clipping_encoding,
                                        encoding_technique=self.encoding_technique)

            # Clustering
            similarities=np.zeros(self.num_classes)
            for j in range(self.num_classes):
                similarities[j]=self.similarity(ClusterHVs[j],np.array(encoded_HVs))
            
            print("similarities: ", similarities)

            print("Cluster selection: ", np.argmax(similarities))
            # Prediction through Dot product between each model and the encoded HV
            y_hat = 0
            for j in range(self.num_classes):
                y_hat += np.dot(model_HVs[j], encoded_HVs)

            y_pred[i] = y_hat

            # Error
            error = regression_labels[i] - y_hat
            
            # Update the selected cluster and all the models
            for j in range(self.num_classes):
                model_HVs[j] = model_HVs[j] + learning_rate*(error * encoded_HVs)
            
            ClusterHVs[np.argmax(similarities)] = ClusterHVs[np.argmax(similarities)] + encoded_HVs

        print("y_pred: ", y_pred)
        print("regression_labels: ", regression_labels.T)

        # Compute MSE using sklearn
        mse = 0
        mse = mean_squared_error(regression_labels, y_pred)
        print("MSE: ", mse)

        return quant_levels, BaseHVs, LevelHVs, model_HVs, y_pred
