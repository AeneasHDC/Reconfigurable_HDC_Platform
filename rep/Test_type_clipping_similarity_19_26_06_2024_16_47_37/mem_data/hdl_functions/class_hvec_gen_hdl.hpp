
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
                    class_vec_out = 0b1101101100110100100011001100101100111001101111010000000110010010;
                    break;
                case 1:
                    class_vec_out = 0b1101101101110100100011001100101100111001101111010101000110010010;
                    break;
                case 2:
                    class_vec_out = 0b1101101100110100100011001100100100111001101111010100000110010010;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110011001111100001111101100000001110011000101101101100010101010;
                    break;
                case 1:
                    class_vec_out = 0b1110011001111100001111101100001001110011000101101111100010111010;
                    break;
                case 2:
                    class_vec_out = 0b1110010001111100001011101100000001110011100101101111100110111010;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101000110110110110011110101001100011011110100001000011100000001;
                    break;
                case 1:
                    class_vec_out = 0b0101000111110100110011110101001100011011110100001000011100010001;
                    break;
                case 2:
                    class_vec_out = 0b0101000110110110110011110101001100011011110100001000011100010001;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1001010001001011100011101001001111101100111100100001101010000000;
                    break;
                case 1:
                    class_vec_out = 0b1001010001101011100011101001111111101100110110100001111010000000;
                    break;
                case 2:
                    class_vec_out = 0b1001010001001011100011001000001111101100111101100001111010000000;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1001000101111110011111000010110101011110110100010110000101101100;
                    break;
                case 1:
                    class_vec_out = 0b1001000101111110011111000010110101010110110100110110000101101100;
                    break;
                case 2:
                    class_vec_out = 0b1001000101111110011111000010110101011110110100010110000101001100;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110111110011011110010001100110000101001101100111101000010111111;
                    break;
                case 1:
                    class_vec_out = 0b1110101110011011110011001100110000101001101100111101000010111111;
                    break;
                case 2:
                    class_vec_out = 0b1010101010111011010010001100110000101001101010101001000010111111;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101101001011100001010100011110001000000100011001101011110000000;
                    break;
                case 1:
                    class_vec_out = 0b0101101001011000001010100011110001000000110011001101011100000000;
                    break;
                case 2:
                    class_vec_out = 0b0101101001011000001010100011110001000000110011001111011110000100;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101110100011000111000111001111000000101110010110100110011110010;
                    break;
                case 1:
                    class_vec_out = 0b0101100100011000111000111001111100000101110010110100110011110010;
                    break;
                case 2:
                    class_vec_out = 0b0101110101011000111000111001110000000101110010110100110011110010;
                    break;
            }
            break;
    }
}
#endif