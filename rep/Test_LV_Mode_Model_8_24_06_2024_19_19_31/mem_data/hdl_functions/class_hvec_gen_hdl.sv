
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
            class_vec_out = 64'b0111010011000010011111110100100110000101101011000101110011111010;
          1:
            class_vec_out = 64'b0110011011000010011111110100100110000101101011000101110011111010;
          2:
            class_vec_out = 64'b0111010011000010011111110100100110000101101011000101110011111010;
        endcase
      1:
        case (frame_index)
          0:
            class_vec_out = 64'b1101100110111111111000011001100011010010001100100000011101011011;
          1:
            class_vec_out = 64'b1101100110111111111000011001100011010010001100100000011101011011;
          2:
            class_vec_out = 64'b1101100110111111111000011001100011010010001100100000011101011011;
        endcase
      2:
        case (frame_index)
          0:
            class_vec_out = 64'b1110000110101000010011001101101011011100100100111011000000110100;
          1:
            class_vec_out = 64'b1110000100101000010011001101011111011100100100111101000010110011;
          2:
            class_vec_out = 64'b1110000100101000010011011101101011011100100100111011000010110000;
        endcase
      3:
        case (frame_index)
          0:
            class_vec_out = 64'b0110111001111110011101101010011000010101010111111100000100111001;
          1:
            class_vec_out = 64'b0110111000111110001101101000011000010101010111111100000100110001;
          2:
            class_vec_out = 64'b0111111001011110111101100010011100000001010111011100000100111011;
        endcase
      4:
        case (frame_index)
          0:
            class_vec_out = 64'b0111111100101111110011010101110000110001010000110110110100100111;
          1:
            class_vec_out = 64'b0110111100101111110011010101110000110001000000110110110100100110;
          2:
            class_vec_out = 64'b0111110000101111110011010101110010110001010000110111110100100110;
        endcase
      5:
        case (frame_index)
          0:
            class_vec_out = 64'b1011001000110001010000100101011101101101111011101010110111100010;
          1:
            class_vec_out = 64'b1011001000100001010000100111011101101101111011101010110111100010;
          2:
            class_vec_out = 64'b1011001100100001010100100110011101101101111011100010110111100010;
        endcase
      6:
        case (frame_index)
          0:
            class_vec_out = 64'b0000001101011000101001011101101001101100001000011101101000011110;
          1:
            class_vec_out = 64'b0000001101011000101001011101101001101100101000011101101010011110;
          2:
            class_vec_out = 64'b0100001100011010101001011101001001100100101000011101101000011110;
        endcase
      7:
        case (frame_index)
          0:
            class_vec_out = 64'b0001110111100110100000010001111110100111011010001100001110100011;
          1:
            class_vec_out = 64'b0111110010100111100101010001011110110111011010001100001110100011;
          2:
            class_vec_out = 64'b0001110111100110101000010001111110100111111010001100001110100011;
        endcase
    endcase
  end
endmodule