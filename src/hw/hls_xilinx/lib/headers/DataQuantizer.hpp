/**
 * @file DataQuantizer.h
 * @brief This header file declares the DataQuantizer class for normalizing and quantizing data.
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
