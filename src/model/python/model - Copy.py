"""
/**
 * @file model.py
 * @brief Main Python file for training and testing the HDC model on a given dataset.
 *        All the model configuration parameters are specified in the config_py.py file.
 *        All the possible dataset are specified in the dataset.py file.
 *        The HDC model is implemented and completely handled in the HDC_class.py file.
 *        Training and testing are fully automatized thanks to the HDC_class.
 *        All the results are collected and reported in the output folder.

 *        More information about the HDC model can be found in the following
 *        accompanying research paper: paper_citation
 * @author Marco Angioli and Saeid Jamili
 * @email marco.angioli@uniroma1.it and saeid.jamili@uniroma1.it
 * @date Created on: 12th August 2023
 * @date Last updated on: 16th August 2023
 * @institution Sapienza University of Rome
 * @ref :
 * https://doi.org/10.xxxx/yyyyy
 *
 * @section LICENSE
 * ???
 *
 * @section CHANGELOG
 * @version 1.0.1
 * @date 16th August  2023
 */
"""
import numpy as np
import matplotlib.pyplot as plt
import random
import pandas as pd
import copy
import sys
import os


if len(sys.argv) > 1 and sys.argv[1] == "called_from_run_file":
    relative_path_prefix = ""
else:
    relative_path_prefix = "../../../"
    
# Append paths with the relative path prefix
sys.path.append(relative_path_prefix + 'src/config/')
sys.path.append(relative_path_prefix + 'src/model/python/classes')

import config_py as config
import HDC_class as HDC

import seaborn as sns
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix
import matplotlib.pyplot as plt
from report import Report
from data_export import DataExporter
from scipy.stats import mode
from rnd_gen import LFSR # ADDED BY SJ

def dataLoader(dataset):
    with open('./'+ dataset + '.csv', 'rb') as f:
         X = np.array(pd.read_csv(f, header=None))
    return X

# Function to modify the dataset format creating N-grams
# for performing temporal encoding
def createNGrams(X, N):
    numRows, numCols = X.shape
    nGrams = []

    for i in range(numRows - N + 1):
        nGram = []
        for col in range(numCols):
            for j in range(N):
                nGram.append(X[i + j, col])
        nGrams.append(nGram)

    return np.array(nGrams)

def createNGrams_labels(labels, N):
    numLabels = len(labels)
    processedLabels = []

    for i in range(numLabels - N + 1):
        window = labels[i:i + N]
        most_common_label = mode(window)[0][0]
        processedLabels.append(most_common_label)

    return np.array(processedLabels)


