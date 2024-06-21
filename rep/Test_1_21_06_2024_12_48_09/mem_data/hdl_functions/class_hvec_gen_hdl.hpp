
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
                    class_vec_out = 0b1001111100101111100011010011011010000111010000101110010101010111;
                    break;
                case 1:
                    class_vec_out = 0b1001111100111111100001010011011010000111010000101110000101010111;
                    break;
                case 2:
                    class_vec_out = 0b1000111100100111100001011011011010000111010000101110010101010111;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000110000100011001111100001010100100110100010011110100111111110;
                    break;
                case 1:
                    class_vec_out = 0b0010110000100011001111100001010110100110100000011110100111011110;
                    break;
                case 2:
                    class_vec_out = 0b0000010000100011001111100001010101100110100000011110100111111110;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1101111001111001100011101111000010101011011111000110011010101100;
                    break;
                case 1:
                    class_vec_out = 0b1101111101111001100011100111000010101011111011001010011010101100;
                    break;
                case 2:
                    class_vec_out = 0b1101111001111001100001101111000010101011011111000110011010101100;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1010111001011111010011011110111000101111101001000101011000011001;
                    break;
                case 1:
                    class_vec_out = 0b1010111001011111010011111100111000101111101001000101011000011001;
                    break;
                case 2:
                    class_vec_out = 0b1010111001011111010011001110111000101111101001010100011001011001;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000100011110001111010010010101101000100010001000101100011010011;
                    break;
                case 1:
                    class_vec_out = 0b0000000111110001111011010010101101000000010001000101100011110011;
                    break;
                case 2:
                    class_vec_out = 0b0000000111110101111010010010101101001100010001000101100011110011;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0011100111010111100100011001001101111110001100001111111001010100;
                    break;
                case 1:
                    class_vec_out = 0b0011100111010101100100011001001101111111001100001111111001010100;
                    break;
                case 2:
                    class_vec_out = 0b0011100111010111100100111001001101111111001100001111111001010111;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1011010101010011001011101000100000000010111100100110100000110111;
                    break;
                case 1:
                    class_vec_out = 0b1011010101010011001111100000100001100010111100100110100000110111;
                    break;
                case 2:
                    class_vec_out = 0b1011010101010111001011100000100001000011111100100110100100110111;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0011001110001000010011000011111010100111111000111101000011000100;
                    break;
                case 1:
                    class_vec_out = 0b0010001110001000010011000011111010100101111000101101001011000100;
                    break;
                case 2:
                    class_vec_out = 0b0010001110001000010011000011111010100111111000101100101011000100;
                    break;
            }
            break;
    }
}
#endif