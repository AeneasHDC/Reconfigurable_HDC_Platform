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

module level_vec_gen (
    output reg [63:0] level_vec_out,
    input [2:0] frame_index,
    input [4:0] frame_id
);
    always @(*) begin
        // Update this function to match your requirements
        case (frame_index)
            0: begin
                case (frame_id)
                    0: level_vec_out = 64'b1100111110100110001101001001101011111110001110010011011001100000;
                    1: level_vec_out = 64'b1100111110100110001101001001101011111110001111010011011101100000;
                    2: level_vec_out = 64'b1100111110100110011101001001101011111110101111010011011101100000;
                    3: level_vec_out = 64'b1100111110100110011101001001101011111110101111010011011101100000;
                    4: level_vec_out = 64'b1100111110100110011101001001101011111110101111010111011101100000;
                    5: level_vec_out = 64'b1100111110100110011101001001101011111110101111010111011101100000;
                    6: level_vec_out = 64'b1100111110100110011101001001101011111110101111010111011101100000;
                    7: level_vec_out = 64'b1100111111100110011101001001101011111110101111010111011101100000;
                    8: level_vec_out = 64'b1100111111100110011101001001101111111110101111010111011101100000;
                    9: level_vec_out = 64'b1100111111100110011101001001101111111110101111010111011101100000;
                    10: level_vec_out = 64'b1101111111110110011101001001101111111110101111010111011101100000;
                    11: level_vec_out = 64'b1101111111110110011101001001101111111110101111010111011101100000;
                    12: level_vec_out = 64'b1101111111110110011101001001101111111110101111010111111101100000;
                    13: level_vec_out = 64'b1101111111110110011101001001101111111110101111010111111101100000;
                    14: level_vec_out = 64'b1101111111110110111101001001101111111110111111010111111101100000;
                    15: level_vec_out = 64'b1101111111110110111101001001101111111110111111010111111101100000;
                    16: level_vec_out = 64'b1101111111110110111101001001101111111110111111010111111101110000;
                    17: level_vec_out = 64'b1101111111110110111101001001101111111110111111010111111101111000;
                    18: level_vec_out = 64'b1101111111110110111101001001101111111110111111110111111101111000;
                    19: level_vec_out = 64'b1101111111110110111101001001101111111110111111110111111101111000;
                    20: level_vec_out = 64'b1101111111110110111101001001101111111111111111110111111101111001;
                    21: level_vec_out = 64'b1101111111110110111101001001101111111111111111110111111101111011;
                    22: level_vec_out = 64'b1101111111110110111101001001101111111111111111110111111101111011;
                    23: level_vec_out = 64'b1101111111110110111101001001101111111111111111110111111101111011;
                    24: level_vec_out = 64'b1101111111110110111101001001101111111111111111110111111101111011;
                    25: level_vec_out = 64'b1101111111110110111101001001101111111111111111110111111111111011;
                    26: level_vec_out = 64'b1101111111110110111101001001101111111111111111110111111111111111;
                    27: level_vec_out = 64'b1101111111110110111101001001111111111111111111110111111111111111;
                    28: level_vec_out = 64'b1101111111110110111101001001111111111111111111110111111111111111;
                    29: level_vec_out = 64'b1101111111111110111101101011111111111111111111110111111111111111;
                    30: level_vec_out = 64'b1101111111111110111101111111111111111111111111110111111111111111;
                    31: level_vec_out = 64'b1111111111111111111101111111111111111111111111111111111111111111;
                endcase
            end
            1: begin
                case (frame_id)
                    0: level_vec_out = 64'b0100000101100111011001010111101111001001001111010010011100100110;
                    1: level_vec_out = 64'b0100000101100111011001010111101111001001001111010010011100100110;
                    2: level_vec_out = 64'b0100001111100111011001010111101111001001001111010011011100100110;
                    3: level_vec_out = 64'b0100001111100111011001010111111111001001001111010011011100100110;
                    4: level_vec_out = 64'b0100001111100111011001011111111111001001001111010011011100100110;
                    5: level_vec_out = 64'b0100001111100111011001011111111111011001001111010011011100100110;
                    6: level_vec_out = 64'b0100001111100111011001011111111111011001001111010011011100100110;
                    7: level_vec_out = 64'b0100001111100111011001011111111111011001001111010011011100100110;
                    8: level_vec_out = 64'b0100001111100111011011011111111111011001001111010011011100100110;
                    9: level_vec_out = 64'b0100001111100111011011011111111111011001001111010011011100100110;
                    10: level_vec_out = 64'b0100001111100111011011011111111111011001001111010011111100100110;
                    11: level_vec_out = 64'b0100001111100111011011011111111111011001001111010011111100100110;
                    12: level_vec_out = 64'b0100001111100111011111011111111111011001001111110011111101100110;
                    13: level_vec_out = 64'b0100001111100111011111011111111111011001001111110011111101100110;
                    14: level_vec_out = 64'b0100001111100111011111011111111111011001001111110011111101100110;
                    15: level_vec_out = 64'b0110001111100111011111011111111111011001001111110011111101100110;
                    16: level_vec_out = 64'b0110001111100111011111011111111111011001001111110011111101100110;
                    17: level_vec_out = 64'b0111101111100111011111011111111111011001001111110011111101101110;
                    18: level_vec_out = 64'b0111101111100111111111011111111111011001001111110011111101101110;
                    19: level_vec_out = 64'b0111101111100111111111011111111111011001001111110011111101101110;
                    20: level_vec_out = 64'b0111101111100111111111011111111111011001001111111011111101101110;
                    21: level_vec_out = 64'b0111101111110111111111011111111111011001011111111011111101101110;
                    22: level_vec_out = 64'b0111101111111111111111011111111111011001011111111011111101101110;
                    23: level_vec_out = 64'b0111101111111111111111111111111111111001011111111011111101101111;
                    24: level_vec_out = 64'b0111101111111111111111111111111111111001111111111011111101101111;
                    25: level_vec_out = 64'b0111101111111111111111111111111111111101111111111011111101101111;
                    26: level_vec_out = 64'b0111101111111111111111111111111111111101111111111111111101101111;
                    27: level_vec_out = 64'b0111101111111111111111111111111111111111111111111111111101101111;
                    28: level_vec_out = 64'b0111101111111111111111111111111111111111111111111111111101111111;
                    29: level_vec_out = 64'b0111111111111111111111111111111111111111111111111111111111111111;
                    30: level_vec_out = 64'b0111111111111111111111111111111111111111111111111111111111111111;
                    31: level_vec_out = 64'b0111111111111111111111111111111111111111111111111111111111111111;
                endcase
            end
            2: begin
                case (frame_id)
                    0: level_vec_out = 64'b0110001011000101101011110000001100110001110111000000010001001011;
                    1: level_vec_out = 64'b0110001011000101101011110000001100110001110111000000010001001011;
                    2: level_vec_out = 64'b0110001011000101101011110000001100110001110111000000010001001011;
                    3: level_vec_out = 64'b0110001011010101101011110000001100110001110111000000010001001011;
                    4: level_vec_out = 64'b0110001011010101101011110000001100110001110111000000010001011011;
                    5: level_vec_out = 64'b0111001111010101101011110000001100110001110111000000010001011011;
                    6: level_vec_out = 64'b0111001111010101101011110100001100110001111111000010010001011011;
                    7: level_vec_out = 64'b0111011111010101101011110100001100110001111111000010010001011011;
                    8: level_vec_out = 64'b0111111111010101101011110100001100110001111111000010010001011011;
                    9: level_vec_out = 64'b0111111111110111101011110100001100110101111111000010010001011011;
                    10: level_vec_out = 64'b0111111111110111101011110100001100110101111111000010010001011011;
                    11: level_vec_out = 64'b0111111111110111101011110110001100110101111111000010010001011011;
                    12: level_vec_out = 64'b0111111111110111101011110110001100110101111111000010010001011011;
                    13: level_vec_out = 64'b0111111111110111101011110110011100110101111111000010010001011011;
                    14: level_vec_out = 64'b0111111111110111101011110110011100110101111111000010010001011111;
                    15: level_vec_out = 64'b1111111111110111101011110110011100110101111111000010010001011111;
                    16: level_vec_out = 64'b1111111111110111101011110110011101110101111111000010011001011111;
                    17: level_vec_out = 64'b1111111111110111101011110110011101110101111111000010011001011111;
                    18: level_vec_out = 64'b1111111111110111101011110110011101110111111111000010011001011111;
                    19: level_vec_out = 64'b1111111111110111101011110110011111110111111111000010011001011111;
                    20: level_vec_out = 64'b1111111111110111101011110110011111110111111111010110011001011111;
                    21: level_vec_out = 64'b1111111111110111101011110110011111111111111111010110011001011111;
                    22: level_vec_out = 64'b1111111111111111101011110110011111111111111111010110011001011111;
                    23: level_vec_out = 64'b1111111111111111101011110110011111111111111111010110011001111111;
                    24: level_vec_out = 64'b1111111111111111101011110110011111111111111111010110111011111111;
                    25: level_vec_out = 64'b1111111111111111101011110111011111111111111111011110111011111111;
                    26: level_vec_out = 64'b1111111111111111101011110111011111111111111111011110111011111111;
                    27: level_vec_out = 64'b1111111111111111111011110111011111111111111111011110111011111111;
                    28: level_vec_out = 64'b1111111111111111111011110111011111111111111111111110111011111111;
                    29: level_vec_out = 64'b1111111111111111111011110111011111111111111111111110111011111111;
                    30: level_vec_out = 64'b1111111111111111111011110111111111111111111111111110111111111111;
                    31: level_vec_out = 64'b1111111111111111111111110111111111111111111111111110111111111111;
                endcase
            end
            3: begin
                case (frame_id)
                    0: level_vec_out = 64'b1011100100111111011000011011101101010110010000111101100000101101;
                    1: level_vec_out = 64'b1011100100111111011000011011101101010110010000111101100000101101;
                    2: level_vec_out = 64'b1011100100111111011000011011101101010110010000111101100000101101;
                    3: level_vec_out = 64'b1011100100111111011000011011101101010110010000111101100001101101;
                    4: level_vec_out = 64'b1011100100111111011100011011101101010110010000111101100001101101;
                    5: level_vec_out = 64'b1011100100111111011100011011101101010110010000111101100001101101;
                    6: level_vec_out = 64'b1011100101111111011100011011101101010110010000111101100001101101;
                    7: level_vec_out = 64'b1011100101111111011110011011101101010110010000111101100001101101;
                    8: level_vec_out = 64'b1011100101111111011110011011101101010110110000111101100001101111;
                    9: level_vec_out = 64'b1011100101111111011110011011101101110110110000111101100001101111;
                    10: level_vec_out = 64'b1011100101111111011110011011101101110110110000111101100001101111;
                    11: level_vec_out = 64'b1011110101111111011110011011101111110110110000111101100001101111;
                    12: level_vec_out = 64'b1011110101111111011110011011101111111110110000111101100001101111;
                    13: level_vec_out = 64'b1011110101111111011110011011101111111110110000111101100001111111;
                    14: level_vec_out = 64'b1011110101111111011110011011101111111110110000111101100001111111;
                    15: level_vec_out = 64'b1011110101111111011110011011101111111110110010111111100001111111;
                    16: level_vec_out = 64'b1011110101111111011110011011101111111110110010111111100001111111;
                    17: level_vec_out = 64'b1011110101111111111110011011101111111110111011111111100001111111;
                    18: level_vec_out = 64'b1011110101111111111110011011101111111110111011111111100011111111;
                    19: level_vec_out = 64'b1011110101111111111110011011101111111110111011111111100011111111;
                    20: level_vec_out = 64'b1111110111111111111110011011101111111110111011111111100011111111;
                    21: level_vec_out = 64'b1111110111111111111110011011101111111110111011111111100011111111;
                    22: level_vec_out = 64'b1111111111111111111110011011111111111110111011111111100011111111;
                    23: level_vec_out = 64'b1111111111111111111110011011111111111110111111111111100011111111;
                    24: level_vec_out = 64'b1111111111111111111110011011111111111110111111111111101011111111;
                    25: level_vec_out = 64'b1111111111111111111111011011111111111110111111111111101111111111;
                    26: level_vec_out = 64'b1111111111111111111111011111111111111110111111111111101111111111;
                    27: level_vec_out = 64'b1111111111111111111111011111111111111110111111111111101111111111;
                    28: level_vec_out = 64'b1111111111111111111111011111111111111110111111111111101111111111;
                    29: level_vec_out = 64'b1111111111111111111111111111111111111110111111111111101111111111;
                    30: level_vec_out = 64'b1111111111111111111111111111111111111110111111111111101111111111;
                    31: level_vec_out = 64'b1111111111111111111111111111111111111110111111111111101111111111;
                endcase
            end
            4: begin
                case (frame_id)
                    0: level_vec_out = 64'b1111110010101001001011010010110100101110110110110010010001000011;
                    1: level_vec_out = 64'b1111110010101001001011010010110100101110110110111010010001000011;
                    2: level_vec_out = 64'b1111110010101001001011010010110100101110110110111010010001000011;
                    3: level_vec_out = 64'b1111110010101001001011010010110100101110110110111010010001000011;
                    4: level_vec_out = 64'b1111110010101001001011010010110100101110110110111010010001000011;
                    5: level_vec_out = 64'b1111110010101011001011010010110100101110111110111010010001000011;
                    6: level_vec_out = 64'b1111110010101011001011010010110100101111111110111010010001000011;
                    7: level_vec_out = 64'b1111110010101011001011010010110100101111111110111010011001000011;
                    8: level_vec_out = 64'b1111110010111011001011010010110100101111111110111010011001000011;
                    9: level_vec_out = 64'b1111110010111011001011010010110100101111111110111010011001000011;
                    10: level_vec_out = 64'b1111110010111011001011010010111100101111111110111010011001000011;
                    11: level_vec_out = 64'b1111110010111011001011010010111100101111111110111010011001000111;
                    12: level_vec_out = 64'b1111110010111011001011010010111100101111111110111010011001000111;
                    13: level_vec_out = 64'b1111111010111111001011010010111100101111111110111010011001000111;
                    14: level_vec_out = 64'b1111111010111111001011010010111100111111111111111010011001000111;
                    15: level_vec_out = 64'b1111111010111111001011010010111100111111111111111010011001001111;
                    16: level_vec_out = 64'b1111111010111111001011010011111100111111111111111110011001001111;
                    17: level_vec_out = 64'b1111111010111111001011010011111100111111111111111110011011001111;
                    18: level_vec_out = 64'b1111111010111111001011010011111100111111111111111111011011001111;
                    19: level_vec_out = 64'b1111111010111111101111010011111110111111111111111111011011001111;
                    20: level_vec_out = 64'b1111111010111111101111010011111110111111111111111111011011001111;
                    21: level_vec_out = 64'b1111111010111111101111111011111110111111111111111111011011001111;
                    22: level_vec_out = 64'b1111111010111111101111111011111110111111111111111111011011001111;
                    23: level_vec_out = 64'b1111111010111111101111111011111110111111111111111111011111001111;
                    24: level_vec_out = 64'b1111111010111111101111111011111110111111111111111111011111101111;
                    25: level_vec_out = 64'b1111111010111111101111111011111110111111111111111111011111111111;
                    26: level_vec_out = 64'b1111111111111111111111111011111110111111111111111111011111111111;
                    27: level_vec_out = 64'b1111111111111111111111111011111110111111111111111111111111111111;
                    28: level_vec_out = 64'b1111111111111111111111111011111110111111111111111111111111111111;
                    29: level_vec_out = 64'b1111111111111111111111111011111111111111111111111111111111111111;
                    30: level_vec_out = 64'b1111111111111111111111111011111111111111111111111111111111111111;
                    31: level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
                endcase
            end
            5: begin
                case (frame_id)
                    0: level_vec_out = 64'b0001101010100100101001011111101010010011011101111110011110000101;
                    1: level_vec_out = 64'b0001101010100100101001011111101010010111011101111110011110000101;
                    2: level_vec_out = 64'b0001101110100100101001011111101010010111011111111110011110000101;
                    3: level_vec_out = 64'b0001101110100100101001111111101010010111011111111110011110000101;
                    4: level_vec_out = 64'b0001101110100110101011111111101010010111011111111110011110000101;
                    5: level_vec_out = 64'b0001101110100110101011111111101010010111011111111110011110000101;
                    6: level_vec_out = 64'b0001101110100110101011111111101010010111011111111110011110100101;
                    7: level_vec_out = 64'b0001101110100110101011111111101010011111011111111110011110100101;
                    8: level_vec_out = 64'b0001101110101110101011111111101010011111011111111110011110100101;
                    9: level_vec_out = 64'b0001101110101111101011111111101010011111011111111110011110100101;
                    10: level_vec_out = 64'b0001101110101111101011111111101010011111011111111110011110101111;
                    11: level_vec_out = 64'b0001101110101111111011111111101010011111011111111110011110101111;
                    12: level_vec_out = 64'b0001101110101111111011111111101010011111011111111110011111101111;
                    13: level_vec_out = 64'b0011101110101111111011111111101010111111011111111110011111101111;
                    14: level_vec_out = 64'b0011101110101111111011111111101010111111011111111111011111101111;
                    15: level_vec_out = 64'b0111101110101111111011111111101010111111011111111111011111101111;
                    16: level_vec_out = 64'b0111101110101111111011111111101010111111011111111111011111101111;
                    17: level_vec_out = 64'b0111101110101111111011111111101010111111011111111111011111101111;
                    18: level_vec_out = 64'b0111101110111111111011111111101010111111111111111111011111101111;
                    19: level_vec_out = 64'b1111101110111111111011111111101010111111111111111111011111111111;
                    20: level_vec_out = 64'b1111101110111111111111111111101010111111111111111111011111111111;
                    21: level_vec_out = 64'b1111101110111111111111111111101010111111111111111111011111111111;
                    22: level_vec_out = 64'b1111101110111111111111111111101010111111111111111111111111111111;
                    23: level_vec_out = 64'b1111101111111111111111111111101010111111111111111111111111111111;
                    24: level_vec_out = 64'b1111101111111111111111111111101010111111111111111111111111111111;
                    25: level_vec_out = 64'b1111101111111111111111111111101010111111111111111111111111111111;
                    26: level_vec_out = 64'b1111101111111111111111111111101010111111111111111111111111111111;
                    27: level_vec_out = 64'b1111101111111111111111111111101011111111111111111111111111111111;
                    28: level_vec_out = 64'b1111101111111111111111111111111111111111111111111111111111111111;
                    29: level_vec_out = 64'b1111101111111111111111111111111111111111111111111111111111111111;
                    30: level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
                    31: level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111111111111;
                endcase
            end
            6: begin
                case (frame_id)
                    0: level_vec_out = 64'b0001100111010101011010110011001010011000001110110111110001101110;
                    1: level_vec_out = 64'b0001100111010101011010110111001010011000001110110111110001101110;
                    2: level_vec_out = 64'b0001110111010101011010110111001010011000001110110111110001101110;
                    3: level_vec_out = 64'b0001110111010101011010110111001010011010001110110111110001101110;
                    4: level_vec_out = 64'b0001110111010101011010110111001010011010001111110111111001101110;
                    5: level_vec_out = 64'b0001110111110101011010110111001010011010011111110111111001101110;
                    6: level_vec_out = 64'b1001110111110101011010110111001010011010011111110111111001101110;
                    7: level_vec_out = 64'b1001110111110101011010111111101010011010111111110111111001101110;
                    8: level_vec_out = 64'b1001110111110101011010111111101010011010111111110111111001101110;
                    9: level_vec_out = 64'b1001110111110101011010111111101010011010111111110111111101101110;
                    10: level_vec_out = 64'b1001110111110101111010111111101010011010111111110111111101101110;
                    11: level_vec_out = 64'b1001110111110101111010111111101110111010111111110111111101101110;
                    12: level_vec_out = 64'b1101110111110101111010111111101110111010111111110111111101101110;
                    13: level_vec_out = 64'b1101110111110101111010111111101110111010111111110111111101101110;
                    14: level_vec_out = 64'b1101110111110101111010111111101110111010111111110111111101111110;
                    15: level_vec_out = 64'b1101110111110101111010111111101111111010111111110111111101111110;
                    16: level_vec_out = 64'b1101110111110101111010111111101111111010111111110111111101111110;
                    17: level_vec_out = 64'b1101110111110101111010111111101111111010111111110111111101111110;
                    18: level_vec_out = 64'b1101110111110101111110111111101111111010111111110111111101111110;
                    19: level_vec_out = 64'b1101110111110101111110111111101111111010111111110111111101111110;
                    20: level_vec_out = 64'b1101110111110101111110111111101111111010111111110111111101111110;
                    21: level_vec_out = 64'b1101110111110101111111111111101111111011111111110111111101111110;
                    22: level_vec_out = 64'b1101110111110101111111111111101111111011111111110111111111111110;
                    23: level_vec_out = 64'b1101110111110101111111111111101111111011111111110111111111111110;
                    24: level_vec_out = 64'b1101110111110101111111111111101111111011111111111111111111111110;
                    25: level_vec_out = 64'b1101111111110101111111111111101111111011111111111111111111111110;
                    26: level_vec_out = 64'b1101111111110111111111111111101111111011111111111111111111111110;
                    27: level_vec_out = 64'b1101111111111111111111111111101111111011111111111111111111111110;
                    28: level_vec_out = 64'b1111111111111111111111111111101111111011111111111111111111111111;
                    29: level_vec_out = 64'b1111111111111111111111111111101111111011111111111111111111111111;
                    30: level_vec_out = 64'b1111111111111111111111111111111111111011111111111111111111111111;
                    31: level_vec_out = 64'b1111111111111111111111111111111111111011111111111111111111111111;
                endcase
            end
            7: begin
                case (frame_id)
                    0: level_vec_out = 64'b1000100010011001100011110001010111001010000110000001000001110000;
                    1: level_vec_out = 64'b1000100010011001100011110011010111101010000110000101000001110000;
                    2: level_vec_out = 64'b1000100010011001100011110011010111101010000110000101000001110000;
                    3: level_vec_out = 64'b1000100010011001100011110011010111101010100110000101101001110000;
                    4: level_vec_out = 64'b1000100010011001100011110011010111101010100110000101101001110000;
                    5: level_vec_out = 64'b1000100011011001100011110011010111101010100110000101101001110000;
                    6: level_vec_out = 64'b1100100011011001100011110011010111101010100110000101101001110000;
                    7: level_vec_out = 64'b1100100011011001100011110011010111101010100110000101101001110000;
                    8: level_vec_out = 64'b1100100011011001100011110011010111101010100111000101101001110000;
                    9: level_vec_out = 64'b1100101011011001100011110011010111101010100111001101101001110000;
                    10: level_vec_out = 64'b1100101011011001100011110011010111101010101111001101101001110000;
                    11: level_vec_out = 64'b1100101011111001100011110011010111101010101111001101101001110000;
                    12: level_vec_out = 64'b1100111011111001100011110011010111101010101111001101101001110000;
                    13: level_vec_out = 64'b1100111011111001100011110011011111101010101111001111101001110000;
                    14: level_vec_out = 64'b1100111011111001100011111011011111101010101111001111101001110000;
                    15: level_vec_out = 64'b1100111011111001100011111011011111101010111111001111101001110000;
                    16: level_vec_out = 64'b1110111011111001100011111011011111101010111111001111101001111100;
                    17: level_vec_out = 64'b1110111011111001100011111011011111101010111111001111101001111100;
                    18: level_vec_out = 64'b1110111011111001100011111011011111101010111111001111101001111100;
                    19: level_vec_out = 64'b1111111011111001100011111011011111111010111111001111101001111100;
                    20: level_vec_out = 64'b1111111011111001100011111011011111111010111111001111101001111100;
                    21: level_vec_out = 64'b1111111011111001100011111011011111111010111111001111101001111100;
                    22: level_vec_out = 64'b1111111011111001100011111011011111111011111111011111101001111100;
                    23: level_vec_out = 64'b1111111011111001100011111011011111111111111111011111101001111100;
                    24: level_vec_out = 64'b1111111011111001100011111011011111111111111111111111111001111100;
                    25: level_vec_out = 64'b1111111011111001100011111011011111111111111111111111111001111100;
                    26: level_vec_out = 64'b1111111011111101100011111011011111111111111111111111111001111100;
                    27: level_vec_out = 64'b1111111011111101110011111011111111111111111111111111111001111100;
                    28: level_vec_out = 64'b1111111011111101111011111011111111111111111111111111111001111110;
                    29: level_vec_out = 64'b1111111011111101111011111011111111111111111111111111111011111110;
                    30: level_vec_out = 64'b1111111111111101111011111111111111111111111111111111111011111110;
                    31: level_vec_out = 64'b1111111111111111111111111111111111111111111111111111111011111111;
                endcase
            end
        endcase
    end
endmodule