
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
            class_vec_out = 64'b1101101100110100100011001100101100111001101111010000000110010010;
          1:
            class_vec_out = 64'b1101101101110100100011001100101100111001101111010101000110010010;
          2:
            class_vec_out = 64'b1101101100110100100011001100100100111001101111010100000110010010;
        endcase
      1:
        case (frame_index)
          0:
            class_vec_out = 64'b1110011001111100001111101100000001110011000101101101100010101010;
          1:
            class_vec_out = 64'b1110011001111100001111101100001001110011000101101111100010111010;
          2:
            class_vec_out = 64'b1110010001111100001011101100000001110011100101101111100110111010;
        endcase
      2:
        case (frame_index)
          0:
            class_vec_out = 64'b0101000110110110110011110101001100011011110100001000011100000001;
          1:
            class_vec_out = 64'b0101000111110100110011110101001100011011110100001000011100010001;
          2:
            class_vec_out = 64'b0101000110110110110011110101001100011011110100001000011100010001;
        endcase
      3:
        case (frame_index)
          0:
            class_vec_out = 64'b1001010001001011100011101001001111101100111100100001101010000000;
          1:
            class_vec_out = 64'b1001010001101011100011101001111111101100110110100001111010000000;
          2:
            class_vec_out = 64'b1001010001001011100011001000001111101100111101100001111010000000;
        endcase
      4:
        case (frame_index)
          0:
            class_vec_out = 64'b1001000101111110011111000010110101011110110100010110000101101100;
          1:
            class_vec_out = 64'b1001000101111110011111000010110101010110110100110110000101101100;
          2:
            class_vec_out = 64'b1001000101111110011111000010110101011110110100010110000101001100;
        endcase
      5:
        case (frame_index)
          0:
            class_vec_out = 64'b1110111110011011110010001100110000101001101100111101000010111111;
          1:
            class_vec_out = 64'b1110101110011011110011001100110000101001101100111101000010111111;
          2:
            class_vec_out = 64'b1010101010111011010010001100110000101001101010101001000010111111;
        endcase
      6:
        case (frame_index)
          0:
            class_vec_out = 64'b0101101001011100001010100011110001000000100011001101011110000000;
          1:
            class_vec_out = 64'b0101101001011000001010100011110001000000110011001101011100000000;
          2:
            class_vec_out = 64'b0101101001011000001010100011110001000000110011001111011110000100;
        endcase
      7:
        case (frame_index)
          0:
            class_vec_out = 64'b0101110100011000111000111001111000000101110010110100110011110010;
          1:
            class_vec_out = 64'b0101100100011000111000111001111100000101110010110100110011110010;
          2:
            class_vec_out = 64'b0101110101011000111000111001110000000101110010110100110011110010;
        endcase
    endcase
  end
endmodule