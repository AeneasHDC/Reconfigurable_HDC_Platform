
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
            class_vec_out = 64'b0110101110011011110100110111000011101000100111101001111110111001;
          1:
            class_vec_out = 64'b0110101110111011110100110111000011001000100111111001111110111001;
          2:
            class_vec_out = 64'b0110101110111011110100110111010010101100100110101001111110111000;
        endcase
      1:
        case (frame_index)
          0:
            class_vec_out = 64'b0111011100001101100001000110011001001101001101010001111001000100;
          1:
            class_vec_out = 64'b0111011100001101100001000111011011001101000101010001111001100000;
          2:
            class_vec_out = 64'b0011011100011101100001000111011001001101001001010001111001000100;
        endcase
      2:
        case (frame_index)
          0:
            class_vec_out = 64'b0000110011010001100001010000100010101110001001101010111101100001;
          1:
            class_vec_out = 64'b0000110001010001100001010000100010101110001001101010111101011001;
          2:
            class_vec_out = 64'b0000110011010001100101010000100010101010001001101010111101100011;
        endcase
      3:
        case (frame_index)
          0:
            class_vec_out = 64'b0000001110010001101001110001010000111110001110101111101100001100;
          1:
            class_vec_out = 64'b0000000110010001101001110001010000111110101110100111101100001100;
          2:
            class_vec_out = 64'b0000000110010000101001110001010000101110101110100111101100001100;
        endcase
      4:
        case (frame_index)
          0:
            class_vec_out = 64'b0011111011011101100011101110110000110101001000001110011110000011;
          1:
            class_vec_out = 64'b0011111011001101101011001110110000010101001001001110011110000011;
          2:
            class_vec_out = 64'b0011011011011100100011001110110000100101001000001010001110000011;
        endcase
      5:
        case (frame_index)
          0:
            class_vec_out = 64'b1100110001111000010111001010101110011011111111001101111111010110;
          1:
            class_vec_out = 64'b1000110001011000010101001010101111011011011111001101111111010110;
          2:
            class_vec_out = 64'b1100110010111000010111001010101110011001011111001101111111010110;
        endcase
      6:
        case (frame_index)
          0:
            class_vec_out = 64'b1110100101100000001000010011101010001101110000100010111000101110;
          1:
            class_vec_out = 64'b1110100101100100001000010011001010001100110000100100111001101110;
          2:
            class_vec_out = 64'b1110100101100100001000010011101010001100110000100000111000101110;
        endcase
      7:
        case (frame_index)
          0:
            class_vec_out = 64'b1001011001001010110010011001010000111010111010110101000011111110;
          1:
            class_vec_out = 64'b1100001001001110110011011001010000111010111011110101000011111110;
          2:
            class_vec_out = 64'b0001001001001110110010011001010000111010111010110101000011111110;
        endcase
    endcase
  end
endmodule