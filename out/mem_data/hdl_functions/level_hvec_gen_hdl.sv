/**
 * @file level_hvec_gen_hdl.hpp
 * @brief This script generates HDL code for generating high-dimensional LEVEL vectors.
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

module level_hvec_gen #(parameter int DI_PARALLEL_W_BITS = 64) (
  input logic [2:0] frame_index,
  input logic [4:0] frame_id,
  output logic [DI_PARALLEL_W_BITS-1:0] level_vec_out
);
  always_comb begin
    case (frame_index)
      0:
        case (frame_id)
          0:
            level_vec_out = 64'b1101000110100011111111000001001011100100111001010101110010101000;
          1:
            level_vec_out = 64'b1101000110100011111111000001001011110100111001010101110010101000;
          2:
            level_vec_out = 64'b1101000110100011111111000001001011110101111001010101110010101000;
          3:
            level_vec_out = 64'b1101000110100011111111000001001111110101111001010101110010101000;
          4:
            level_vec_out = 64'b1101000110100011111111001001001111110101111001010101110010101000;
          5:
            level_vec_out = 64'b1101000110100011111111001001001111110101111001010101110010101000;
          6:
            level_vec_out = 64'b1101000110100011111111001001001111110111111001010101110010101000;
          7:
            level_vec_out = 64'b1101000111100011111111101001001111110111111101010101110010111000;
          8:
            level_vec_out = 64'b1101000111100011111111101001001111110111111101010101110010111000;
          9:
            level_vec_out = 64'b1101000111100011111111101001011111110111111101010111110010111000;
          10:
            level_vec_out = 64'b1101000111101011111111101001011111110111111101010111110010111000;
          11:
            level_vec_out = 64'b1101000111101011111111101011011111110111111101010111110010111000;
          12:
            level_vec_out = 64'b1101001111101011111111101011011111110111111101010111110010111000;
          13:
            level_vec_out = 64'b1101001111101011111111101011011111110111111101110111110010111000;
          14:
            level_vec_out = 64'b1101001111101011111111101011011111110111111101110111110010111001;
          15:
            level_vec_out = 64'b1101001111101011111111101011011111110111111101110111110010111001;
          16:
            level_vec_out = 64'b1101001111101011111111101011011111110111111111110111110010111001;
          17:
            level_vec_out = 64'b1101001111101011111111101011111111110111111111110111110010111001;
          18:
            level_vec_out = 64'b1101001111101011111111101011111111110111111111110111110011111001;
          19:
            level_vec_out = 64'b1101001111101011111111101011111111110111111111110111110011111001;
          20:
            level_vec_out = 64'b1101001111101011111111101011111111110111111111110111110011111001;
          21:
            level_vec_out = 64'b1111001111101011111111101011111111110111111111110111110011111101;
          22:
            level_vec_out = 64'b1111001111101011111111101011111111110111111111110111110011111101;
          23:
            level_vec_out = 64'b1111001111101111111111101011111111110111111111110111111011111101;
          24:
            level_vec_out = 64'b1111101111101111111111101011111111110111111111110111111011111101;
          25:
            level_vec_out = 64'b1111101111101111111111101011111111110111111111110111111011111101;
          26:
            level_vec_out = 64'b1111101111111111111111101011111111110111111111110111111011111101;
          27:
            level_vec_out = 64'b1111101111111111111111101111111111110111111111110111111011111101;
          28:
            level_vec_out = 64'b1111111111111111111111101111111111110111111111111111111011111101;
          29:
            level_vec_out = 64'b1111111111111111111111101111111111110111111111111111111111111101;
          30:
            level_vec_out = 64'b1111111111111111111111101111111111110111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111101111111111110111111111111111111111111111;
        endcase
      1:
        case (frame_id)
          0:
            level_vec_out = 64'b0010110001000000001111101000010110001010111000100110110001100100;
          1:
            level_vec_out = 64'b0010110001000000001111101000011110001010111000100110110001100100;
          2:
            level_vec_out = 64'b0011110001000000001111101000011110001110111000100110110001100100;
          3:
            level_vec_out = 64'b0111110001000000001111101000011110001110111000100110110001100100;
          4:
            level_vec_out = 64'b0111110001000000001111101000011110001110111000100110110001100100;
          5:
            level_vec_out = 64'b0111110001100000001111101000011110001110111000100110110001100100;
          6:
            level_vec_out = 64'b0111110001100000011111101000011110001110111000100110110001100100;
          7:
            level_vec_out = 64'b0111110001100000011111101000011110001110111000100110110001100100;
          8:
            level_vec_out = 64'b0111110001100000011111101000011110001110111000100110110001100100;
          9:
            level_vec_out = 64'b0111110001110000011111101000011110001110111000100110110001100100;
          10:
            level_vec_out = 64'b0111110001110000011111101000011110001110111000100111110101100100;
          11:
            level_vec_out = 64'b0111110001111000011111101000011110001110111000100111110101100100;
          12:
            level_vec_out = 64'b0111110011111000011111101100011110001110111000100111110101101100;
          13:
            level_vec_out = 64'b0111110011111000011111101100011110001110111000100111110101101101;
          14:
            level_vec_out = 64'b0111110011111000011111101100111110001110111000101111110111101111;
          15:
            level_vec_out = 64'b0111111011111000011111101100111110001110111000101111110111101111;
          16:
            level_vec_out = 64'b0111111011111000011111101100111110011110111000101111110111101111;
          17:
            level_vec_out = 64'b0111111011111000011111101100111110011110111100101111110111101111;
          18:
            level_vec_out = 64'b0111111011111000011111101100111110111110111111101111110111101111;
          19:
            level_vec_out = 64'b0111111011111101011111101100111111111110111111101111110111101111;
          20:
            level_vec_out = 64'b0111111011111101011111101100111111111110111111101111110111101111;
          21:
            level_vec_out = 64'b0111111011111101011111101100111111111110111111101111110111111111;
          22:
            level_vec_out = 64'b0111111011111101011111111100111111111110111111101111110111111111;
          23:
            level_vec_out = 64'b0111111011111101111111111100111111111110111111101111111111111111;
          24:
            level_vec_out = 64'b0111111011111101111111111100111111111110111111101111111111111111;
          25:
            level_vec_out = 64'b0111111011111111111111111100111111111110111111101111111111111111;
          26:
            level_vec_out = 64'b0111111111111111111111111100111111111110111111101111111111111111;
          27:
            level_vec_out = 64'b0111111111111111111111111110111111111111111111111111111111111111;
          28:
            level_vec_out = 64'b1111111111111111111111111110111111111111111111111111111111111111;
          29:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
          30:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        endcase
      2:
        case (frame_id)
          0:
            level_vec_out = 64'b0111000010001010000101101110110111100111011010000001001111111111;
          1:
            level_vec_out = 64'b0111000010001010000101101110110111100111011010000001001111111111;
          2:
            level_vec_out = 64'b0111000010001010000101101110110111100111011010001001001111111111;
          3:
            level_vec_out = 64'b0111000010001010100101101110110111100111011011001001001111111111;
          4:
            level_vec_out = 64'b0111000010001010100101101111110111100111011011001001001111111111;
          5:
            level_vec_out = 64'b0111000010001010100101101111111111100111011011001011001111111111;
          6:
            level_vec_out = 64'b0111000010001010101101101111111111101111011011001011001111111111;
          7:
            level_vec_out = 64'b0111000011001010101101101111111111101111011111001011011111111111;
          8:
            level_vec_out = 64'b0111000011001010101101111111111111101111011111001011011111111111;
          9:
            level_vec_out = 64'b0111100011001010101101111111111111101111011111001011011111111111;
          10:
            level_vec_out = 64'b0111100011001010101101111111111111101111011111001011011111111111;
          11:
            level_vec_out = 64'b0111100011001110101101111111111111101111011111001011011111111111;
          12:
            level_vec_out = 64'b1111100011001110101101111111111111101111011111001011011111111111;
          13:
            level_vec_out = 64'b1111100011001110101101111111111111101111011111001011011111111111;
          14:
            level_vec_out = 64'b1111100011001110101101111111111111101111011111001011011111111111;
          15:
            level_vec_out = 64'b1111100011001110101101111111111111101111111111001011011111111111;
          16:
            level_vec_out = 64'b1111100011001110101101111111111111111111111111001011011111111111;
          17:
            level_vec_out = 64'b1111100011001110101101111111111111111111111111001011011111111111;
          18:
            level_vec_out = 64'b1111100011001110101101111111111111111111111111001011011111111111;
          19:
            level_vec_out = 64'b1111100011001110101101111111111111111111111111001011011111111111;
          20:
            level_vec_out = 64'b1111110011001111101101111111111111111111111111001111011111111111;
          21:
            level_vec_out = 64'b1111110011001111101101111111111111111111111111001111111111111111;
          22:
            level_vec_out = 64'b1111110011011111101111111111111111111111111111001111111111111111;
          23:
            level_vec_out = 64'b1111110011111111101111111111111111111111111111001111111111111111;
          24:
            level_vec_out = 64'b1111111011111111101111111111111111111111111111011111111111111111;
          25:
            level_vec_out = 64'b1111111011111111101111111111111111111111111111011111111111111111;
          26:
            level_vec_out = 64'b1111111011111111101111111111111111111111111111011111111111111111;
          27:
            level_vec_out = 64'b1111111011111111101111111111111111111111111111111111111111111111;
          28:
            level_vec_out = 64'b1111111111111111101111111111111111111111111111111111111111111111;
          29:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
          30:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        endcase
      3:
        case (frame_id)
          0:
            level_vec_out = 64'b1010101011101001010010111110001110111000101100100101010100001111;
          1:
            level_vec_out = 64'b1010101011101001010010111110001110111000101100100101010100001111;
          2:
            level_vec_out = 64'b1010101011101001010010111110001110111000101100100101010100001111;
          3:
            level_vec_out = 64'b1010101011101001010010111110001110111000101101100101010100001111;
          4:
            level_vec_out = 64'b1010101111101001010010111110001110111000101101100101010100001111;
          5:
            level_vec_out = 64'b1010101111101001010010111110001110111000101101100101010100001111;
          6:
            level_vec_out = 64'b1010101111101001010010111110001111111000101101100101010100001111;
          7:
            level_vec_out = 64'b1010101111101001010010111110001111111000101101100101010100001111;
          8:
            level_vec_out = 64'b1010101111101001010110111110001111111000101101100101010100001111;
          9:
            level_vec_out = 64'b1110101111101001010110111110001111111000101101100101010100001111;
          10:
            level_vec_out = 64'b1110101111101001010110111110001111111000101101100101010100001111;
          11:
            level_vec_out = 64'b1110101111101001010110111111001111111000101101100101010100001111;
          12:
            level_vec_out = 64'b1110101111101001010110111111001111111010111101100101010100001111;
          13:
            level_vec_out = 64'b1110101111101001010110111111001111111010111101100101011100001111;
          14:
            level_vec_out = 64'b1110101111101101010110111111001111111010111101100101011100001111;
          15:
            level_vec_out = 64'b1110101111101111010110111111001111111010111101100101011100001111;
          16:
            level_vec_out = 64'b1110101111101111010110111111001111111010111101100101011100001111;
          17:
            level_vec_out = 64'b1110101111101111011110111111101111111010111101100101011100001111;
          18:
            level_vec_out = 64'b1110101111101111011110111111101111111010111101100101011100001111;
          19:
            level_vec_out = 64'b1110101111101111011111111111101111111011111101100101011110001111;
          20:
            level_vec_out = 64'b1110101111101111011111111111101111111011111101100101111110001111;
          21:
            level_vec_out = 64'b1110101111101111011111111111101111111011111101100101111110001111;
          22:
            level_vec_out = 64'b1110101111101111011111111111101111111011111101100111111110001111;
          23:
            level_vec_out = 64'b1110101111101111011111111111101111111011111111100111111110001111;
          24:
            level_vec_out = 64'b1110101111101111011111111111101111111011111111110111111110101111;
          25:
            level_vec_out = 64'b1110101111101111011111111111101111111011111111111111111110101111;
          26:
            level_vec_out = 64'b1110101111101111011111111111101111111011111111111111111111101111;
          27:
            level_vec_out = 64'b1111101111101111011111111111101111111011111111111111111111111111;
          28:
            level_vec_out = 64'b1111111111101111011111111111101111111111111111111111111111111111;
          29:
            level_vec_out = 64'b1111111111101111011111111111101111111111111111111111111111111111;
          30:
            level_vec_out = 64'b1111111111101111111111111111101111111111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111101111111111111111111111111111111111;
        endcase
      4:
        case (frame_id)
          0:
            level_vec_out = 64'b0101011111100100111000111101010111000011001111000000110000000011;
          1:
            level_vec_out = 64'b0101011111100100111001111101010111000011001111000000110000000011;
          2:
            level_vec_out = 64'b0101011111100100111001111101010111000011001111000000110000100011;
          3:
            level_vec_out = 64'b1101011111110100111001111101010111000011001111000000110000100011;
          4:
            level_vec_out = 64'b1101011111110100111001111101010111000011001111000000110000100011;
          5:
            level_vec_out = 64'b1101011111110100111011111101011111000011001111000000110010100011;
          6:
            level_vec_out = 64'b1101011111110100111011111101011111000011101111000000110010100011;
          7:
            level_vec_out = 64'b1101011111110100111011111101011111000011101111000000110010100011;
          8:
            level_vec_out = 64'b1101011111110100111011111101011111000011101111000000110010100011;
          9:
            level_vec_out = 64'b1101011111110100111011111101011111000011101111000000110010100011;
          10:
            level_vec_out = 64'b1101111111110100111111111101011111000011101111100000110010100011;
          11:
            level_vec_out = 64'b1101111111110100111111111101011111000011101111100000110010100011;
          12:
            level_vec_out = 64'b1101111111110100111111111101011111000011101111100000110010100011;
          13:
            level_vec_out = 64'b1101111111110100111111111101011111000011101111110000110010100011;
          14:
            level_vec_out = 64'b1101111111110100111111111101011111000011101111110000110110100011;
          15:
            level_vec_out = 64'b1101111111110100111111111101011111000011101111110000110110100011;
          16:
            level_vec_out = 64'b1101111111110100111111111101011111000011101111110000110110100011;
          17:
            level_vec_out = 64'b1101111111110100111111111101011111000011101111111000110110100011;
          18:
            level_vec_out = 64'b1101111111110100111111111101011111000011101111111000110110100111;
          19:
            level_vec_out = 64'b1101111111110100111111111101011111000111101111111000110110100111;
          20:
            level_vec_out = 64'b1101111111110100111111111111011111000111101111111000110110100111;
          21:
            level_vec_out = 64'b1101111111110100111111111111111111000111101111111000111110100111;
          22:
            level_vec_out = 64'b1101111111110100111111111111111111000111101111111010111110100111;
          23:
            level_vec_out = 64'b1101111111110100111111111111111111000111101111111010111110100111;
          24:
            level_vec_out = 64'b1101111111110101111111111111111111000111101111111010111111100111;
          25:
            level_vec_out = 64'b1101111111110101111111111111111111000111101111111110111111110111;
          26:
            level_vec_out = 64'b1101111111110101111111111111111111010111101111111110111111110111;
          27:
            level_vec_out = 64'b1101111111110101111111111111111111010111101111111110111111110111;
          28:
            level_vec_out = 64'b1101111111110101111111111111111111010111101111111110111111110111;
          29:
            level_vec_out = 64'b1101111111110111111111111111111111010111101111111110111111110111;
          30:
            level_vec_out = 64'b1101111111111111111111111111111111010111101111111110111111110111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111111110111101111111111111111110111;
        endcase
      5:
        case (frame_id)
          0:
            level_vec_out = 64'b1101110101101100101001010111000100001010100100011111101101100100;
          1:
            level_vec_out = 64'b1101110101101110101001010111000100001010100100011111101101101100;
          2:
            level_vec_out = 64'b1101110101101110101001010111000100001010100100011111101101101110;
          3:
            level_vec_out = 64'b1101110101101110101001010111000100001010100100011111101101101110;
          4:
            level_vec_out = 64'b1101110101101110101001010111001100001110100100011111101101101110;
          5:
            level_vec_out = 64'b1101110101101110101011010111001100001110100100011111101101101110;
          6:
            level_vec_out = 64'b1101110101101110101011010111001100001111100100011111101101101110;
          7:
            level_vec_out = 64'b1101110101101110101011110111001100001111100100011111101101101110;
          8:
            level_vec_out = 64'b1101110101101110101011110111001100001111100100111111101101101110;
          9:
            level_vec_out = 64'b1101110101101110101011110111001100001111100100111111101111101110;
          10:
            level_vec_out = 64'b1101110111101110101011110111001100001111100100111111101111101110;
          11:
            level_vec_out = 64'b1101110111101110101011110111001100001111100100111111101111101110;
          12:
            level_vec_out = 64'b1101110111101110101011110111001100001111100100111111101111101110;
          13:
            level_vec_out = 64'b1101111111101110101011110111001100001111100100111111101111101110;
          14:
            level_vec_out = 64'b1101111111101110101011110111001100001111100100111111101111101110;
          15:
            level_vec_out = 64'b1101111111101110101011110111001101001111100100111111111111101110;
          16:
            level_vec_out = 64'b1101111111101111101011110111001101001111101100111111111111101110;
          17:
            level_vec_out = 64'b1101111111101111101111110111001101001111101100111111111111101110;
          18:
            level_vec_out = 64'b1101111111101111101111111111001101001111101100111111111111101110;
          19:
            level_vec_out = 64'b1101111111101111101111111111001101001111101100111111111111101110;
          20:
            level_vec_out = 64'b1101111111101111101111111111001101001111101110111111111111111110;
          21:
            level_vec_out = 64'b1111111111101111101111111111001101001111101110111111111111111110;
          22:
            level_vec_out = 64'b1111111111101111101111111111001101001111111110111111111111111110;
          23:
            level_vec_out = 64'b1111111111101111101111111111001101001111111110111111111111111110;
          24:
            level_vec_out = 64'b1111111111101111101111111111001101001111111110111111111111111110;
          25:
            level_vec_out = 64'b1111111111101111111111111111001101001111111111111111111111111111;
          26:
            level_vec_out = 64'b1111111111101111111111111111001101001111111111111111111111111111;
          27:
            level_vec_out = 64'b1111111111111111111111111111001101001111111111111111111111111111;
          28:
            level_vec_out = 64'b1111111111111111111111111111001101001111111111111111111111111111;
          29:
            level_vec_out = 64'b1111111111111111111111111111011101001111111111111111111111111111;
          30:
            level_vec_out = 64'b1111111111111111111111111111111101001111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111101111111111111111111111111111111;
        endcase
      6:
        case (frame_id)
          0:
            level_vec_out = 64'b0001101111111010100000001111101110111110001110001100101110000100;
          1:
            level_vec_out = 64'b0001101111111010100000001111101110111110001110001100101111000100;
          2:
            level_vec_out = 64'b0001101111111010100000001111101110111110001110001100101111000100;
          3:
            level_vec_out = 64'b0001101111111010100000001111101110111110001110001100101111000100;
          4:
            level_vec_out = 64'b0001111111111010100000001111101110111110001110011100101111000100;
          5:
            level_vec_out = 64'b0001111111111010110000001111101110111110001110011100101111000100;
          6:
            level_vec_out = 64'b0001111111111010110000001111101110111110001110011110101111000100;
          7:
            level_vec_out = 64'b0001111111111010110000001111101110111110001110011110101111000100;
          8:
            level_vec_out = 64'b0101111111111010110000001111101110111110001110011110101111000100;
          9:
            level_vec_out = 64'b0101111111111010110100001111101110111110001110011110101111010100;
          10:
            level_vec_out = 64'b0101111111111010110100001111101110111110001110011110101111010100;
          11:
            level_vec_out = 64'b0101111111111011110100101111101110111110001110011110101111010100;
          12:
            level_vec_out = 64'b0111111111111011110100101111101110111110001110011110101111010100;
          13:
            level_vec_out = 64'b0111111111111111110100101111101110111110001110011110101111010100;
          14:
            level_vec_out = 64'b0111111111111111110100101111101110111110001110011110101111010100;
          15:
            level_vec_out = 64'b0111111111111111110100101111101110111111001110011110101111010101;
          16:
            level_vec_out = 64'b0111111111111111110100101111111110111111001110011110101111010101;
          17:
            level_vec_out = 64'b0111111111111111110100101111111111111111001110011110101111010101;
          18:
            level_vec_out = 64'b0111111111111111110100101111111111111111001110011110101111010101;
          19:
            level_vec_out = 64'b0111111111111111110100101111111111111111001110011110101111010101;
          20:
            level_vec_out = 64'b0111111111111111110101101111111111111111001110011110101111010101;
          21:
            level_vec_out = 64'b0111111111111111110101111111111111111111001110011110101111010101;
          22:
            level_vec_out = 64'b0111111111111111110101111111111111111111011111011110101111010101;
          23:
            level_vec_out = 64'b0111111111111111110101111111111111111111011111111110101111010111;
          24:
            level_vec_out = 64'b0111111111111111111101111111111111111111011111111110101111010111;
          25:
            level_vec_out = 64'b0111111111111111111101111111111111111111011111111110101111010111;
          26:
            level_vec_out = 64'b0111111111111111111101111111111111111111011111111110101111110111;
          27:
            level_vec_out = 64'b0111111111111111111101111111111111111111011111111110101111110111;
          28:
            level_vec_out = 64'b0111111111111111111111111111111111111111011111111111101111110111;
          29:
            level_vec_out = 64'b0111111111111111111111111111111111111111011111111111111111110111;
          30:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        endcase
      7:
        case (frame_id)
          0:
            level_vec_out = 64'b0011011010111100110101101010010100100010110100001000011110111000;
          1:
            level_vec_out = 64'b0111011010111100110101101010010100100010110110001000011110111000;
          2:
            level_vec_out = 64'b0111011010111100110101111011010100100010110110001000011110111000;
          3:
            level_vec_out = 64'b0111011010111100110101111011010110100010110110001000011110111000;
          4:
            level_vec_out = 64'b0111011010111100110101111111010110100010110110001000011110111000;
          5:
            level_vec_out = 64'b0111011010111100110101111111010110100010110110001000011110111000;
          6:
            level_vec_out = 64'b0111011010111100110101111111010110100010110110001000011110111000;
          7:
            level_vec_out = 64'b0111011010111100110101111111010110100010110110001000011110111000;
          8:
            level_vec_out = 64'b0111011010111110111101111111110110110010110110001000011110111000;
          9:
            level_vec_out = 64'b0111011010111110111101111111110110110010110110001000011110111000;
          10:
            level_vec_out = 64'b0111011010111110111101111111110110110010110110001100011110111000;
          11:
            level_vec_out = 64'b0111011011111110111101111111110110110010110110001100111110111000;
          12:
            level_vec_out = 64'b0111011011111110111101111111110110110010110110001100111110111000;
          13:
            level_vec_out = 64'b0111011011111110111101111111110110111010110110001100111110111100;
          14:
            level_vec_out = 64'b0111011111111110111101111111110110111010110110001100111110111100;
          15:
            level_vec_out = 64'b0111011111111110111101111111110110111010110110001100111110111101;
          16:
            level_vec_out = 64'b0111011111111110111101111111111111111010110110001100111110111101;
          17:
            level_vec_out = 64'b0111011111111110111101111111111111111010110110001100111111111101;
          18:
            level_vec_out = 64'b0111011111111110111101111111111111111010110110101101111111111101;
          19:
            level_vec_out = 64'b0111011111111110111101111111111111111010110110101111111111111101;
          20:
            level_vec_out = 64'b0111011111111110111101111111111111111010110110101111111111111101;
          21:
            level_vec_out = 64'b0111011111111110111101111111111111111010110110101111111111111101;
          22:
            level_vec_out = 64'b0111011111111110111101111111111111111010110110101111111111111101;
          23:
            level_vec_out = 64'b0111011111111110111101111111111111111010110110101111111111111101;
          24:
            level_vec_out = 64'b0111011111111110111101111111111111111010110110101111111111111101;
          25:
            level_vec_out = 64'b0111011111111111111101111111111111111010110110101111111111111101;
          26:
            level_vec_out = 64'b0111111111111111111101111111111111111011111110101111111111111101;
          27:
            level_vec_out = 64'b0111111111111111111101111111111111111011111110101111111111111101;
          28:
            level_vec_out = 64'b0111111111111111111101111111111111111011111110101111111111111101;
          29:
            level_vec_out = 64'b0111111111111111111101111111111111111011111111101111111111111111;
          30:
            level_vec_out = 64'b0111111111111111111101111111111111111111111111101111111111111111;
          31:
            level_vec_out = 64'b0111111111111111111111111111111111111111111111111111111111111111;
        endcase
    endcase
  end
endmodule