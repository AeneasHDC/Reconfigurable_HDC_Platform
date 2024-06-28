
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
                    class_vec_out = 0b1110100110111101000001001110101011001101101100010010111111101001;
                    break;
                case 1:
                    class_vec_out = 0b1110100110101101000001011100101011001101100100011010011111101001;
                    break;
                case 2:
                    class_vec_out = 0b1110100110111101000001001110101011001101101100010011011111101001;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0111111100011010100001111100101100111010011000111000001010111000;
                    break;
                case 1:
                    class_vec_out = 0b0111111100011010000001111100101000111011011000101010001010111000;
                    break;
                case 2:
                    class_vec_out = 0b0111110100011010100001111100101100111010001000111001001011111000;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110100110011100101100011001111011010110001100101110110000111011;
                    break;
                case 1:
                    class_vec_out = 0b1110101110011101111100011001111011010110001100101110110000011011;
                    break;
                case 2:
                    class_vec_out = 0b1110100110011100011100011001111011010110001100101110010000011011;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1000110111001010110111010001001110100010101110010000000101011010;
                    break;
                case 1:
                    class_vec_out = 0b1000110111001010110111010001001110100010101110010000100101011010;
                    break;
                case 2:
                    class_vec_out = 0b1000111111001011110111010101001110100010101101010000000101011010;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1101111111101010010011101101001001000111001110110001100011100011;
                    break;
                case 1:
                    class_vec_out = 0b1111111111001001010011101101001001000111001110110001100011100010;
                    break;
                case 2:
                    class_vec_out = 0b1101011111001001010011101101001001000110001110110101100011100011;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0001110010001000011000101001110110001000111110001111000010000111;
                    break;
                case 1:
                    class_vec_out = 0b0011110010001000011000101001110100001000111110001101000000010111;
                    break;
                case 2:
                    class_vec_out = 0b0001110010001000011000101001110110001000101110001111000000000111;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000000101101110001000111101011010101000101100111010001011110000;
                    break;
                case 1:
                    class_vec_out = 0b0000000101101010001000011101011010101000101100111010001011110000;
                    break;
                case 2:
                    class_vec_out = 0b0000000101101110001010111101010010101000101100111001001011110100;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0100101100101000000111111000101111101110111110000010111110000011;
                    break;
                case 1:
                    class_vec_out = 0b0100101100101000000111111000101101101110111110000010111110000011;
                    break;
                case 2:
                    class_vec_out = 0b1100101100101000000111111000101101101110111110000110101100000011;
                    break;
            }
            break;
    }
}
#endif