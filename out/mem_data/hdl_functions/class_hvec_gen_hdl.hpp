
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
                    class_vec_out = 0b1011010110001100010001110011010000010011001011001001000000000000;
                    break;
                case 1:
                    class_vec_out = 0b1011010110001000010001110011010000010001001111101001000000000100;
                    break;
                case 2:
                    class_vec_out = 0b1011010110001100010001110001010000010011001101101001000001000000;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1000010000101110001010000011011001001111000001100100011100010011;
                    break;
                case 1:
                    class_vec_out = 0b1000010000101110001010010011011001101111000001100100011100010011;
                    break;
                case 2:
                    class_vec_out = 0b1000010000101110001010000011010001001011000001100101011100010011;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1100101001110000011101111111010110110010101101010110000110001011;
                    break;
                case 1:
                    class_vec_out = 0b1100101001110000011101111110011110111010101100110110000110001011;
                    break;
                case 2:
                    class_vec_out = 0b1100101001110000011111111111011110110010101101010110010110001011;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110101110011111111100111010100100100110001101001100101100001111;
                    break;
                case 1:
                    class_vec_out = 0b1110101110011111110100111010000100100110001101001110101100001111;
                    break;
                case 2:
                    class_vec_out = 0b1110101110011111110100111010000101100111001101001100100100001111;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1100111110110001000000101000110111011011000110010001010101010101;
                    break;
                case 1:
                    class_vec_out = 0b1100111110110001000001101010110111011011000110011001010110110101;
                    break;
                case 2:
                    class_vec_out = 0b1100111110110001000100101000110111011011000110110001010111110101;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1011001100011011100001011111101101101101110000010111000001001111;
                    break;
                case 1:
                    class_vec_out = 0b1011001100011011100111011111101101101101110010010111000011001111;
                    break;
                case 2:
                    class_vec_out = 0b1011001100011011100001010111101101101001111000010111000011001111;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0111110110011001111000110110011100010100000110100100001100101110;
                    break;
                case 1:
                    class_vec_out = 0b0111110110011001111000010110011101010100000110100100001101101110;
                    break;
                case 2:
                    class_vec_out = 0b0111110110011001111000110110011101010100000110100100001100101110;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1010110010101011001111111000010001000111101000000010011111001110;
                    break;
                case 1:
                    class_vec_out = 0b1110110110101000001111101000010000000111101000000010011111001110;
                    break;
                case 2:
                    class_vec_out = 0b1010110110101000001111101000010010000111101000000010011111001110;
                    break;
            }
            break;
    }
}
#endif