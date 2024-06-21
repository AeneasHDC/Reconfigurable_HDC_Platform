/**
 * @file sqrt_approx.hpp
 * @brief Header file for the ApproxSqrt class.
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

#ifndef SQRT_APPROX_HPP
#define SQRT_APPROX_HPP

#include <ap_int.h>

class ApproxSqrt {
public:
    /**
     * @brief Computes the approximate square root of an input integer.
     * @param number The input integer.
     * @return The approximate square root of the input number.
     */
    static ap_int<32> compute(ap_int<32> number) {
        #pragma HLS PIPELINE
        return digit_by_digit_sqrt(number);
    }

private:
    /**
     * @brief Determines the approximate square root using the digit-by-digit method.
     * @param number The input integer.
     * @return The approximate square root of the input number.
     */
    static ap_int<32> digit_by_digit_sqrt(ap_int<32> number) {
        if (number < 0) {
            return -1;
        }
        if (number == 0) {
            return 0;
        }

        ap_int<32> res = 0;
        ap_int<32> bit = 1 << 30;  // The second-to-top bit is set

        // "bit" starts at the highest power of four <= the argument
        while (bit > number) {
            bit >>= 2;
        }

        while (bit != 0) {
            if (number >= res + bit) {
                number -= res + bit;
                res = (res >> 1) + bit;
            } else {
                res >>= 1;
            }
            bit >>= 2;
        }

        return res;
    }
};

#endif // SQRT_APPROX_HPP

