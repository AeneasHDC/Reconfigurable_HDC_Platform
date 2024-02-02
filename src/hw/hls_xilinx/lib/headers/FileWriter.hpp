/**
 * @file ConfusionMatrixFileWriter.hpp
 * @brief Defines the FileWriter class for writing data to files.
 *
 * The FileWriter class provides functionality for writing various types of data to a file, including
 * individual lines, metrics related to model evaluation, and a confusion matrix. The class encapsulates
 * an ofstream object and exposes methods to write the data in specific formats.
 *
 *
 * @author Saeid Jamili and Marco Angioli
 * @note Author names are listed in alphabetical order.
 * @email <saeid.jamili@uniroma1.it>
 * @email <marco.angioli@uniroma1.it>
 *
 * @contributors
 *
 * @date Created: 24th July 2023
 * @date Last Updated: 23th August 2023
 *
 * @version 1.0.0
 *
 * @institute Sapienza University of Rome
 * @cite https://doi.org/10.xxxx/yyyyy
 *
 * @section DEPENDENCIES
 * - 
 *
 * @section LICENSE
 * This file is part of the Aeneas HyperCompute Platform.
 *
 * Licensed under the MIT License. See the LICENSE file in the project root for full license details.
 *
 * @section CHANGELOG
 * @version 0.0.0=dev - 23th August 2023
 * - Initial release
 *
 * @todo
 * - 
 * - 
 *
 * @see
 * -
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
