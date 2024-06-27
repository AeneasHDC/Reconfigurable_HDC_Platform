
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
            class_vec_out = 64'b0111110110011010100011101101101101011011011000011011110001101010;
          1:
            class_vec_out = 64'b0111110110011010100011101101101101011011011000011011110001100010;
          2:
            class_vec_out = 64'b0111110110011010100011101101101101011011011000011011110001101010;
        endcase
      1:
        case (frame_index)
          0:
            class_vec_out = 64'b0010100100001111101111110111101000101111110010100010111100011000;
          1:
            class_vec_out = 64'b0010100100011111101111100111111000101111110010100010111100011000;
          2:
            class_vec_out = 64'b0010100100001111101111110111101000101111110010100000111100011000;
        endcase
      2:
        case (frame_index)
          0:
            class_vec_out = 64'b0010011111101100000000100001010101011000011000110100010010110110;
          1:
            class_vec_out = 64'b0010011111101100000000100001011001011000011010101000011011110110;
          2:
            class_vec_out = 64'b0010011111101100000000100001010101011000011000111100010011110110;
        endcase
      3:
        case (frame_index)
          0:
            class_vec_out = 64'b1110101011110010000011000100101110100100110100000101101010111010;
          1:
            class_vec_out = 64'b1110101011100110000011000100101110100100110100000101101110110010;
          2:
            class_vec_out = 64'b1110101011110011000011000000111110100100110100001101101110100010;
        endcase
      4:
        case (frame_index)
          0:
            class_vec_out = 64'b0010100110111011010000011111101110011000101001100100010101101110;
          1:
            class_vec_out = 64'b0010100110111011010000011111101111011000101001100110010001100110;
          2:
            class_vec_out = 64'b0010100110111011110000001110101111011000101001100100000101101110;
        endcase
      5:
        case (frame_index)
          0:
            class_vec_out = 64'b0010111101110000010010100110001101010010111110011010110110111100;
          1:
            class_vec_out = 64'b0010111101110000010010100110001101011010101110011010110110111110;
          2:
            class_vec_out = 64'b0010111101110000010010100110001100110010101110011010011100111110;
        endcase
      6:
        case (frame_index)
          0:
            class_vec_out = 64'b1000011001010000000011011101011010011110100001010111001011011010;
          1:
            class_vec_out = 64'b1000011001010000000011111101011011011110100001011111001011011000;
          2:
            class_vec_out = 64'b1000011001010000000011111101001010011110100001010111001011011001;
        endcase
      7:
        case (frame_index)
          0:
            class_vec_out = 64'b0011110101101100101101110010011010111111011100010100000011110100;
          1:
            class_vec_out = 64'b0011110101101101111001100010010010111111111100010000000001110100;
          2:
            class_vec_out = 64'b1011110101001101111101100010010010111111111100010100010001110110;
        endcase
    endcase
  end
endmodule