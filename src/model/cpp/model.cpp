/**
 * @file Model.cpp
 * @author Marco Angioli and Saeid Jamili
 * @email marco.angioli@uniroma1.it and saeid.jamili@uniroma1.it
 * @date Created on: 12th August 2023
 * @date Last updated on: 16th August 2023
 * @institution Sapienza University of Rome
 * @ref :
 * https://doi.org/10.xxxx/yyyyy
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


 */
"""
#include "./classes/HDC_op.hpp"


int main()
{
    // Print the configuration
    printf("\e[91m------------------\nHDC model:\e[39m");
    printf("Dataset: %s\n",               DS_NAME);
    printf("HV dimensionality: %d\n",     HD_DIM);
    printf("HV data type: %d\n",          HD_DATA_TYPE);
    printf("HV mode: %d\n",               HD_MODE);
    printf("HV level type: %d\n",         HD_LV_TYPE);
    printf("HV level length: %d\n",       HD_LV_LEN);
    printf("HV similarity method: %d\n",  HD_SIMI_METHOD);
    printf("HV Encoding method: %d\n",    ENCODING_TECHNIQUE);
    printf("HV sparsity factor: %f\n",    SPARSITY_FACTOR);
    printf("HV clipping encoding: %d\n",  CLIPPING_ENCODING);
    printf("HV clipping class: %d\n",     CLIPPING_CLASS);
    printf("N-gram: %d\n",                N_GRAM);
    printf("N-gram size: %d\n",           N_GRAM_SIZE);
    printf("Retrain: %d\n",               RETRAIN);
    printf("Epochs: %d\n",                EPOCH);
    printf("Learning rate: %d\n",         MAX_LEARNING_RATE);
    printf("Learning rate decay: %d\n",   LR_DECAY);
    printf("Beta learning rate: %d\n",    BETA_LR);
    printf("------------------\n");

    std::string app_ = "./../../datasets/" + std::string(DS_NAME) + "/" + std::string(DS_NAME);

    // Creating the HDC model:
    HDC_op HDC_model(HD_DIM,                // HV size
                     HD_DATA_TYPE,          // HV data type (binary or bipolar)
                     HD_MODE,               // HV mode (dense or sparsity)
                     SPARSITY_FACTOR,       // percentage HV sparsity
                     DS_FEATURE_SIZE,       // number of features
                     HD_LV_LEN,             // number of levels
                     HD_LV_TYPE,            // level type (linear, approx. linear, thermometer)
                     HD_SIMI_METHOD,        // similarity method (hamming, dotp, cosine)
                     ENCODING_QUANT_MIN,    // min value for quantization
                     ENCODING_QUANT_MAX);   // max value for quantization
     
    // Dataset load:
    float Train_data[DS_TRAIN_SIZE][DS_FEATURE_SIZE];
    int Train_label[DS_TRAIN_SIZE];
    float Test_data[DS_TEST_SIZE][DS_FEATURE_SIZE];
    int Test_label[DS_TEST_SIZE];
    load_train_dataset(app_+"_train_data.csv", Train_data);
    load_train_labels(app_+"_train_label.csv", Train_label);
    load_test_dataset(app_+"_test_data.csv", Test_data);
    load_test_labels(app_+"_test_label.csv", Test_label);


    // Initializations:
    HV ClassHVs[DS_CLASSES_SIZE];
    HV best_ClassHVs[DS_CLASSES_SIZE];
    HV BaseHVs[DS_FEATURE_SIZE];
    HV LevelHVs[HD_LV_LEN];
    float LevelList[HD_LV_LEN];
    float accuracy; 
    int clip_class;
    if(RETRAIN==0)
        clip_class=CLIPPING_CLASS;
    else
        clip_class=CLIPPING_DISABLE;

    // Training procedure
    printf("------------------\nTraining procedure:\n");
    HDC_model.train(Train_data,                     // Train dataset
                    Train_label,                    // Train labels
                    DS_CLASSES_SIZE,                // Number of classes
                    HD_LV_LEN,                      // Number of levels
                    CLIPPING_ENCODING,              // Clipping encoding (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                    clip_class,                     // Clipping class (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                    1,                              // Verbose
                    N_GRAM,                         // N-gram (0: no n-gram, 1: n-gram)
                    N_GRAM_SIZE,                    // N-gram size
                    ENCODING_TECHNIQUE,             // Encoding technique (0: record-based, 1: ngram-based)
                    ClassHVs,                       // ClassHVs
                    LevelList,                      // LevelList
                    BaseHVs,                        // BaseHVs
                    LevelHVs);                      // LevelHVs
           
    // Testing procedure
    printf("------------------\nTesting procedure:\n");
    accuracy=HDC_model.predict(Test_data,            // Test dataset
                               Test_label,           // Test labels
                               DS_CLASSES_SIZE,      // Number of classes
                               LevelList,            // LevelList
                               BaseHVs,              // BaseHVs
                               LevelHVs,             // LevelHVs
                               ClassHVs,             // ClassHVs
                               CLIPPING_ENCODING,    // Clipping encoding (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                               1,                    // Verbose
                               N_GRAM,               // N-gram (0: no n-gram, 1: n-gram)
                               N_GRAM_SIZE,          // N-gram size
                               ENCODING_TECHNIQUE);  // Encoding technique (0: record-based, 1: ngram-based)


    // Retrain procedure
    printf("------------------\nRetrain procedure:\n");
    if(RETRAIN==1)
    {
        HDC_model.retrain(Train_data,               // Train dataset
                          Train_label,              // Train labels
                          Test_data,                // Test dataset
                          Test_label,               // Test labels
                          DS_CLASSES_SIZE,          // Number of classes
                          LevelList,                // LevelList
                          BaseHVs,                  // BaseHVs
                          LevelHVs,                 // LevelHVs
                          ClassHVs,                 // ClassHVs
                          CLIPPING_ENCODING,        // Clipping encoding (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                          1,                        // Verbose
                          N_GRAM,                   // N-gram (0: no n-gram, 1: n-gram)
                          N_GRAM_SIZE,              // N-gram size
                          ENCODING_TECHNIQUE,       // Encoding technique (0: record-based, 1: ngram-based)
                          CLIPPING_CLASS,           // Clipping class (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                          EPOCH,                    // Number of epochs
                          accuracy,                 // Accuracy
                          MAX_LEARNING_RATE,        // Max learning rate
                          BETA_LR,                  // Beta learning rate
                          LR_DECAY,                 // Learning rate decay
                          best_ClassHVs);           // Best ClassHVs

            accuracy=HDC_model.predict(Test_data,    // Test dataset
                               Test_label,           // Test labels
                               DS_CLASSES_SIZE,      // Number of classes
                               LevelList,            // LevelList
                               BaseHVs,              // BaseHVs
                               LevelHVs,             // LevelHVs
                               ClassHVs,             // ClassHVs
                               CLIPPING_ENCODING,    // Clipping encoding (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                               1,                    // Verbose
                               N_GRAM,               // N-gram (0: no n-gram, 1: n-gram)
                               N_GRAM_SIZE,          // N-gram size
                               ENCODING_TECHNIQUE);  // Encoding technique (0: record-based, 1: ngram-based)
    }

    return 0;
}
