
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
                    class_vec_out = 0b0000000000001000000000000000000000000000000000000000000000000000;
                    break;
                case 1:
                    class_vec_out = 0b0000000000000000000000000000000000000000001000000000000000000000;
                    break;
                case 2:
                    class_vec_out = 0b0000000000001000000000000000000000000000000000000100000000000000;
                    break;
            }
            break;
        case 1:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000000000000000000000000000000000000000000000000000000000000000;
                    break;
                case 1:
                    class_vec_out = 0b0000000000000000000000000000000000000000000000000000000000000000;
                    break;
                case 2:
                    class_vec_out = 0b0000000000000000100000000000000000000000000000000000000000000000;
                    break;
            }
            break;
        case 2:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000000000000000000000000000000000000000010000000000000000000010;
                    break;
                case 1:
                    class_vec_out = 0b0000000000000000000000000000000000000000000000000000000000000000;
                    break;
                case 2:
                    class_vec_out = 0b0000000010000000000000000000000000000000000000000000000000000000;
                    break;
            }
            break;
        case 3:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000000000000000000000000000000000000001000000100000000000000000;
                    break;
                case 1:
                    class_vec_out = 0b0000000000000000100001101000000000000000000000000000000000000000;
                    break;
                case 2:
                    class_vec_out = 0b0000000100000000000000100000000000000000000000000100000100000000;
                    break;
            }
            break;
        case 4:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000000000000000000000000000000000000000000000000000000000000000;
                    break;
                case 1:
                    class_vec_out = 0b0000000000000000000000000000000000000000000000000000000000000000;
                    break;
                case 2:
                    class_vec_out = 0b0000001000000000000000000000000000000000000000000000000000000000;
                    break;
            }
            break;
        case 5:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000000000000000000000000000000000000000000000000000000000000000;
                    break;
                case 1:
                    class_vec_out = 0b0000000000000000000000000000000000000000000000000000000000000000;
                    break;
                case 2:
                    class_vec_out = 0b0000100000000000000000000000000000000000000000000000000010000000;
                    break;
            }
            break;
        case 6:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0000000000000010000000000000001000000000000000000000000000000000;
                    break;
                case 1:
                    class_vec_out = 0b0000000000000010000000000000000000000000000000010000000000000000;
                    break;
                case 2:
                    class_vec_out = 0b0000000000000000000000000000000000000000000000000000000000000000;
                    break;
            }
            break;
        case 7:
            switch(frame_index) {
                case 0:
                    class_vec_out = 0b0100000000000000000000000000000000000000000000000000000000000000;
                    break;
                case 1:
                    class_vec_out = 0b0000000000000000100000000000000000000000000000000000000000000000;
                    break;
                case 2:
                    class_vec_out = 0b0000000000000000100000000000000000000000000000000000000000000000;
                    break;
            }
            break;
    }
}
#endif