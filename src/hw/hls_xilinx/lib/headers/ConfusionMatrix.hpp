/**
 * @file ConfusionMatrix.hpp
 * @brief Defines the ConfusionMatrix class for handling confusion matrices.
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

#ifndef CONFUSIONMATRIX_HPP
#define CONFUSIONMATRIX_HPP
#include <vector>

class ConfusionMatrix {
public:
    ConfusionMatrix(int numOfClasses) : matrix(numOfClasses, std::vector<int>(numOfClasses, 0)) {}

    void updateMatrix(int actualClass, int predictedClass) {
        ++matrix[actualClass][predictedClass];
    }

    const std::vector<std::vector<int>>& getMatrix() const {
        return matrix;
    }

    std::vector<float> calculateMetrics() {
        int n = matrix.size();
        std::vector<float> precision(n, 0.0f);
        std::vector<float> recall(n, 0.0f);
        std::vector<float> f1(n, 0.0f);
        int totalTrue = 0;
        int total = 0;

        for (int i = 0; i < n; ++i) {
            int truePositive = matrix[i][i];
            int falsePositive = 0;
            int falseNegative = 0;

            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    falsePositive += matrix[j][i];
                    falseNegative += matrix[i][j];
                }
                total += matrix[i][j];
                if(i==j){
                    totalTrue += matrix[i][j];
                }
            }

            if (truePositive + falsePositive != 0)
                precision[i] = truePositive / static_cast<float>(truePositive + falsePositive);
            if (truePositive + falseNegative != 0)
                recall[i] = truePositive / static_cast<float>(truePositive + falseNegative);
            if (precision[i] + recall[i] != 0)
                f1[i] = 2 * (precision[i] * recall[i]) / (precision[i] + recall[i]);
        }

        float accuracy = static_cast<float>(totalTrue) / total;

        // Placeholder for macro and micro metrics
        float macroPrecision = 0.0f;
        float macroRecall = 0.0f;
        float macroF1 = 0.0f;

        for (int i = 0; i < n; ++i) {
            macroPrecision += precision[i];
            macroRecall += recall[i];
            macroF1 += f1[i];
        }

        macroPrecision /= n;
        macroRecall /= n;
        macroF1 /= n;

        return std::vector<float>{accuracy, macroPrecision, macroRecall, macroF1};
    }

private:
    std::vector<std::vector<int>> matrix;
};


#endif  // CONFUSIONMATRIX_HPP