if __name__ == '__main__':

    # Print the configuration
    print('------------------\nHDC model:')
    print('Dataset:',               config.DS_NAME)
    print('HV dimensionality:',     config.HD_DIM)
    print('HV data type:',          config.HD_DATA_TYPE)
    print('HV mode:',               config.HD_MODE)
    print('HV level type:',         config.HD_LV_TYPE)
    print('HV level length:',       config.HD_LV_LEN)
    print('HV similarity method:',  config.HD_SIMI_METHOD)
    print("HV Encoding method:",    config.ENCODING_TECHNIQUE)
    print('HV sparsity factor:',    config.SPARSITY_FACTOR_X10)
    print('HV clipping encoding:',  config.CLIPPING_ENCODING)
    print('HV clipping class:',     config.CLIPPING_CLASS)
    print('N-gram:',                config.N_GRAM)
    print('N-gram size:',           config.N_GRAM_SIZE)
    print('Retrain:',               config.RETRAIN)
    print('Epochs:',                config.EPOCH)
    print('Learning rate:',         config.MAX_LEARNING_RATE)
    print('Learning rate decay:',   config.LR_DECAY)
    print('Beta learning rate:',    config.BETA_LR)
    print('------------------\n')


    app_ = relative_path_prefix + 'datasets/' + config.DS_NAME + '/'+config.DS_NAME

    # HDC_op model instance 
    HDC_model  = HDC.HDC_op(Dimensionality     = config.HD_DIM,
                            HV_type            = config.HD_DATA_TYPE,
                            density            = config.HD_MODE,
                            sparsity_factor    = config.SPARSITY_FACTOR_X10/10,
                            Number_of_features = config.DS_FEATURE_SIZE,
                            Number_of_levels   = config.HD_LV_LEN,
                            LevelTechnique     = config.HD_LV_TYPE,
                            similarity         = config.HD_SIMI_METHOD,
                            encoding_technique = config.ENCODING_TECHNIQUE,
                            clipping_encoding  = config.CLIPPING_ENCODING,
                            n_gram             = config.N_GRAM,
                            n_gram_size        = config.N_GRAM_SIZE,
                            num_classes        = config.DS_CLASSES_SIZE,
                            quantization_min   = config.QUANT_MIN,
                            quantization_max   = config.QUANT_MAX,
                            clipping_class     = config.CLIPPING_CLASS,
                            epochs             = config.EPOCH,
                            lr_max             = config.MAX_LEARNING_RATE,
                            lr_decay           = config.LR_DECAY,
                            beta_lr            = config.BETA_LR)                             
    
    # Dataset load:
    import scipy.io
    Train_data  = dataLoader(app_+'_train_data')
    Train_label = dataLoader(app_+'_train_label')
    Test_data   = dataLoader(app_+'_test_data' )
    Test_label  = dataLoader(app_+'_test_label')

    # N-gram dataset construction
    if (config.N_GRAM == 1):
        n_gram_train_data        = createNGrams(Train_data, config.N_GRAM_SIZE)
        n_gram_train_labels      = createNGrams_labels(Train_label, config.N_GRAM_SIZE)
        n_gram_test_data         = createNGrams(Test_data, config.N_GRAM_SIZE)
        n_gram_test_labels       = createNGrams_labels(Test_label, config.N_GRAM_SIZE)

    # HDC_model train
    if(config.RETRAIN==0):
        clip_class=config.CLIPPING_CLASS
    else:
        clip_class=config.CLIPPING_DISABLE

    if (config.N_GRAM == 0):
        train_dataset = Train_data
        train_labels  = Train_label
        test_dataset  = Test_data
        test_labels   = Test_label
    else:
        train_dataset = n_gram_train_data
        train_labels  = n_gram_train_labels
        test_dataset  = n_gram_test_data
        test_labels   = n_gram_test_labels

    quantized_levels, BaseHVs, LevelHVs, ClassHVs, bundled_labels =  HDC_model.train(train_data=train_dataset,
                                                                     train_labels=train_labels,
                                                                     ds_min_value=config.DS_DATA_RANGE_MIN,
                                                                     ds_max_value=config.DS_DATA_RANGE_MAX,
                                                                     clip_class=clip_class,
                                                                     verbose=1)

   
    # HDC_model test
    print("------------------\nTesting procedure:")
    accuracy, predicted_label = HDC_model.predict(test_data=test_dataset,
                                                  test_labels=test_labels,
                                                  BaseHVs=BaseHVs,
                                                  LevelHVs=LevelHVs,
                                                  ClassHVs=ClassHVs,
                                                  quant_levels=quantized_levels,
                                                  verbose=1)
    
    # HDC_model Retrain
    # Retrain:
    if (config.RETRAIN==1):
        # Retrain:
        ClassHVs,predicted_label = HDC_model.retrain(retrain_data=train_dataset,
                                                     retrain_labels=train_labels,
                                                     test_data=test_dataset,
                                                     test_label=test_labels,
                                                     BaseHVs=BaseHVs,
                                                     LevelHVs=LevelHVs,
                                                     ClassHVs=ClassHVs,         
                                                     quant_levels=quantized_levels,                                   
                                                     verbose=1,
                                                     starting_accuracy=accuracy,
                                                     bundled_labels=bundled_labels)
        
        # HDC_model test
        print("------------------\nFinal TEST:")
        accuracy, predicted_label = HDC_model.predict(test_data=test_dataset,
                                                  test_labels=test_labels,                                                  
                                                  BaseHVs=BaseHVs,
                                                  LevelHVs=LevelHVs,
                                                  ClassHVs=ClassHVs,
                                                  quant_levels=quantized_levels,
                                                  verbose=1)


                
    
