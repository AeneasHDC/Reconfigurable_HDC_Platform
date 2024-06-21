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
            level_vec_out = 64'b0100110001000111011001110111101011000110100010010000100110100101;
          1:
            level_vec_out = 64'b0100110001000111011001110111101011000110110010010000100110100101;
          2:
            level_vec_out = 64'b0100110001000111011001111111101011000110110010010000100110100101;
          3:
            level_vec_out = 64'b0100111001000111011011111111101011000110110010010000110110100101;
          4:
            level_vec_out = 64'b0100111001000111011011111111101011000110110010110000110110100101;
          5:
            level_vec_out = 64'b0100111001100111011011111111101011000110110010110100110110100101;
          6:
            level_vec_out = 64'b0100111001100111011011111111101011000110110011110110110110100101;
          7:
            level_vec_out = 64'b0100111001100111011011111111101011000110110011110110110110100101;
          8:
            level_vec_out = 64'b0101111001100111011011111111101011000110110011110110110110100101;
          9:
            level_vec_out = 64'b0101111001100111011011111111101011000110110011110110110110100101;
          10:
            level_vec_out = 64'b1101111011100111011011111111101011000110110011110110110110100101;
          11:
            level_vec_out = 64'b1101111011101111011111111111101011000110110011110110110110101101;
          12:
            level_vec_out = 64'b1101111011101111011111111111101011000110110011110110110110101101;
          13:
            level_vec_out = 64'b1101111011111111011111111111101011000110110011110110111110101101;
          14:
            level_vec_out = 64'b1101111011111111011111111111101111000110110011110110111110101101;
          15:
            level_vec_out = 64'b1101111011111111011111111111101111000110111011110110111110101101;
          16:
            level_vec_out = 64'b1101111011111111011111111111101111000110111011110110111110101101;
          17:
            level_vec_out = 64'b1101111011111111011111111111101111000110111011110110111110101101;
          18:
            level_vec_out = 64'b1101111011111111011111111111101111000110111011110111111110101101;
          19:
            level_vec_out = 64'b1101111011111111011111111111101111000110111011110111111110101101;
          20:
            level_vec_out = 64'b1101111011111111011111111111101111000111111011110111111110101101;
          21:
            level_vec_out = 64'b1101111011111111011111111111111111000111111011110111111110101101;
          22:
            level_vec_out = 64'b1101111011111111011111111111111111000111111011110111111110101101;
          23:
            level_vec_out = 64'b1101111011111111011111111111111111000111111011110111111110101101;
          24:
            level_vec_out = 64'b1101111011111111011111111111111111110111111011110111111110111101;
          25:
            level_vec_out = 64'b1101111011111111011111111111111111110111111011110111111110111101;
          26:
            level_vec_out = 64'b1111111011111111111111111111111111110111111011110111111111111101;
          27:
            level_vec_out = 64'b1111111011111111111111111111111111110111111111110111111111111111;
          28:
            level_vec_out = 64'b1111111011111111111111111111111111110111111111110111111111111111;
          29:
            level_vec_out = 64'b1111111011111111111111111111111111110111111111110111111111111111;
          30:
            level_vec_out = 64'b1111111111111111111111111111111111110111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111111110111111111111111111111111111;
        endcase
      1:
        case (frame_id)
          0:
            level_vec_out = 64'b1101000100101100101000010011100100100101101000111010100101001000;
          1:
            level_vec_out = 64'b1101000100101100101000010011100100100101101000111010100101001000;
          2:
            level_vec_out = 64'b1111000100101100101000010011100100100101101000111010100101001000;
          3:
            level_vec_out = 64'b1111000100101100101000010011100100100101101000111010100101001000;
          4:
            level_vec_out = 64'b1111000100101100101000010011100100100101101000111010100101001000;
          5:
            level_vec_out = 64'b1111000110101100101000011011100100100101101000111010100101001000;
          6:
            level_vec_out = 64'b1111100110101100101000011011100100100101101001111010100101001000;
          7:
            level_vec_out = 64'b1111100110101100101000011011100100100101101011111010100101001000;
          8:
            level_vec_out = 64'b1111100110101100101000011011100100100101101011111010100101001000;
          9:
            level_vec_out = 64'b1111100110101100101000011011100100100101101111111010100101001000;
          10:
            level_vec_out = 64'b1111100110101100101100011011100100100101101111111010100101001000;
          11:
            level_vec_out = 64'b1111100110101100101100011011100100100101101111111010100101001000;
          12:
            level_vec_out = 64'b1111100110101110101100011011100100100101111111111010100101001000;
          13:
            level_vec_out = 64'b1111100110101110101100011011100100100101111111111010100101001000;
          14:
            level_vec_out = 64'b1111100111101110101100111011100100100101111111111010100101001000;
          15:
            level_vec_out = 64'b1111100111101110101101111011110100100101111111111010100101001000;
          16:
            level_vec_out = 64'b1111100111101110101101111011110100100101111111111010100101001000;
          17:
            level_vec_out = 64'b1111100111101110101101111011110100100101111111111010100101001000;
          18:
            level_vec_out = 64'b1111100111101111101101111011110100100111111111111110100111001000;
          19:
            level_vec_out = 64'b1111100111101111101101111011110100100111111111111110101111001000;
          20:
            level_vec_out = 64'b1111100111101111101101111011110100100111111111111110101111001100;
          21:
            level_vec_out = 64'b1111100111101111101101111011110110100111111111111110101111001100;
          22:
            level_vec_out = 64'b1111110111101111101101111011111110100111111111111110101111001100;
          23:
            level_vec_out = 64'b1111110111101111101101111011111111100111111111111110101111001100;
          24:
            level_vec_out = 64'b1111110111101111101101111011111111100111111111111110101111001100;
          25:
            level_vec_out = 64'b1111111111101111101101111011111111110111111111111110101111011100;
          26:
            level_vec_out = 64'b1111111111101111101101111011111111110111111111111110101111011100;
          27:
            level_vec_out = 64'b1111111111101111101101111011111111110111111111111111101111011100;
          28:
            level_vec_out = 64'b1111111111111111101101111011111111110111111111111111101111111110;
          29:
            level_vec_out = 64'b1111111111111111101111111011111111111111111111111111101111111110;
          30:
            level_vec_out = 64'b1111111111111111101111111111111111111111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111101111111111111111111111111111111111111111111111;
        endcase
      2:
        case (frame_id)
          0:
            level_vec_out = 64'b1001011000101111001100110111010000001101010000000001000110001101;
          1:
            level_vec_out = 64'b1001011000101111001100110111010000001101010100000001000110001101;
          2:
            level_vec_out = 64'b1001011000101111001110110111011000001101010100000001000110001101;
          3:
            level_vec_out = 64'b1001011000101111001110110111011000001101010100000001000110001111;
          4:
            level_vec_out = 64'b1001011000101111001110110111011000001101010100000001000110001111;
          5:
            level_vec_out = 64'b1001011100101111001110110111011001001101010100000001000110001111;
          6:
            level_vec_out = 64'b1001011100101111001110110111011001001101010100000001000110001111;
          7:
            level_vec_out = 64'b1001011100101111001110111111011001001101010100000001000110001111;
          8:
            level_vec_out = 64'b1001011100101111101110111111011011001101010100000001000110001111;
          9:
            level_vec_out = 64'b1001011100101111101110111111011011001101010100000001000110001111;
          10:
            level_vec_out = 64'b1001011100111111101110111111011011001101010100000001000110001111;
          11:
            level_vec_out = 64'b1001011110111111101110111111011111001101010100000001000110001111;
          12:
            level_vec_out = 64'b1001011110111111111110111111011111001101010100000001000111001111;
          13:
            level_vec_out = 64'b1001011110111111111111111111011111001101010100000011000111001111;
          14:
            level_vec_out = 64'b1001111110111111111111111111011111001111010100000011010111001111;
          15:
            level_vec_out = 64'b1001111110111111111111111111011111001111010100000011010111001111;
          16:
            level_vec_out = 64'b1001111110111111111111111111011111001111010110000011010111001111;
          17:
            level_vec_out = 64'b1001111110111111111111111111011111001111010110000011010111101111;
          18:
            level_vec_out = 64'b1001111110111111111111111111011111001111010111000011010111101111;
          19:
            level_vec_out = 64'b1001111110111111111111111111011111001111010111000011010111101111;
          20:
            level_vec_out = 64'b1001111110111111111111111111011111101111010111001011010111111111;
          21:
            level_vec_out = 64'b1001111110111111111111111111011111101111010111001011010111111111;
          22:
            level_vec_out = 64'b1011111110111111111111111111011111101111110111001011010111111111;
          23:
            level_vec_out = 64'b1011111110111111111111111111011111101111110111001011011111111111;
          24:
            level_vec_out = 64'b1011111110111111111111111111011111101111111111001011011111111111;
          25:
            level_vec_out = 64'b1011111110111111111111111111011111111111111111001111011111111111;
          26:
            level_vec_out = 64'b1011111110111111111111111111011111111111111111001111011111111111;
          27:
            level_vec_out = 64'b1011111110111111111111111111011111111111111111001111011111111111;
          28:
            level_vec_out = 64'b1111111110111111111111111111011111111111111111001111011111111111;
          29:
            level_vec_out = 64'b1111111110111111111111111111011111111111111111111111011111111111;
          30:
            level_vec_out = 64'b1111111110111111111111111111011111111111111111111111011111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111011111111111111111111111011111111111;
        endcase
      3:
        case (frame_id)
          0:
            level_vec_out = 64'b0100110001001010000000000101100111011010010011000110010100001111;
          1:
            level_vec_out = 64'b0100110001001010000000000101100111011010010111000110010100001111;
          2:
            level_vec_out = 64'b0100110001011010000000000101100111011010010111000110010100001111;
          3:
            level_vec_out = 64'b0100110001011010000000000101100111011010010111000110010110001111;
          4:
            level_vec_out = 64'b0100110001011010000000000101100111011010010111000110010110001111;
          5:
            level_vec_out = 64'b0100110001011010000000000101100111011010010111010110010110001111;
          6:
            level_vec_out = 64'b0100110101011010000000000101100111011010010111010110010110001111;
          7:
            level_vec_out = 64'b0100110101011110000000000101100111011010011111010110010110001111;
          8:
            level_vec_out = 64'b0100110101011110000100000101100111011011011111010110010110001111;
          9:
            level_vec_out = 64'b0100110101011110000101000101100111011011011111010110010110011111;
          10:
            level_vec_out = 64'b0100110101011110000101000101100111011011011111010110110110011111;
          11:
            level_vec_out = 64'b0100110111011110000101000101100111011011011111010110110110011111;
          12:
            level_vec_out = 64'b0100110111111110000101000101100111011011011111010110110110011111;
          13:
            level_vec_out = 64'b0100110111111110000101000101100111011011011111011110110110011111;
          14:
            level_vec_out = 64'b0100110111111110000101000101100111011011011111011110110110011111;
          15:
            level_vec_out = 64'b0100110111111110010101000101100111111011011111011110110110011111;
          16:
            level_vec_out = 64'b0100110111111110010101000101100111111011011111111110110110011111;
          17:
            level_vec_out = 64'b1100110111111110010101100101100111111011011111111110110111011111;
          18:
            level_vec_out = 64'b1100110111111110010101110101100111111011011111111110110111011111;
          19:
            level_vec_out = 64'b1100110111111110010111110101100111111011111111111111110111011111;
          20:
            level_vec_out = 64'b1100111111111110010111110101100111111011111111111111110111011111;
          21:
            level_vec_out = 64'b1110111111111110010111110101100111111011111111111111110111011111;
          22:
            level_vec_out = 64'b1110111111111110010111110101110111111011111111111111110111011111;
          23:
            level_vec_out = 64'b1110111111111110010111110101110111111011111111111111110111111111;
          24:
            level_vec_out = 64'b1110111111111111010111110101110111111011111111111111110111111111;
          25:
            level_vec_out = 64'b1110111111111111110111110101110111111011111111111111110111111111;
          26:
            level_vec_out = 64'b1110111111111111110111110111110111111111111111111111110111111111;
          27:
            level_vec_out = 64'b1111111111111111110111111111110111111111111111111111111111111111;
          28:
            level_vec_out = 64'b1111111111111111110111111111110111111111111111111111111111111111;
          29:
            level_vec_out = 64'b1111111111111111111111111111110111111111111111111111111111111111;
          30:
            level_vec_out = 64'b1111111111111111111111111111110111111111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        endcase
      4:
        case (frame_id)
          0:
            level_vec_out = 64'b1110011000111001011110111000000011110001110101000101010011010101;
          1:
            level_vec_out = 64'b1110011000111001011110111000000011110001110101000101010111010101;
          2:
            level_vec_out = 64'b1110011000111001011110111000000011110001110101000101010111010101;
          3:
            level_vec_out = 64'b1110011010111001011110111000000011110001110101000101010111010101;
          4:
            level_vec_out = 64'b1110011010111101011110111000000011110001110101000101010111011101;
          5:
            level_vec_out = 64'b1110011010111101011110111000000011110001110101000101010111011101;
          6:
            level_vec_out = 64'b1110011010111101011110111000000011110001110101000101010111011101;
          7:
            level_vec_out = 64'b1110011010111101011110111000000011110001110101000101010111011111;
          8:
            level_vec_out = 64'b1111111010111101011110111010000011110001110101000101010111011111;
          9:
            level_vec_out = 64'b1111111010111101111110111010000011110001110101000101010111111111;
          10:
            level_vec_out = 64'b1111111010111101111110111010000011110001110101000101010111111111;
          11:
            level_vec_out = 64'b1111111010111101111110111011000011110001110101000101010111111111;
          12:
            level_vec_out = 64'b1111111010111111111110111011000011110001110101000101010111111111;
          13:
            level_vec_out = 64'b1111111010111111111110111011000011110001110101010101010111111111;
          14:
            level_vec_out = 64'b1111111011111111111110111011000011110001110101010101010111111111;
          15:
            level_vec_out = 64'b1111111011111111111110111011000011111001110101010111010111111111;
          16:
            level_vec_out = 64'b1111111011111111111110111011000011111001110101010111010111111111;
          17:
            level_vec_out = 64'b1111111011111111111110111011001011111001110101010111010111111111;
          18:
            level_vec_out = 64'b1111111011111111111111111011001011111001110101010111010111111111;
          19:
            level_vec_out = 64'b1111111011111111111111111011001011111001110101010111010111111111;
          20:
            level_vec_out = 64'b1111111111111111111111111011001011111001110101010111010111111111;
          21:
            level_vec_out = 64'b1111111111111111111111111011011011111011110101010111010111111111;
          22:
            level_vec_out = 64'b1111111111111111111111111011011011111011110111010111010111111111;
          23:
            level_vec_out = 64'b1111111111111111111111111111011011111011110111010111111111111111;
          24:
            level_vec_out = 64'b1111111111111111111111111111011111111011110111010111111111111111;
          25:
            level_vec_out = 64'b1111111111111111111111111111011111111011110111010111111111111111;
          26:
            level_vec_out = 64'b1111111111111111111111111111011111111011110111010111111111111111;
          27:
            level_vec_out = 64'b1111111111111111111111111111011111111011110111010111111111111111;
          28:
            level_vec_out = 64'b1111111111111111111111111111011111111111110111011111111111111111;
          29:
            level_vec_out = 64'b1111111111111111111111111111011111111111110111111111111111111111;
          30:
            level_vec_out = 64'b1111111111111111111111111111011111111111110111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111111111111110111111111111111111111;
        endcase
      5:
        case (frame_id)
          0:
            level_vec_out = 64'b0101110101111000111011011101010011110110111001111101010111010000;
          1:
            level_vec_out = 64'b0101110101111000111011011101010011110110111001111101010111010000;
          2:
            level_vec_out = 64'b0101110101111000111011011101011011110110111001111101010111010000;
          3:
            level_vec_out = 64'b0101110101111000111011011101011011110110111001111111110111010000;
          4:
            level_vec_out = 64'b0101110111111000111011011101011011110110111001111111110111110000;
          5:
            level_vec_out = 64'b0101110111111000111011011101011011110110111001111111110111110000;
          6:
            level_vec_out = 64'b0101110111111000111011011101011011110110111001111111110111110010;
          7:
            level_vec_out = 64'b0101110111111000111011011101011011110110111001111111111111110010;
          8:
            level_vec_out = 64'b0101110111111000111011011101011011110110111001111111111111110010;
          9:
            level_vec_out = 64'b0101110111111000111011011101011011110111111001111111111111110010;
          10:
            level_vec_out = 64'b0101110111111000111011011101011011110111111001111111111111110010;
          11:
            level_vec_out = 64'b0101110111111000111011011101011011110111111001111111111111110010;
          12:
            level_vec_out = 64'b0101110111111000111011011101011011111111111001111111111111110010;
          13:
            level_vec_out = 64'b0101110111111001111011011101011011111111111001111111111111111010;
          14:
            level_vec_out = 64'b0101110111111001111011111101011011111111111001111111111111111010;
          15:
            level_vec_out = 64'b0101110111111001111011111101011011111111111001111111111111111010;
          16:
            level_vec_out = 64'b0101110111111101111011111101011011111111111001111111111111111011;
          17:
            level_vec_out = 64'b0101110111111101111011111101011011111111111101111111111111111111;
          18:
            level_vec_out = 64'b0101110111111101111011111101011011111111111101111111111111111111;
          19:
            level_vec_out = 64'b0101110111111101111011111111011011111111111101111111111111111111;
          20:
            level_vec_out = 64'b0101110111111101111011111111011011111111111111111111111111111111;
          21:
            level_vec_out = 64'b0101110111111101111011111111011011111111111111111111111111111111;
          22:
            level_vec_out = 64'b0101110111111101111011111111011011111111111111111111111111111111;
          23:
            level_vec_out = 64'b0111110111111101111011111111011011111111111111111111111111111111;
          24:
            level_vec_out = 64'b0111110111111101111111111111011011111111111111111111111111111111;
          25:
            level_vec_out = 64'b0111110111111111111111111111011011111111111111111111111111111111;
          26:
            level_vec_out = 64'b1111110111111111111111111111011011111111111111111111111111111111;
          27:
            level_vec_out = 64'b1111110111111111111111111111011011111111111111111111111111111111;
          28:
            level_vec_out = 64'b1111110111111111111111111111111011111111111111111111111111111111;
          29:
            level_vec_out = 64'b1111110111111111111111111111111111111111111111111111111111111111;
          30:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        endcase
      6:
        case (frame_id)
          0:
            level_vec_out = 64'b0111011001100000011011100111110010011100100110101101111000100001;
          1:
            level_vec_out = 64'b0111011001100001011011100111110010111100101111101101111000100001;
          2:
            level_vec_out = 64'b0111011001100001011011100111110010111100101111101111111000100001;
          3:
            level_vec_out = 64'b0111011001100001011011100111110010111100101111101111111000100001;
          4:
            level_vec_out = 64'b0111011001100001011011100111110010111100101111101111111001100001;
          5:
            level_vec_out = 64'b0111011001100001011011100111110010111100101111101111111001110001;
          6:
            level_vec_out = 64'b0111011001100001011011100111110010111100101111101111111001110101;
          7:
            level_vec_out = 64'b0111011001100001011011100111110010111100101111101111111001110101;
          8:
            level_vec_out = 64'b0111011001100001011011100111110010111100101111101111111001110101;
          9:
            level_vec_out = 64'b0111011001100001011011100111110010111100101111101111111011110101;
          10:
            level_vec_out = 64'b0111011001100001011111100111110011111101101111101111111011110101;
          11:
            level_vec_out = 64'b0111011001100001111111100111110011111101101111101111111011110101;
          12:
            level_vec_out = 64'b0111011001100001111111100111111011111101101111101111111011110101;
          13:
            level_vec_out = 64'b0111011001100001111111100111111011111101101111101111111011110101;
          14:
            level_vec_out = 64'b0111011001100001111111100111111011111101101111101111111011110101;
          15:
            level_vec_out = 64'b0111011001100101111111100111111011111101101111101111111011110101;
          16:
            level_vec_out = 64'b0111111011100101111111100111111011111101101111101111111111110101;
          17:
            level_vec_out = 64'b0111111011100101111111101111111011111101101111101111111111110101;
          18:
            level_vec_out = 64'b0111111011100101111111101111111011111101101111101111111111110101;
          19:
            level_vec_out = 64'b0111111011100101111111101111111011111101101111101111111111110101;
          20:
            level_vec_out = 64'b0111111011100101111111101111111011111101101111101111111111110101;
          21:
            level_vec_out = 64'b0111111011100101111111101111111111111111101111101111111111110101;
          22:
            level_vec_out = 64'b0111111011100101111111101111111111111111101111101111111111110101;
          23:
            level_vec_out = 64'b0111111011100101111111101111111111111111111111101111111111110101;
          24:
            level_vec_out = 64'b0111111011100101111111101111111111111111111111101111111111110101;
          25:
            level_vec_out = 64'b0111111111100101111111101111111111111111111111101111111111110101;
          26:
            level_vec_out = 64'b0111111111100101111111101111111111111111111111101111111111110101;
          27:
            level_vec_out = 64'b0111111111110101111111101111111111111111111111101111111111110101;
          28:
            level_vec_out = 64'b0111111111110101111111101111111111111111111111101111111111110101;
          29:
            level_vec_out = 64'b0111111111110101111111101111111111111111111111101111111111110101;
          30:
            level_vec_out = 64'b0111111111110101111111101111111111111111111111101111111111111101;
          31:
            level_vec_out = 64'b1111111111111101111111111111111111111111111111111111111111111111;
        endcase
      7:
        case (frame_id)
          0:
            level_vec_out = 64'b0010011101110101111111111101101000111101011100101110010101011110;
          1:
            level_vec_out = 64'b0010011101110101111111111101101000111101011100101110010101011110;
          2:
            level_vec_out = 64'b0010011101111101111111111101101000111101011100101110010101011110;
          3:
            level_vec_out = 64'b0010011101111101111111111101101000111101011100101110010101011110;
          4:
            level_vec_out = 64'b0010011101111101111111111101101000111111011100101110110101011110;
          5:
            level_vec_out = 64'b0010011101111101111111111101101000111111011100101110110101011110;
          6:
            level_vec_out = 64'b0010011101111101111111111101101000111111111100101110110101011110;
          7:
            level_vec_out = 64'b0010011101111101111111111101101010111111111100111110110101011110;
          8:
            level_vec_out = 64'b0010011101111101111111111101101010111111111100111110110101011110;
          9:
            level_vec_out = 64'b0010011101111101111111111101101010111111111100111110111101011110;
          10:
            level_vec_out = 64'b0010011101111101111111111101101010111111111100111110111101011110;
          11:
            level_vec_out = 64'b0010011101111101111111111101101010111111111100111110111101011110;
          12:
            level_vec_out = 64'b0010011101111101111111111101101010111111111100111110111101011110;
          13:
            level_vec_out = 64'b0010011101111101111111111101101010111111111100111110111101011110;
          14:
            level_vec_out = 64'b0010011101111101111111111101101010111111111100111110111101011110;
          15:
            level_vec_out = 64'b0010011101111101111111111101101010111111111100111110111101011110;
          16:
            level_vec_out = 64'b0011011101111101111111111101101010111111111100111110111101011110;
          17:
            level_vec_out = 64'b0011011101111101111111111101101010111111111100111110111101011110;
          18:
            level_vec_out = 64'b0011011101111101111111111101101010111111111100111110111101011110;
          19:
            level_vec_out = 64'b0011011101111101111111111111101011111111111100111111111101011110;
          20:
            level_vec_out = 64'b0011011101111101111111111111101011111111111100111111111101011110;
          21:
            level_vec_out = 64'b0011011101111111111111111111101011111111111100111111111101011110;
          22:
            level_vec_out = 64'b0011111101111111111111111111101011111111111100111111111111011110;
          23:
            level_vec_out = 64'b0011111101111111111111111111101011111111111100111111111111011110;
          24:
            level_vec_out = 64'b0111111101111111111111111111101011111111111100111111111111011110;
          25:
            level_vec_out = 64'b0111111101111111111111111111101011111111111100111111111111011110;
          26:
            level_vec_out = 64'b0111111101111111111111111111111011111111111100111111111111011111;
          27:
            level_vec_out = 64'b1111111101111111111111111111111011111111111100111111111111011111;
          28:
            level_vec_out = 64'b1111111111111111111111111111111011111111111100111111111111011111;
          29:
            level_vec_out = 64'b1111111111111111111111111111111011111111111100111111111111111111;
          30:
            level_vec_out = 64'b1111111111111111111111111111111011111111111101111111111111111111;
          31:
            level_vec_out = 64'b1111111111111111111111111111111011111111111101111111111111111111;
        endcase
    endcase
  end
endmodule