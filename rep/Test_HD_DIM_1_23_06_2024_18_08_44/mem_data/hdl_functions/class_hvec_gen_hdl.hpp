
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
                    class_vec_out = 0b1010111100100100110110011000011000000010100101111010001111101100;
                    break;
                case 1:
                    class_vec_out = 0b1010110100100000110111010010011000000010100101111010001111101100;
                    break;
                case 2:
                    class_vec_out = 0b1010111100000100110110011000011000000010100101111010001111101100;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0100111010100110000010011100000011111101101000010101001110100110;
                    break;
                case 1:
                    class_vec_out = 0b0100111110100110000010011100000011110101101000010101011110100110;
                    break;
                case 2:
                    class_vec_out = 0b0100111010100110000010011100000010111101101000010101011110100110;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1011111011001111100000101001000010111011000111100110100001110001;
                    break;
                case 1:
                    class_vec_out = 0b1011111011001111100000101001000010111011000111100110100000110100;
                    break;
                case 2:
                    class_vec_out = 0b1011111011001111100001101001000010111011000111100111100000110111;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101101100000100100010111001000010111010101111001101011010111101;
                    break;
                case 1:
                    class_vec_out = 0b0101101100000100001010111001000010111010101111001101111010111101;
                    break;
                case 2:
                    class_vec_out = 0b0101101100000000000010111001000010111010101111001101111010111101;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101110011101101000101010010011010111000100011011100000000001110;
                    break;
                case 1:
                    class_vec_out = 0b0101110111101101001001010010011000111000100011011100000000001110;
                    break;
                case 2:
                    class_vec_out = 0b0101010011101101001101010010011000011000100001011101000000001110;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1100010010011011001100100011000110110000100100010110001111110001;
                    break;
                case 1:
                    class_vec_out = 0b1100010010011011000110010011000110110000100100010111001111110000;
                    break;
                case 2:
                    class_vec_out = 0b1100010010111011000100110011100110110000110100010010001111110000;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110110111001011010111101110010001111000111011000000010000011001;
                    break;
                case 1:
                    class_vec_out = 0b0100110111001011010111101100010001111000101010000000000000011011;
                    break;
                case 2:
                    class_vec_out = 0b0110110111001011010111101110010000111000101010000000010000011001;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0111011101011111110001001010001100101101101000111010110000110010;
                    break;
                case 1:
                    class_vec_out = 0b1111111101011111110001001010000100101101101010110010110000110010;
                    break;
                case 2:
                    class_vec_out = 0b0011111101010111110001001010000100101101101010110010110000110010;
                    break;
            }
            break;
    }
}
#endif