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
    printf("HV sparsity factor: %f\n",    SPARSITY_FACTOR_X10);
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

    std::string app_ = "./../../../../datasets/" + std::string(DS_NAME) + "/" + std::string(DS_NAME);

    // Creating the HDC model:
    HDC_op HDC_model(HD_DIM,                    // HV dimensionality
                     HD_DATA_TYPE,              // HV data type (0: binary, 1: bipolar)
                     HD_MODE,                   // HV density   (0: dense, 1: sparse)
                     (float) SPARSITY_FACTOR_X10/10,    // HV sparsity factor (x10)
                     DS_FEATURE_SIZE,           // Dataset feature size
                     HD_LV_LEN,                 // Number of levels 
                     HD_LV_TYPE,                // Technique to generate the levels (0: linear, 1: approximately linear, 2: thermometer)
                     HD_SIMI_METHOD,            // Similarity method (0: dot product, 1: cosine similarity, 2: Hamming distance)
                     QUANT_MIN,                 // QUANT_MIN
                     QUANT_MAX,                 // QUANT_MAX
                     ENCODING_TECHNIQUE,        // Encoding technique (0: record-based, 1: ngram-based)
                     N_GRAM,                    // N-gram (0: no n-gram, 1: n-gram)
                     N_GRAM_SIZE,               // N-gram size (Temporal window size)
                     DS_CLASSES_SIZE,           // Number of classes
                     CLIPPING_ENCODING,         // Clipping encoding (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                     CLIPPING_CLASS,            // Clipping class (0: no clipping, 1: binary, 2: bipolar, 3:quantized, 4:powertwo, 5:quantized_powertwo)
                     EPOCH,                     // Number of epochs
                     (float)MAX_LEARNING_RATE,         // Max learning rate
                     LR_DECAY,                   // Learning rate decay (0: constant, 1: iter, 2: data, 3: hybrid)
                     BETA_LR);                   // Beta learning rate

     
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
    std::vector<int> estimated_classes(DS_TEST_SIZE); 
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
    PredictionResult new_data  =HDC_model.predict(Test_data,            // Test dataset
                               Test_label,           // Test labels
                               DS_CLASSES_SIZE,      // Number of classes
                               LevelList,            // LevelList
                               HD_LV_LEN,            // Number of levels
                               BaseHVs,              // BaseHVs
                               LevelHVs,             // LevelHVs
                               ClassHVs,             // ClassHVs
                               CLIPPING_ENCODING,    // Clipping encoding (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                               1,                    // Verbose
                               N_GRAM,               // N-gram (0: no n-gram, 1: n-gram)
                               N_GRAM_SIZE,          // N-gram size
                               ENCODING_TECHNIQUE);  // Encoding technique (0: record-based, 1: ngram-based)
    accuracy=new_data.accuracy;


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
                          HD_LV_LEN,                // Number of levels
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

            new_data=HDC_model.predict(Test_data,    // Test dataset
                               Test_label,           // Test labels
                               DS_CLASSES_SIZE,      // Number of classes
                               LevelList,            // LevelList
                               HD_LV_LEN,            // Number of levels
                               BaseHVs,              // BaseHVs
                               LevelHVs,             // LevelHVs
                               ClassHVs,             // ClassHVs
                               CLIPPING_ENCODING,    // Clipping encoding (0: no clipping, 1: binary, 2: bipolar, 3:quantized)
                               1,                    // Verbose
                               N_GRAM,               // N-gram (0: no n-gram, 1: n-gram)
                               N_GRAM_SIZE,          // N-gram size
                               ENCODING_TECHNIQUE);  // Encoding technique (0: record-based, 1: ngram-based)
            accuracy=new_data.accuracy;
    }
    std::vector<int> predicted_labels=new_data.estimated_classes;

    

    std::string output_dir = "./";
    std::vector<int>test_labels(Test_label, Test_label + DS_TEST_SIZE);

    // Generate and save confusion matrix
    generateAndSaveConfMatrix(test_labels, predicted_labels, output_dir);

    // Export datasets and parameters
    export2DArray(Train_data, DS_TRAIN_SIZE, "Train_data.csv");
    export1DArray(Train_label, DS_TRAIN_SIZE, "Train_label.csv");
    export2DArray(Test_data, DS_TEST_SIZE, "Test_data.csv");
    export1DArray(Test_label, DS_TEST_SIZE, "Test_label.csv");

    return 0;
}