
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
 * @version 0.0.1-dev
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
static void class_vec_gen(ap_uint<100> &class_vec_out, ap_uint<4> frame_id, ap_uint<2> frame_index) {
    // Update this function to match your requirements
    switch(frame_id) {
        case 0:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0001100001100101001100011101000001111100110100111101011001101010010011010000111011110100000100000000;
                    break;
                case 1:
                    class_vec_out = 0b0001100001100101001100011101000001111100111100111101011001101010010011010000011011010100000100000000;
                    break;
                case 2:
                    class_vec_out = 0b0001100001100101001100011101000001111100010100110101011001101110010001010000011011110100000110000000;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1111101011100000101000011101101011001100100010010101010111010001111000000001010001000101011110001010;
                    break;
                case 1:
                    class_vec_out = 0b1111101000100000101000111101101011001100100010010100010111010001111000000001010001000101011110001010;
                    break;
                case 2:
                    class_vec_out = 0b1111101001100000101000111101100001001000100000010101010111010001111000000001010001010101011110001010;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1000101101101001010111111010110110000100010101111101010011110101101110010010110011001001100101011101;
                    break;
                case 1:
                    class_vec_out = 0b0000101101101001010111111010110110000100010101110101010111110101101110011010100011001001100101011101;
                    break;
                case 2:
                    class_vec_out = 0b1000101101101001010111111000111110000100010101010101010011110101101110010010100011001001100101011001;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010110100001101101110000001000111100011110110010111011000100011011000011110111110000111111111111110;
                    break;
                case 1:
                    class_vec_out = 0b0011110110001101101110000001100111100010110110010111010000100011011010011110111110010110111111111110;
                    break;
                case 2:
                    class_vec_out = 0b0010111100001101101110000001000111100011110110010111011000100111011010011110111110010110110111111110;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0011010011110100011100111111100011010110101111100110000001101110011110100011000111000011010100100110;
                    break;
                case 1:
                    class_vec_out = 0b1011010011110100011100111101100011010110101111100110000001101110011110100011000111000011010000100110;
                    break;
                case 2:
                    class_vec_out = 0b1011010011110100011100111101100011010110101111100110100001101110011110100011000111000111010000100110;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010100001010011000011101111001101110101001010001111110000100010001100100110100000000101000111101101;
                    break;
                case 1:
                    class_vec_out = 0b0010100001110010000001101111001101110101001010001111110000100010101110100110100101000101000100101101;
                    break;
                case 2:
                    class_vec_out = 0b0010100001110010000001101111001101110101001010101111110000100011001100100010100101000101000111101101;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0011001110110000110001101100010111100100110111010000000001101011110010011111100111111001110000111110;
                    break;
                case 1:
                    class_vec_out = 0b0011001110111000110101101100010111100100110111010010000011101011110011011111101111111001110000111110;
                    break;
                case 2:
                    class_vec_out = 0b0011001110110000110101101100010111100100110111010000000001101011110010011111101111111001110000111110;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110000100010111110000001111101000100101010000111100101111100111110000010100011110101010111110111100;
                    break;
                case 1:
                    class_vec_out = 0b1110000100010111110001001111101000100101110000011100101111100111110000011100011110101010111110111100;
                    break;
                case 2:
                    class_vec_out = 0b1100000101010111110001001111101000100101010000011100101111100111110000010110111110101010111110111100;
                    break;
            }
            break;
        case 8:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000010111111111001111011000000001000001100001010010010011100110110011000001100001010101001000000000;
                    break;
                case 1:
                    class_vec_out = 0b0000010111111111001011011000001001000001100101010000010011100110110011000001100001010101011000000000;
                    break;
                case 2:
                    class_vec_out = 0b0000010111111111001011011000000101000001100000010010010111000110110011000001100001010101001000000100;
                    break;
            }
            break;
        case 9:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0110111011111110011001000001100100001001100101101001111000010010000111111111100000000101101100111110;
                    break;
                case 1:
                    class_vec_out = 0b0110101011111110011001000001100100100001100001101001011000010010000111111111100100000101101110101110;
                    break;
                case 2:
                    class_vec_out = 0b0110101011111110111001000001100100001001100001101001011100010010000111111111100010000101101100101010;
                    break;
            }
            break;
    }
}
#endif