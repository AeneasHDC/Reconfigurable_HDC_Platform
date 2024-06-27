
/**
 * @file class_hvec_gen_hdl.hpp
 * @brief This script generates HDL code for generating high-dimensional class vectors.
 * It is a novel method; for more information, please refer to our paper.
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
 * - Dependency1: Description or version details.
 * - Dependency2: Description or version details.
 *
 * @section LICENSE
 * This file is part of the Aeneas HyperCompute Platform.
 *
 * Licensed under the MIT License. See the LICENSE file in the project root for full license details.
 *
 * @section CHANGELOG
 * @version 1.0.0-dev - 23th August 2023
 * - Initial release
 *
 * @todo
 * - Complete level vector generator function
 * - Add training
 *
 * @see
 * -
 * -
 * -
 *
 */

#ifndef CLASS_VEC_GEN_H
#define CLASS_VEC_GEN_H
#include <ap_int.h>
static void class_vec_gen(ap_uint<64> &class_vec_out, ap_uint<3> frame_id, ap_uint<2> frame_index) {
    // Update this function to match your requirements
    switch(frame_id) {
        case 0:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0001101111100111110000001101010111101010000011000101000110000111;
                    break;
                case 1:
                    class_vec_out = 0b0001101111101111110000001101010111101010000011000101010111000111;
                    break;
                case 2:
                    class_vec_out = 0b0001101111100111110000001101010111101010000011000100010011000111;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110010001110001000011011101111101101110110000110000100100100011;
                    break;
                case 1:
                    class_vec_out = 0b1110010001110001100010011101111101101110110000010000110100100011;
                    break;
                case 2:
                    class_vec_out = 0b1110010001110001000010011101111101101110110000110010100100100011;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110000101111111000101100000011010000001101001100111011001000001;
                    break;
                case 1:
                    class_vec_out = 0b1100000101111110000101100000011010000001100001100111011000100011;
                    break;
                case 2:
                    class_vec_out = 0b1110000101111110000101100000011011000001101001100111011001100001;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1010001011111101111010011110001100110001011011100011001011110101;
                    break;
                case 1:
                    class_vec_out = 0b1010001001111101111011011110000100110001011011100110001010110101;
                    break;
                case 2:
                    class_vec_out = 0b1010001011111101111010011110000100110001011011100111001010110101;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1011010110001011010101101110110110010000011101100101110010100101;
                    break;
                case 1:
                    class_vec_out = 0b1011010110001011010101101110110110010001010101001101110110100101;
                    break;
                case 2:
                    class_vec_out = 0b1011010110001011010001101110110110010001010001101101110010100101;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0110110000100110010001000001111001101110111101100010010000001101;
                    break;
                case 1:
                    class_vec_out = 0b1110110000100110010011000001111001100110101101100010010100001101;
                    break;
                case 2:
                    class_vec_out = 0b0110110000100110010011000001111001100110101101100110010000001101;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0111011101001111110110101100010111110111101010100110001101010001;
                    break;
                case 1:
                    class_vec_out = 0b0111010101000111110110101100010111110111101010100110011101010001;
                    break;
                case 2:
                    class_vec_out = 0b0111011101001111110110101100010111110111101010100110011100010101;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1101111001001001111111001111101100001001100001011011110110110111;
                    break;
                case 1:
                    class_vec_out = 0b1100111001001000111111001111101100001000100001011011100110010110;
                    break;
                case 2:
                    class_vec_out = 0b1101011001000001111111001111100100001000110001011011100010010111;
                    break;
            }
            break;
    }
}
#endif