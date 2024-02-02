/**
 * @file ConfusionMatrix.hpp
 * @brief Defines the ConfusionMatrix class for handling confusion matrices.
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
