/*
 * @file load_datasets.hpp
 * @brief Load the dataset from a given file
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
 * 
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
#include "../../config/config_cpp.hpp"
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
