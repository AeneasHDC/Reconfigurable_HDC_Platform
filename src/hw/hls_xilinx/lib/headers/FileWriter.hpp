/**
 * @file ConfusionMatrixFileWriter.hpp
 * @brief Defines the FileWriter class for writing data to files.
 *
 * The FileWriter class provides functionality for writing various types of data to a file, including
 * individual lines, metrics related to model evaluation, and a confusion matrix. The class encapsulates
 * an ofstream object and exposes methods to write the data in specific formats.
 *
 *
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


#ifndef FILEWRITER_HPP
#define FILEWRITER_HPP

#include <vector>
#include <fstream>
#include <string>
#include <iostream>

#include <vector>
#include <iostream>
#include <fstream>
#include <string>

class FileWriter {
public:
    FileWriter(const std::string& filename) : file(filename) {
        if (!file.is_open()) {
            std::cout << "Failed to open file.\n";
        }
    }

    template <typename T>
    void writeLine(const T& line) {
        file << line << '\n';
    }

    void writeMetrics(const std::vector<float>& metrics) {
        static const std::vector<std::string> labels = {
            "accuracy",
            "precision",
            "recall",
            "f1_score",
            "roc_auc"
        };

        file << "{\n";
        for (size_t i = 0; i < metrics.size() && i < labels.size(); ++i) {
            file << "    \"" << labels[i] << "\": " << metrics[i];
            file << ",\n";
        }
    }

    void writeConfusionMatrix(const ConfusionMatrix& cm) {
        const auto& matrix = cm.getMatrix();

        file << "    \"confusion_matrix\": [\n";
        for (size_t i = 0; i < matrix.size(); ++i) {
            file << "        [";
            for (size_t j = 0; j < matrix[i].size(); ++j) {
                file << matrix[i][j];
                if (j + 1 < matrix[i].size()) {
                    file << ", ";
                }
            }
            file << "]";
            if (i + 1 < matrix.size()) {
                file << ",";
            }
            file << "\n";
        }
        file << "    ]\n";
        file << "}\n";
    }

    void writeMSE(float mse) {
		file << "{\n";
		file << "    \"MSE\": " << mse << "\n";
		file << "}\n";
	}


    void closeFile() {
        file.close();
    }

private:
    std::ofstream file;
};


#endif  // 
