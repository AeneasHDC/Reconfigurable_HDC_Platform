
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
                    class_vec_out = 0b0010001010110010101010101011110010111111011111100100001011000111;
                    break;
                case 1:
                    class_vec_out = 0b0010001011110110100110101011110010011111011111100100001011000111;
                    break;
                case 2:
                    class_vec_out = 0b0001001010110010101010101011110010111100011111100100001011000110;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101111110000101100001011101010000111100100111100111100010101000;
                    break;
                case 1:
                    class_vec_out = 0b0101111110000101110001010101010000111100100111100111100010101100;
                    break;
                case 2:
                    class_vec_out = 0b0101111110000101110001011101010010111100100111100111100010101100;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1111010011011100000110000010100010011011100110101111011001111001;
                    break;
                case 1:
                    class_vec_out = 0b1111010010011100000111000000100010111011100110101101011001111001;
                    break;
                case 2:
                    class_vec_out = 0b1101011011011110000110000000100010011011100010111101011001111001;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0111010110001110111011001101100011110001101111011101011000110000;
                    break;
                case 1:
                    class_vec_out = 0b0111010110001110111011001101100111110001101111111110001000110000;
                    break;
                case 2:
                    class_vec_out = 0b0111010100001110111011001101100011110001101111111011011000110000;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110011011110001000000101000100110100111110101000100011101011000;
                    break;
                case 1:
                    class_vec_out = 0b1110011111110000000010101000100110110011110101000100111101011001;
                    break;
                case 2:
                    class_vec_out = 0b1111011011110000000010101000100010011111110101000100011101010001;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1000000011000010010110110010101100100001100111100100110011000011;
                    break;
                case 1:
                    class_vec_out = 0b1010100011000110110110110010101100100001100111100100110111000111;
                    break;
                case 2:
                    class_vec_out = 0b1000000011000011010110110010101100100001100110100100110011000111;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1100010101110001110101111011100001100110110000111110111010111000;
                    break;
                case 1:
                    class_vec_out = 0b1100010101111101110101111111100001001110110000111110111010011000;
                    break;
                case 2:
                    class_vec_out = 0b1100010101110001110101111111100001100110110100111110111010011000;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010001010111001000111100000000111101001111100000011010111011001;
                    break;
                case 1:
                    class_vec_out = 0b0010001010111011000111100000100111001000101100000000010111001001;
                    break;
                case 2:
                    class_vec_out = 0b0010001010111011000111110000000111101001111100000001010111011001;
                    break;
            }
            break;
    }
}
#endif