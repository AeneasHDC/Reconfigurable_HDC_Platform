
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
            class_vec_out = 64'b0101110010001100010011011110110010110010101000010011011100001011;
          1:
            class_vec_out = 64'b1101110011001101110001011001010001111010001000010010011100001011;
          2:
            class_vec_out = 64'b1101010010001101111011011100111000110010100000000011011110101001;
        endcase
      1:
        case (frame_index)
          0:
            class_vec_out = 64'b0010110110000000000100110111101101110001010101110010000000111110;
          1:
            class_vec_out = 64'b1010010110011000010100110111001101010101010000110000000000111110;
          2:
            class_vec_out = 64'b1010110101000000010100110111001101110100010000111000000001101110;
        endcase
      2:
        case (frame_index)
          0:
            class_vec_out = 64'b0101100011001001111111000111101011101111110111000100000010100011;
          1:
            class_vec_out = 64'b0101110011001001110111010111001010000011110011000100000000100011;
          2:
            class_vec_out = 64'b0101110011000001111100101011001111001111110011000100010010100011;
        endcase
      3:
        case (frame_index)
          0:
            class_vec_out = 64'b0110001111101000111000011110101000101000111101111000000111111011;
          1:
            class_vec_out = 64'b0110011101101001111001011100101000101000111101111000000111111011;
          2:
            class_vec_out = 64'b1110001111101001111000011100101000101000111101111000000111111011;
        endcase
      4:
        case (frame_index)
          0:
            class_vec_out = 64'b1101010110010011100010111101001001100010010001000000101110000000;
          1:
            class_vec_out = 64'b1101010110010011100010111101001001100010010001000000101110000000;
          2:
            class_vec_out = 64'b1101010110010011100010111101001001100010010001000000101110000000;
        endcase
      5:
        case (frame_index)
          0:
            class_vec_out = 64'b0000001000111110101110001001000111110010110111110011110000000111;
          1:
            class_vec_out = 64'b0000001000111110101110001001000111110010110111110011110000000111;
          2:
            class_vec_out = 64'b0000001000111110101110001001000111110010110111110011110000000111;
        endcase
      6:
        case (frame_index)
          0:
            class_vec_out = 64'b1011011001101001110111011010111000000010010101110101100011011100;
          1:
            class_vec_out = 64'b1011011001101001110111011010111000000010010101110101100011011100;
          2:
            class_vec_out = 64'b1011011001101001110111011010111000000010010101110101100011011100;
        endcase
      7:
        case (frame_index)
          0:
            class_vec_out = 64'b0001100000011000101011001101011010101011001110110001010001001111;
          1:
            class_vec_out = 64'b0001100000011000101011001101011010101011001110110001010001001111;
          2:
            class_vec_out = 64'b0001100000011000101011001101011010101011001110110001010001001111;
        endcase
    endcase
  end
endmodule