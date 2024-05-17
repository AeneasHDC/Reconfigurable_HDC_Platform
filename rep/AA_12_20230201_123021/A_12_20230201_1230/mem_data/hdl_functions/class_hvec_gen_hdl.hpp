
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
                    class_vec_out = 0b1010010001001011000001011100101011100110010011101110110101010110111111100000101001111100011101101110;
                    break;
                case 1:
                    class_vec_out = 0b0010011001001011000001011100101001100110010011101110110101010110111111100000100001101101011101101110;
                    break;
                case 2:
                    class_vec_out = 0b1010011001001011000001011100101011100110010011101110110101010110111111100000100101111100011101101110;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0101101111010000011100000111100100101111011101011100011110000010101010001011110101010010000010111100;
                    break;
                case 1:
                    class_vec_out = 0b0101101111000000011100010111000100101111011001011100011110010010101010001011110101010110000010111100;
                    break;
                case 2:
                    class_vec_out = 0b0100101111011000011100000111000100101110011001011100011110000011101010001010110101010110000010111100;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000101101001111110010000001100100111010100100100100100110110000010001110101100011110110101010101101;
                    break;
                case 1:
                    class_vec_out = 0b0000101101001101100010000001100100111010100100100100100110110000010001110101101001110110101010101101;
                    break;
                case 2:
                    class_vec_out = 0b0000101101001111110010000001100100110000100100100100100110110000010001110101100011110110101010100101;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010011011101010100000010101111111011101000001100001100011001100011000111110111001011000010101000110;
                    break;
                case 1:
                    class_vec_out = 0b0010011111001110000000010101111111001111000001100001100011001100011000111110111011011100110101000110;
                    break;
                case 2:
                    class_vec_out = 0b0010011011001110100000010101111111010111000001100001100001000100011000111110110011011000010101100100;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0100011100011010111101101111100001001101011000011000110101110000110001001000011000101000000101010011;
                    break;
                case 1:
                    class_vec_out = 0b0100011100010010111101101111100001001101011000011000110101110000110001000000011000101000000101010011;
                    break;
                case 2:
                    class_vec_out = 0b0100011100010010111101101111100001000101011000011000111101110000110001001000011000101000001101010011;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0001110111111010011001000111111001100111011010000100111010000001001001100011111111001011110001110010;
                    break;
                case 1:
                    class_vec_out = 0b1001110111111010001101000011111101100111011001000100111010000001001001100011111111001011110001110010;
                    break;
                case 2:
                    class_vec_out = 0b0001110111111010011001000011111110100111011100000100111010000001001001100011111111001011110001110010;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1101011001101011100111000001011011000001010011111111001110010111010001110001011010000000010001000000;
                    break;
                case 1:
                    class_vec_out = 0b0111010001101011100111000001011011000001010011111111001110010111010001110001011010100001010101000100;
                    break;
                case 2:
                    class_vec_out = 0b1101011001101011101011001101011011000001010011111111001110100111010001110001011010000001010001000010;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010111001010111111010001010111000111010101000011101110000101101011101111100010101011111110000101101;
                    break;
                case 1:
                    class_vec_out = 0b0010011001010111111010001010111000111010101000011101110000101101011101111000011101111111010000101101;
                    break;
                case 2:
                    class_vec_out = 0b0010011001010111111010001010111000111010101000011101110000100101011101111000010101011111100000101100;
                    break;
            }
            break;
        case 8:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1101100001111101011110101000110001010110101110111101001000111000000101110001100100110010010110110111;
                    break;
                case 1:
                    class_vec_out = 0b1101100000111101011110101000110001010110001110101101001000111000000101110011101100110000010110110011;
                    break;
                case 2:
                    class_vec_out = 0b1101100001111101011110101000110101010110001100101101001000111000000001110001101100110000010110100011;
                    break;
            }
            break;
        case 9:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1010000101110000100000001101110100101111111010101111000100001101101000000001000100110000011000000010;
                    break;
                case 1:
                    class_vec_out = 0b1010000101110010100000001101110100100101111010101101000100001101101000000001000101110000010000010010;
                    break;
                case 2:
                    class_vec_out = 0b1010010001110000101000001111110100100111111110101111001100001101111000000001000100110000011000010010;
                    break;
            }
            break;
    }
}
#endif