
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
                    class_vec_out = 0b0011100111101100010000000010010101000001010011110000111101000000;
                    break;
                case 1:
                    class_vec_out = 0b0010101111100100010000000000010101000001010011100000111001000000;
                    break;
                case 2:
                    class_vec_out = 0b0010101111100100010000001010010101000001110011100000111101000000;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1001101111010100100001000011001011101100110010110110100110010101;
                    break;
                case 1:
                    class_vec_out = 0b1001101111010100101101000011001011101100110010100110100110010101;
                    break;
                case 2:
                    class_vec_out = 0b1001101111010100100001101011101001101100111010010010100100010101;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0011110011101011100111110001101010000000011001101001111011011101;
                    break;
                case 1:
                    class_vec_out = 0b0011111011101011100111110000100010000000111001101001111011011101;
                    break;
                case 2:
                    class_vec_out = 0b0011111010111011100110110001101010000000011000101001111011011101;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101101100110001110000011100110010111001111100110000000000011001;
                    break;
                case 1:
                    class_vec_out = 0b0101101100110001110000011100110110111001111100110000000000011001;
                    break;
                case 2:
                    class_vec_out = 0b0101101100110001110000011100110010101001111100110000001000011001;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0111110110111101101001000000100001101010000010101011100000111000;
                    break;
                case 1:
                    class_vec_out = 0b0111111110111101101001000000100001111010000011101011110000111000;
                    break;
                case 2:
                    class_vec_out = 0b0111110110111101101001000000100001101010000011101011111000111000;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1111100110011000110000010101110101001000110000000100010101010101;
                    break;
                case 1:
                    class_vec_out = 0b1111000110010100110000010101111111001011110000000100010001010101;
                    break;
                case 2:
                    class_vec_out = 0b1111110100011000110000010101110001001000110000000100010001010101;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000011101010110011000111001100100000110111111110010011010101000;
                    break;
                case 1:
                    class_vec_out = 0b0000011101010110010000101001101100000110111111110010011010101000;
                    break;
                case 2:
                    class_vec_out = 0b0000011001010110010000101001100100000110111111110010011010111000;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1011000100010110011111110010011001111000101110101000000010001011;
                    break;
                case 1:
                    class_vec_out = 0b1011000100010110011111110010011001111000101110101010000010001010;
                    break;
                case 2:
                    class_vec_out = 0b1011000100010110011111110010011001111000111110101001000010001011;
                    break;
            }
            break;
    }
}
#endif