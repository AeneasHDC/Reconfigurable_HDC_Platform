
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
                    class_vec_out = 0b1010001100000111101100110000000011101100000010110001000100011101;
                    break;
                case 1:
                    class_vec_out = 0b1010011100000111101100110000000111101100000010110001000100011001;
                    break;
                case 2:
                    class_vec_out = 0b1110011100000111101100110000000011001100000010110001000110011001;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0001100111001000110010100101001000101011001011100101101011010110;
                    break;
                case 1:
                    class_vec_out = 0b1001100111001000110010101101001000101011001010100101100011010110;
                    break;
                case 2:
                    class_vec_out = 0b1001100111001000110010100101001001101011001010100101111011010010;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1100000000000010011000111111101010110001001110101111001111000000;
                    break;
                case 1:
                    class_vec_out = 0b0100000000000010011000011111101010110001000110101111001011000000;
                    break;
                case 2:
                    class_vec_out = 0b0000000000000010011000011111100010110001001110101111011111000000;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0111101101111001101111011010100000011001000100000110101110000101;
                    break;
                case 1:
                    class_vec_out = 0b0111101101111001111111011010100000011001000100000110101110000111;
                    break;
                case 2:
                    class_vec_out = 0b0111101111111001101111011010000000111001000100001010101110000111;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0001111110001001010001001110110000011100110111100011100000011010;
                    break;
                case 1:
                    class_vec_out = 0b0001111110001101000001001110110000011100100111100011101000011010;
                    break;
                case 2:
                    class_vec_out = 0b0001111110001001010001001110110000011100110111100011101000011010;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010011110101100000110000101011100111001010101011110010110100100;
                    break;
                case 1:
                    class_vec_out = 0b0010111010001100000100000101011100101001110101011100010110110100;
                    break;
                case 2:
                    class_vec_out = 0b0010011110001100000100000101011100111101110101011110010110100100;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1000001100000100110001101100101110111111001111001110111000100000;
                    break;
                case 1:
                    class_vec_out = 0b1000001100000100111101101100101110111111001101101110111000100000;
                    break;
                case 2:
                    class_vec_out = 0b1000001100000100110001111100101110111111001111101110111110100100;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101111111100010001001010101000101101001010100011100100000011010;
                    break;
                case 1:
                    class_vec_out = 0b0101110111100010001001010100000111101001010100011000100001011010;
                    break;
                case 2:
                    class_vec_out = 0b0101110111101010001001010101000101101001011101011110100000011010;
                    break;
            }
            break;
    }
}
#endif