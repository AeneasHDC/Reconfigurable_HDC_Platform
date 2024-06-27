
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
                    class_vec_out = 0b0111010011000010011111110100100110000101101011000101110011111010;
                    break;
                case 1:
                    class_vec_out = 0b0110011011000010011111110100100110000101101011000101110011111010;
                    break;
                case 2:
                    class_vec_out = 0b0111010011000010011111110100100110000101101011000101110011111010;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1101100110111111111000011001100011010010001100100000011101011011;
                    break;
                case 1:
                    class_vec_out = 0b1101100110111111111000011001100011010010001100100000011101011011;
                    break;
                case 2:
                    class_vec_out = 0b1101100110111111111000011001100011010010001100100000011101011011;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110000110101000010011001101101011011100100100111011000000110100;
                    break;
                case 1:
                    class_vec_out = 0b1110000100101000010011001101011111011100100100111101000010110011;
                    break;
                case 2:
                    class_vec_out = 0b1110000100101000010011011101101011011100100100111011000010110000;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0110111001111110011101101010011000010101010111111100000100111001;
                    break;
                case 1:
                    class_vec_out = 0b0110111000111110001101101000011000010101010111111100000100110001;
                    break;
                case 2:
                    class_vec_out = 0b0111111001011110111101100010011100000001010111011100000100111011;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0111111100101111110011010101110000110001010000110110110100100111;
                    break;
                case 1:
                    class_vec_out = 0b0110111100101111110011010101110000110001000000110110110100100110;
                    break;
                case 2:
                    class_vec_out = 0b0111110000101111110011010101110010110001010000110111110100100110;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1011001000110001010000100101011101101101111011101010110111100010;
                    break;
                case 1:
                    class_vec_out = 0b1011001000100001010000100111011101101101111011101010110111100010;
                    break;
                case 2:
                    class_vec_out = 0b1011001100100001010100100110011101101101111011100010110111100010;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000001101011000101001011101101001101100001000011101101000011110;
                    break;
                case 1:
                    class_vec_out = 0b0000001101011000101001011101101001101100101000011101101010011110;
                    break;
                case 2:
                    class_vec_out = 0b0100001100011010101001011101001001100100101000011101101000011110;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0001110111100110100000010001111110100111011010001100001110100011;
                    break;
                case 1:
                    class_vec_out = 0b0111110010100111100101010001011110110111011010001100001110100011;
                    break;
                case 2:
                    class_vec_out = 0b0001110111100110101000010001111110100111111010001100001110100011;
                    break;
            }
            break;
    }
}
#endif