/**
 * @file sqrt_approx.hpp
 * @brief Header file for the ApproxSqrt class.
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

