
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
            class_vec_out = 64'b1100100011100010110011100011000110100100010101101100001011101101;
          1:
            class_vec_out = 64'b1000000011100010110111101011000010100110010100000100111010011100;
          2:
            class_vec_out = 64'b1101001011100010110011110010001110100110110100111100011111101111;
        endcase
      1:
        case (frame_index)
          0:
            class_vec_out = 64'b0100010101111111010011000101100101011011110100001010010100010000;
          1:
            class_vec_out = 64'b0100010001111111010011001101100111011001110100001010010000001001;
          2:
            class_vec_out = 64'b0100011001110111001011100100100111010101000101101010010100011001;
        endcase
      2:
        case (frame_index)
          0:
            class_vec_out = 64'b1101101111101000101001100001000101111100100000011101110011100000;
          1:
            class_vec_out = 64'b1101101111001000101000100000000100111100000000011100100011000101;
          2:
            class_vec_out = 64'b1101101101111000101001110001000010111100100000011100110011100000;
        endcase
      3:
        case (frame_index)
          0:
            class_vec_out = 64'b0111110110101010100101100110000100111011010100000111010011001001;
          1:
            class_vec_out = 64'b0111110110101010101101100110000000111011010100000101010011001000;
          2:
            class_vec_out = 64'b1111110110101010100101100110000100111011010100000111010011001001;
        endcase
      4:
        case (frame_index)
          0:
            class_vec_out = 64'b0011100100000101001100111000110001110110011001010010110001000101;
          1:
            class_vec_out = 64'b0011100100000101001100111000110001110110011001010010110001000101;
          2:
            class_vec_out = 64'b0011100100000101001100111000110001110110011001010010110001000101;
        endcase
      5:
        case (frame_index)
          0:
            class_vec_out = 64'b1110001111011011011011110000101010100111111000111111011100101110;
          1:
            class_vec_out = 64'b1110001111011011011011110000101010100111111000111111011100101110;
          2:
            class_vec_out = 64'b1110001111011011011011110000101010100111111000111111011100101110;
        endcase
      6:
        case (frame_index)
          0:
            class_vec_out = 64'b0100010100011101010110001100010000100000001111000111100101010011;
          1:
            class_vec_out = 64'b0100010100011101010110001100010000100000001111000111100101010011;
          2:
            class_vec_out = 64'b0100010100011101010110001100010000100000001111000111100101010011;
        endcase
      7:
        case (frame_index)
          0:
            class_vec_out = 64'b0010101101100001111110000101111111100011000011101110110110001000;
          1:
            class_vec_out = 64'b0010101101100001111110000101111111100011000011101110110110001000;
          2:
            class_vec_out = 64'b0010101101100001111110000101111111100011000011101110110110001000;
        endcase
    endcase
  end
endmodule