####################################################################################################
####################################################################################################

    # GENERATE REPORT AND EXPORT PARAMETERS
    
    # Ensure the output directory exists
    output_dir = relative_path_prefix+'out//model_eva//'+config.DS_NAME+"//"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    # Check if the dataset directory exists
    dataset_dir = relative_path_prefix+"out//dataset//"+config.DS_NAME+"//"
    if not os.path.exists(dataset_dir):
        os.makedirs(dataset_dir)
    
    # Check if the extracted parameters directory exists
    extracted_params_dir = relative_path_prefix+"out//extracted_params//"+config.DS_NAME+"//"
    if not os.path.exists(extracted_params_dir):
        os.makedirs(extracted_params_dir)
    
    # Instantiate the Report class with the correct problem type
    ## @note: Set the problem type as 'multiclass' or 'binary' depending on your problem.
    reporter = Report(problem_type='multiclass')
    
    # Generate and save the report
    test_labels=test_labels[:len(predicted_label)]
    reporter.generate_report(y_test=test_labels, y_pred=predicted_label)
    report_file = output_dir + 'model_report.json'
    reporter.save_report(report_file)
    
    # Print the report saved path
    print(f"Model report saved to '{report_file}'.")
    
    # Generate and save the confusion matrix
    conf_matrix = confusion_matrix(test_labels, predicted_label)
    print('Confusion Matrix:\n', conf_matrix)
    np.savetxt(output_dir + 'confusion_matrix.csv', conf_matrix, delimiter=',')
    
    # Create a heatmap of the confusion matrix
    plt.figure(figsize=(10, 7))
    sns.heatmap(conf_matrix, annot=True, fmt='d')
    plt.title("Confusion matrix")
    plt.ylabel('True label')
    plt.xlabel('Predicted label')
    
    # Save the plot
    conf_matrix_img = output_dir + 'confusion_matrix.png'
    plt.savefig(conf_matrix_img)
    plt.close()
    
    # Print the confusion matrix image saved path
    print(f"Confusion matrix saved to '{conf_matrix_img}'.")
    
    # Export of the used dataset
    data_exporter = DataExporter(output_dir=dataset_dir)
    data_exporter.export_splitdataset(Train_data,  'train_data.csv')
    data_exporter.export_splitdataset(Train_label, 'train_label.csv')
    data_exporter.export_splitdataset(Test_data,   'test_data.csv')
    data_exporter.export_splitdataset(Test_label,  'test_label.csv')
    if (config.N_GRAM == 1):
        data_exporter.export_splitdataset(n_gram_train_data,    'n_gram_train_data.csv')
        data_exporter.export_splitdataset(n_gram_train_labels,  'n_gram_train_labels.csv')
        data_exporter.export_splitdataset(n_gram_test_data,     'n_gram_test_data.csv')
        data_exporter.export_splitdataset(n_gram_test_labels,   'n_gram_test_labels.csv')
        
    # Prepare the HyperVectors for export
    BaseHVs_o = copy.deepcopy(BaseHVs)
    LevelHVs_o = copy.deepcopy(LevelHVs)
    ClassHVs_o = copy.deepcopy(ClassHVs)
    BaseHVs_o[BaseHVs_o == -1] = 0
    LevelHVs_o[LevelHVs_o == -1] = 0
    ClassHVs_o[ClassHVs_o == -1] = 0
    
    # Export of the generated HyperVectors
    data_exporter = DataExporter(output_dir=extracted_params_dir)
    data_exporter.export_data(BaseHVs_o,  'BaseHVs.csv')
    data_exporter.export_data(LevelHVs_o, 'LevelHVs.csv')
    data_exporter.export_data(ClassHVs_o, 'ClassHVs.csv')
    
    
    # Export other parameters
    data_exporter.export_dict_to_json(HDC_model.get_bv_lfsr_params(), 'BaseHVs_gen')
    data_exporter.export_dict_to_json(HDC_model.get_lv_lfsr_params(), 'LevelHVs_gen')
    data_exporter.export_dict_to_json(HDC_model.get_clip_lut(), 'clip_lut')
    
    
    
