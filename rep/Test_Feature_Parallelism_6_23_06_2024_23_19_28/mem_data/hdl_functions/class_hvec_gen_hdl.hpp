
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
                    class_vec_out = 0b1100001100010111111101100110101100111111111110000100100110100000;
                    break;
                case 1:
                    class_vec_out = 0b1100001100010111111101000110101100111111111111000100100110000000;
                    break;
                case 2:
                    class_vec_out = 0b1110001100110111111101000110111100111111111110000100100110100000;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0100000000111101100111000000111011110111011000010000101010010010;
                    break;
                case 1:
                    class_vec_out = 0b0100000000111101100101001001111011110111011001010000101010010010;
                    break;
                case 2:
                    class_vec_out = 0b0100000000111101100111001000111011110111011001010000101010010110;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010100100001010111111101000011000000000000110001101010110101110;
                    break;
                case 1:
                    class_vec_out = 0b0010100100011010111111101000011000000001100110001101110110101110;
                    break;
                case 2:
                    class_vec_out = 0b0010100100001011111111101000001000000101100110001101110110100110;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0100111100001101000110000100001111100110010100010110101101010011;
                    break;
                case 1:
                    class_vec_out = 0b0100111100001101000110000001001011100010010100010110101100010010;
                    break;
                case 2:
                    class_vec_out = 0b0100111100001111000110000000011111000110010100010110101101010011;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110011011101110100111001110000110010101011111000000011000000011;
                    break;
                case 1:
                    class_vec_out = 0b1110111011101110100111001111000111010101011111000010011000100010;
                    break;
                case 2:
                    class_vec_out = 0b0110111011100110100111001111000111010101011110000000011000100010;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1010111011111100011011111111101011001111100001010010101010000010;
                    break;
                case 1:
                    class_vec_out = 0b1110111011111100011011111101101011001111100001010010101000000010;
                    break;
                case 2:
                    class_vec_out = 0b1010101011111100011011111111001011001111110001010010101010000110;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010010011100111001111101110111001010110110110000001000110110111;
                    break;
                case 1:
                    class_vec_out = 0b0010010011100111001111100110111001010110110110000001000110110111;
                    break;
                case 2:
                    class_vec_out = 0b0010010011100111001111101110111001010110110110000001000110110111;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0110110101110101001111001011110110011010111011011101111101101110;
                    break;
                case 1:
                    class_vec_out = 0b0110110101110001001111001011110110011010111011011101011101001010;
                    break;
                case 2:
                    class_vec_out = 0b0110010101010101001111001011010110011011111011011101111101101010;
                    break;
            }
            break;
    }
}
#endif