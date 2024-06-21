#ifndef AUXILIARY_FUNCTIONS_HPP
#define AUXILIARY_FUNCTIONS_HPP
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
#include <bitset>
#include <vector>
#include <map>

struct LFSRParams {
    int OUT_BWIDTH;
    int N_OF_REM_FBITS;
    int b1, b2, b3, b4;
    uint64_t seed;

    LFSRParams(int out_bwidth, int n_of_rem_fbits, int b1, int b2, int b3, int b4, uint32_t seed)
    : OUT_BWIDTH(out_bwidth), N_OF_REM_FBITS(n_of_rem_fbits), b1(b1), b2(b2), b3(b3), b4(b4), seed(seed) {}
};

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

struct PredictionResult {
    float accuracy;
    std::vector<int> estimated_classes;
};

// ----------------------------
// OTHER FUNCTIONS
// Function to generate the quantization levels
// Input: min, max, levels
// Output: LevelList (array of thresholds for each quantization level)
// Example: min = 0, max = 1, levels = 4
//-----------------------------
void generate_quantization_levels(float min, float max, int levels, float LevelList[HD_LV_LEN]) {
    double length = max - min;
    double gap = length / levels;
    for (int level = 0; level < levels-1; ++level) {
        LevelList[level] = min + level * gap;
    }
    LevelList[levels-1] = max;
}

// Function to get the quantized level for a given value
int get_quantized_level(float value, float quantization_levels[HD_LV_LEN], int levels) {
    if (value <= quantization_levels[0]) {
        return 0;
    }
    if (value >= quantization_levels[levels-1]) {
        return levels - 1;
    }
    
    for (int i = 0; i < levels; ++i) {
        if (value <= quantization_levels[i]) {
            return std::max(0, i);
        }
    }

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


// Function to generate and save confusion matrix
void generateAndSaveConfMatrix(const std::vector<int>& test_labels, const std::vector<int>& predicted_labels, const std::string& output_dir) {
    // Assuming num_classes is defined and is the number of unique labels
    std::vector<std::vector<int>> conf_matrix(DS_CLASSES_SIZE, std::vector<int>(DS_CLASSES_SIZE, 0));

    for (size_t i = 0; i < test_labels.size(); ++i) {
        conf_matrix[test_labels[i]][predicted_labels[i]]++;
    }

    std::ofstream file(output_dir + "confusion_matrix.csv");
    for (const auto& row : conf_matrix) {
        for (const auto& val : row) {
            file << val << ",";
        }
        file << "\n";
    }
    file.close();
    std::cout << "Confusion matrix saved to '" << output_dir + "confusion_matrix.csv'" << std::endl;
}

// Function to export data (assumes data is in a suitable format)
// Function to export 2D array (e.g., Train_data, Test_data)
void export2DArray(float arr[][DS_FEATURE_SIZE], int numRows, const std::string& filepath) {
    std::ofstream file(filepath);
    if (!file.is_open()) {
        std::cerr << "Failed to open " << filepath << " for writing.\n";
        return;
    }

    for (int i = 0; i < numRows; ++i) {
        for (int j = 0; j < DS_FEATURE_SIZE; ++j) {
            file << arr[i][j];
            if (j < DS_FEATURE_SIZE - 1) file << ",";
        }
        file << "\n";
    }

    file.close();
}

// Function to export 1D array (e.g., Train_label, Test_label)
void export1DArray(int arr[], int size, const std::string& filepath) {
    std::ofstream file(filepath);
    if (!file.is_open()) {
        std::cerr << "Failed to open " << filepath << " for writing.\n";
        return;
    }

    for (int i = 0; i < size; ++i) {
        file << arr[i] << "\n";
    }

    file.close();
}


#endif