
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
                    class_vec_out = 0b0011110110001010111111100100000101000110100000000110011101011111;
                    break;
                case 1:
                    class_vec_out = 0b0011110101001010111111100101000000100101100000011111011100011110;
                    break;
                case 2:
                    class_vec_out = 0b1011110110000010110111001101000101100111000001000110011111011110;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1010101110010010110101000011110100110010101110111100001010010110;
                    break;
                case 1:
                    class_vec_out = 0b1000101010010010010101000011010100110000100110111000001010110100;
                    break;
                case 2:
                    class_vec_out = 0b1001001010000011010101000110110100001000100110011000011110110100;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010011010110010000100111100110110100110111000001101110110011101;
                    break;
                case 1:
                    class_vec_out = 0b0010101010110010000100111100101110100010110100001111110111011110;
                    break;
                case 2:
                    class_vec_out = 0b0000110010110010000100111000110110100110111000101111110110011100;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1011100000001001110000001000010101100110011011110001101011010110;
                    break;
                case 1:
                    class_vec_out = 0b1011100000001001110000001000010101000110011011110001111011010111;
                    break;
                case 2:
                    class_vec_out = 0b1011100000011001110000001000010101100110011011110001101011010110;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101001011010010100101000011110011111001011010001110101100001101;
                    break;
                case 1:
                    class_vec_out = 0b0101001011010010100101000011110011111001011010001110101100001101;
                    break;
                case 2:
                    class_vec_out = 0b0101001011010010100101000011110011111001011010001110101100001101;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110110101010010111010101010110100000001100101011010011111101100;
                    break;
                case 1:
                    class_vec_out = 0b1110110101010010111010101010110100000001100101011010011111101100;
                    break;
                case 2:
                    class_vec_out = 0b1110110101010010111010101010110100000001100101011010011111101100;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0100111100011100100110010011010001011111110011000011000100111100;
                    break;
                case 1:
                    class_vec_out = 0b0100111100011100100110010011010001011111110011000011000100111100;
                    break;
                case 2:
                    class_vec_out = 0b0100111100011100100110010011010001011111110011000011000100111100;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1111101010010111010000111100101100001100001101001001101100001110;
                    break;
                case 1:
                    class_vec_out = 0b1111101010010111010000111100101100001100001101001001101100001110;
                    break;
                case 2:
                    class_vec_out = 0b1111101010010111010000111100101100001100001101001001101100001110;
                    break;
            }
            break;
    }
}
#endif