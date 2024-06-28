
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
            class_vec_out = 64'b1010001100000111101100110000000011101100000010110001000100011101;
          1:
            class_vec_out = 64'b1010011100000111101100110000000111101100000010110001000100011001;
          2:
            class_vec_out = 64'b1110011100000111101100110000000011001100000010110001000110011001;
        endcase
      1:
        case (frame_index)
          0:
            class_vec_out = 64'b0001100111001000110010100101001000101011001011100101101011010110;
          1:
            class_vec_out = 64'b1001100111001000110010101101001000101011001010100101100011010110;
          2:
            class_vec_out = 64'b1001100111001000110010100101001001101011001010100101111011010010;
        endcase
      2:
        case (frame_index)
          0:
            class_vec_out = 64'b1100000000000010011000111111101010110001001110101111001111000000;
          1:
            class_vec_out = 64'b0100000000000010011000011111101010110001000110101111001011000000;
          2:
            class_vec_out = 64'b0000000000000010011000011111100010110001001110101111011111000000;
        endcase
      3:
        case (frame_index)
          0:
            class_vec_out = 64'b0111101101111001101111011010100000011001000100000110101110000101;
          1:
            class_vec_out = 64'b0111101101111001111111011010100000011001000100000110101110000111;
          2:
            class_vec_out = 64'b0111101111111001101111011010000000111001000100001010101110000111;
        endcase
      4:
        case (frame_index)
          0:
            class_vec_out = 64'b0001111110001001010001001110110000011100110111100011100000011010;
          1:
            class_vec_out = 64'b0001111110001101000001001110110000011100100111100011101000011010;
          2:
            class_vec_out = 64'b0001111110001001010001001110110000011100110111100011101000011010;
        endcase
      5:
        case (frame_index)
          0:
            class_vec_out = 64'b0010011110101100000110000101011100111001010101011110010110100100;
          1:
            class_vec_out = 64'b0010111010001100000100000101011100101001110101011100010110110100;
          2:
            class_vec_out = 64'b0010011110001100000100000101011100111101110101011110010110100100;
        endcase
      6:
        case (frame_index)
          0:
            class_vec_out = 64'b1000001100000100110001101100101110111111001111001110111000100000;
          1:
            class_vec_out = 64'b1000001100000100111101101100101110111111001101101110111000100000;
          2:
            class_vec_out = 64'b1000001100000100110001111100101110111111001111101110111110100100;
        endcase
      7:
        case (frame_index)
          0:
            class_vec_out = 64'b0101111111100010001001010101000101101001010100011100100000011010;
          1:
            class_vec_out = 64'b0101110111100010001001010100000111101001010100011000100001011010;
          2:
            class_vec_out = 64'b0101110111101010001001010101000101101001011101011110100000011010;
        endcase
    endcase
  end
endmodule