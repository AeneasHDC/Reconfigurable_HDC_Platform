
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
                    class_vec_out = 0b0010011111010101110111011001101010101011101000100111010101101010;
                    break;
                case 1:
                    class_vec_out = 0b0000011111110101110101011001100000100011101101110111011101111010;
                    break;
                case 2:
                    class_vec_out = 0b0010011111010111110111011001100000100011101000100111010101111010;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0010111010010111010000011000110110110000110110010010110011110111;
                    break;
                case 1:
                    class_vec_out = 0b0010111010010111010000010000111111110010110111010010110011110111;
                    break;
                case 2:
                    class_vec_out = 0b0010111010010011000000011000111110111000110111010010110011110011;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110110101011111101001011000110101110001110001110110110001010000;
                    break;
                case 1:
                    class_vec_out = 0b1110100101011111101001001000110101110001110010110110110001010000;
                    break;
                case 2:
                    class_vec_out = 0b1010110101010111101001001000110101111001110000010110110001010000;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1100000111101110100010110101100101111001111001111010011011001111;
                    break;
                case 1:
                    class_vec_out = 0b1100000011101110100010110101100101111001111011111011011011001111;
                    break;
                case 2:
                    class_vec_out = 0b1100010111101110000010110101000101111001111001111110011011001111;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1000101101111110100010110101100000000011100101111100111100000000;
                    break;
                case 1:
                    class_vec_out = 0b1000101111111110100010110101100000000011100101111100111101000000;
                    break;
                case 2:
                    class_vec_out = 0b1000101111111110101010110001100000000011101101111101100100000000;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1110111111110110111101000000111000000100100011010100001011100001;
                    break;
                case 1:
                    class_vec_out = 0b1110111111110110011101001001011000000100101011010100101011100001;
                    break;
                case 2:
                    class_vec_out = 0b1111111111110011111001000001110000000100101011000100001011100001;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b1111111000001010000001110111011111000011010010101111101100001011;
                    break;
                case 1:
                    class_vec_out = 0b1111111000001010000011110111011111000011010010101111101100001011;
                    break;
                case 2:
                    class_vec_out = 0b1111111000001010100001110111011111000001010010101111101100001011;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0110000101000001001110111001000000011001001010000011110001110100;
                    break;
                case 1:
                    class_vec_out = 0b0110000101000001001110011001000000011001001110000011110001110100;
                    break;
                case 2:
                    class_vec_out = 0b0110000101000001001110111001000000111001001010000011110001110100;
                    break;
            }
            break;
    }
}
#endif