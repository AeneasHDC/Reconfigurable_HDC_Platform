
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
                    class_vec_out = 0b0001011110101010010101101101101100001101111010000110101110011010;
                    break;
                case 1:
                    class_vec_out = 0b0001011110101010010101101101101100001101111010000110101110011010;
                    break;
                case 2:
                    class_vec_out = 0b0001011110101010010101101101101100101101111010100110101110010010;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000110111111000001001110111010110100001000010111000101000100101;
                    break;
                case 1:
                    class_vec_out = 0b0100010011111000001001110111010110100101000010111000101010100101;
                    break;
                case 2:
                    class_vec_out = 0b0000010111111000001001110111010111100001000010111000101010100101;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1101111011010100010000000011000010101001001001001001110011100111;
                    break;
                case 1:
                    class_vec_out = 0b1101111010011100010000000011000010101001001001001001110011100111;
                    break;
                case 2:
                    class_vec_out = 0b1100111000010100010000001011000010101001001001001001100011100111;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1011001101011100111100100001111010001011011100010011100100111110;
                    break;
                case 1:
                    class_vec_out = 0b1011001101011100111100100001111010000011011100110011100000101110;
                    break;
                case 2:
                    class_vec_out = 0b1111001101011100111110100001111010001111011100010011100000111110;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1100110001010000000000101101110111001001110111001101000011001001;
                    break;
                case 1:
                    class_vec_out = 0b1100110001010000001100101111010110001000110111001001000011101001;
                    break;
                case 2:
                    class_vec_out = 0b0101110001010000000100101111110110001001110101001101000010001000;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000001100111001101110010111110111011011101000100101010110010101;
                    break;
                case 1:
                    class_vec_out = 0b0000001100111001101110010101110111011011101000101101010110010101;
                    break;
                case 2:
                    class_vec_out = 0b0000001100111001101110010110110111011011111000100101010110010101;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1001101010011101101001000110100010101001011100001010000110000111;
                    break;
                case 1:
                    class_vec_out = 0b1001101010011101101001000110100010101001010101011011000111000111;
                    break;
                case 2:
                    class_vec_out = 0b1001101010011101101101000110100010100001011100011010000110000111;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000101100111011101111011101000000110010111111110101000111111101;
                    break;
                case 1:
                    class_vec_out = 0b1001101100111011101111011100000000110110111011011101001111110101;
                    break;
                case 2:
                    class_vec_out = 0b0000101100111011101110011100000000110010111111110101001111111101;
                    break;
            }
            break;
    }
}
#endif