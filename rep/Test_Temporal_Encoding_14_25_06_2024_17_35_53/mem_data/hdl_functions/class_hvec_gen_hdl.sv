
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

module class_hvec_gen #(parameter int DI_PARALLEL_W_BITS = 64) (
  input logic [2:0] frame_id,
  input logic [1:0] frame_index,
  output logic [DI_PARALLEL_W_BITS-1:0] class_vec_out
);
  always_comb begin
    case (frame_id)
      0:
        case (frame_index)
          0:
            class_vec_out = 64'b0111110011111100000011110100111100111000000001000011000011000111;
          1:
            class_vec_out = 64'b0111110011111100000011110100111100111000000000100001000011000111;
          2:
            class_vec_out = 64'b0111111011111110000111110100111101111000100000100001000010001111;
        endcase
      1:
        case (frame_index)
          0:
            class_vec_out = 64'b1000001111111100001000111100001111001001000010001111110100111100;
          1:
            class_vec_out = 64'b0000001111110100011000111100001111001001000010000111110100111100;
          2:
            class_vec_out = 64'b0000001111110100001000001100001111001010000010001111110100111100;
        endcase
      2:
        case (frame_index)
          0:
            class_vec_out = 64'b1001000111110000011111001000011110001100000000100111000111111011;
          1:
            class_vec_out = 64'b1011000100110000001101000000110110011100000011100111000111101001;
          2:
            class_vec_out = 64'b1011000110110100011001000000111000000100000000100111000101111011;
        endcase
      3:
        case (frame_index)
          0:
            class_vec_out = 64'b1001001110001100110001100100110010000110000000001001100100001000;
          1:
            class_vec_out = 64'b1001000110001100110011100000110010000110000000001001100100001000;
          2:
            class_vec_out = 64'b1001000110001100110001100000110010000010010011001001100100001000;
        endcase
      4:
        case (frame_index)
          0:
            class_vec_out = 64'b1111001110000001100000100100000111111110000000110011000000001100;
          1:
            class_vec_out = 64'b1111000110000001100001100110000111111110000000110011100000001100;
          2:
            class_vec_out = 64'b1111000100000000000001100000000111111110000000110011000000001100;
        endcase
      5:
        case (frame_index)
          0:
            class_vec_out = 64'b1110111111001111100000000100000011010011100001000010000011100011;
          1:
            class_vec_out = 64'b1110111111111111100000000111000011010011000001000010000011100011;
          2:
            class_vec_out = 64'b1110111111101111110000000000000111010011100001000010000011010011;
        endcase
      6:
        case (frame_index)
          0:
            class_vec_out = 64'b0111111101100000001000000111100000000011110001000010011110110000;
          1:
            class_vec_out = 64'b0111111100100000001000000111000000000011010001000010011110110000;
          2:
            class_vec_out = 64'b0111111101100000001000001111100000000011110001001010011110100000;
        endcase
      7:
        case (frame_index)
          0:
            class_vec_out = 64'b0111101110011000100110000000000011000111000110001110110000000000;
          1:
            class_vec_out = 64'b0111101110111000100110000000000011100111000110011110110010000000;
          2:
            class_vec_out = 64'b0111100010111010100110010000000011100011000110001100110010000000;
        endcase
    endcase
  end
endmodule