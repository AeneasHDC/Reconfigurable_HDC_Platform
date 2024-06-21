%% 
% @file model.m
% @brief Main Matlab file for training and testing the HDC model on a given dataset.
%        All the model configuration parameters are specified in the config_m.m file.
%        All the possible dataset are specified in the dataset.py file.
%        The HDC model is implemented and completely handled in the HDC_op.m file.
%        Training and testing are fully automatized thanks to the HDC_class.
%        All the results are collected and reported in the output folder.
%        More information about the HDC model can be found in the following
%        accompanying research paper: paper_citation
% @author Marco Angioli and Saeid Jamili
% @email marco.angioli@uniroma1.it and saeid.jamili@uniroma1.it
% @note Authors name are listed in alphabetical order
% @date Created on: 12th August 2023
% @date Last updated on: 16th August 2023
% @institution Sapienza University of Rome
% @version 1.0.2
% @section LICENSE
%  Copyright 2024 Sapienza University of Rome
%  Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%  You may obtain a copy of the License at
%  
%      http://www.apache.org/licenses/LICENSE-2.0
%  
%  Unless required by applicable law or agreed to in writing, software
%  distributed under the License is distributed on an "AS IS" BASIS,
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%  See the License for the specific language governing permissions and
%  limitations under the License.
% Authors: Marco Angioli & Saeid Jamili
%%



% Load required libraries
addpath('./classes');
addpath('../../config');
run('config_matlab.m');



% Print the configuration
fprintf('------------------\nHDC model:\n');
fprintf('Dataset: %s\n', DS_NAME);
fprintf('HV dimensionality: %d\n', HD_DIM);
fprintf('HV data type: %s\n', HD_DATA_TYPE);
fprintf('HV mode: %s\n', HD_MODE);
fprintf('HV level type: %s\n', HD_LV_TYPE);
fprintf('HV level length: %d\n', HD_LV_LEN);
fprintf('HV similarity method: %s\n', HD_SIMI_METHOD);
fprintf('HV Encoding method: %s\n', ENCODING_TECHNIQUE);
fprintf('HV sparsity factor: %.2f\n', SPARSITY_FACTOR);
fprintf('HV clipping encoding: %d\n', CLIPPING_ENCODING);
fprintf('HV clipping class: %d\n', CLIPPING_CLASS);
fprintf('N-gram: %d\n', N_GRAM);
fprintf('N-gram size: %d\n', N_GRAM_SIZE);
fprintf('Retrain: %d\n', RETRAIN);
fprintf('Epochs: %d\n', EPOCH);
fprintf('Learning rate: %.2f\n', MAX_LEARNING_RATE);
fprintf('Learning rate decay: %s\n', LR_DECAY);
fprintf('Beta learning rate: %d\n', BETA_LR);
fprintf('------------------\n\n');

% Define paths
app_ = strcat('../../../datasets/', DS_NAME, '/', DS_NAME);
iter_ = EPOCH;

% HDC_model instance creation
HDC_model = HDC_op(HD_DIM, HD_DATA_TYPE, HD_MODE, SPARSITY_FACTOR, DS_FEATURE_SIZE, HD_LV_LEN, HD_LV_TYPE, HD_SIMI_METHOD);

% Dataset loading
Train_data = dataLoader(strcat(app_, '_train_data'));
Train_label = dataLoader(strcat(app_, '_train_label'));
Test_data = dataLoader(strcat(app_, '_test_data'));
Test_label = dataLoader(strcat(app_, '_test_label'));

% HDC_model train
if RETRAIN == 0
    clip_class = CLIPPING_CLASS;
else
    clip_class = CLIPPING_DISABLE;
end
[quantized_levels, BaseHVs, LevelHVs, ClassHVs] = HDC_model.train(Train_data, Train_label, DS_CLASSES_SIZE, HD_LV_LEN, DS_DATA_RANGE_MIN,DS_DATA_RANGE_MAX, CLIPPING_ENCODING,ENCODING_QUANT_MIN, ENCODING_QUANT_MAX,  clip_class,1, N_GRAM, N_GRAM_SIZE, ENCODING_TECHNIQUE);

% HDC_model test
fprintf('------------------\nTesting procedure:\n');
[accuracy, predicted_label] = HDC_model.predict(Test_data, Test_label, ...
    DS_CLASSES_SIZE, quantized_levels, BaseHVs, LevelHVs, ClassHVs, ...
    CLIPPING_ENCODING,ENCODING_QUANT_MIN, ENCODING_QUANT_MAX,  1, N_GRAM, N_GRAM_SIZE, ENCODING_TECHNIQUE);

% HDC_model Retrain
verbose=1;
if RETRAIN == 1
    fprintf('------------------\nRETRAINING:\n');
    [ClassHVs, predicted_label] = HDC_model.retrain(Train_data, Train_label, Test_data, Test_label, ...
        DS_CLASSES_SIZE, quantized_levels, BaseHVs, LevelHVs, ClassHVs, ...
        CLIPPING_ENCODING, ENCODING_QUANT_MIN, ENCODING_QUANT_MAX, verbose, N_GRAM, N_GRAM_SIZE, ...
        ENCODING_TECHNIQUE, CLIPPING_CLASS, EPOCH, accuracy, MAX_LEARNING_RATE, ...
        BETA_LR, LR_DECAY);
    
    fprintf('------------------\nFinal TEST:\n');
    [accuracy, predicted_label] = HDC_model.predict(Test_data, Test_label, ...
        DS_CLASSES_SIZE, quantized_levels, BaseHVs, LevelHVs, ClassHVs, ...
        CLIPPING_ENCODING, ENCODING_QUANT_MIN, ENCODING_QUANT_MAX, 1, N_GRAM, N_GRAM_SIZE, ENCODING_TECHNIQUE);
end

function X = dataLoader(dataset)
    filename = ['./', dataset, '.csv'];
    data = csvread(filename);
    X = data;
end







