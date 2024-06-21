/**
 * @file DataQuantizer.h
 * @brief This header file declares the DataQuantizer class for normalizing and quantizing data.
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
#ifndef DATAQUANTIZER_HPP
#define DATAQUANTIZER_HPP

#include <algorithm>  // for min, max

#include "./../../../../config/config_cpp.hpp"


class DataQuantizer {
public:

    static int quantize(float data, const std::vector<float>& quantization_levels) {
        // if (data < DS_DATA_RANGE_MIN || data > DS_DATA_RANGE_MAX) {
        //     throw std::runtime_error("Data is outside the specified range");
        // }
        if ( data < DS_DATA_RANGE_MIN )
            return 0;
        if ( data > DS_DATA_RANGE_MAX )
            return static_cast<int>(quantization_levels.size()) - 1;

        for (size_t i = 0; i < quantization_levels.size(); ++i) {
            if (data <= quantization_levels[i]) {
                return std::max(static_cast<int>(i), 0);
            }
            
        }

        return static_cast<int>(quantization_levels.size()) - 1;
    }

    static std::vector<int> quantize(const std::vector<float>& data_vec, const std::vector<float>& quantization_levels) {
        std::vector<int> quantized_vec;

        quantized_vec.reserve(data_vec.size());
        for (float data : data_vec) {
            quantized_vec.push_back(quantize(data, quantization_levels));
        }
        return quantized_vec;
    }
};


#endif  // DATAQUANTIZER_HPP
