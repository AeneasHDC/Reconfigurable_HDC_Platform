
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

module class_vec_gen (
    output reg [63:0] class_vec_out,
    input [2:0] frame_id,
    input [1:0] frame_index
);
    always @(*) begin
        // Update this function to match your requirements
        case (frame_id)
            0: begin
                case (frame_index)
                    0: class_vec_out = 64'b1111111111000000101011101111100110010100011111111000001011001111;
                    1: class_vec_out = 64'b0111101111000000101111101010100111110100011111111000001010001101;
                    2: class_vec_out = 64'b1111111111000000101011101111100110010100011111111100101010001111;
                endcase
            end
            1: begin
                case (frame_index)
                    0: class_vec_out = 64'b0100111011010000010001101011101100001110110111010010101000010110;
                    1: class_vec_out = 64'b0100101011010000011001101011101100011110110111010010101000000111;
                    2: class_vec_out = 64'b0100110011000000111001101011101100001110110111010010001000000110;
                endcase
            end
            2: begin
                case (frame_index)
                    0: class_vec_out = 64'b1000100010010010001101000111110010011101011000000010110110101111;
                    1: class_vec_out = 64'b1000100010010010001101001111110010011101011001000010110110101011;
                    2: class_vec_out = 64'b1000000110010010001101001111110010011101001000000010110110101011;
                endcase
            end
            3: begin
                case (frame_index)
                    0: class_vec_out = 64'b0110101110101000101100110111001111111101111100110000111110000010;
                    1: class_vec_out = 64'b0110111110101100101100110111000111111101111101100000111110000000;
                    2: class_vec_out = 64'b0110101110101000101100110111000111111101111100100000111110000010;
                endcase
            end
            4: begin
                case (frame_index)
                    0: class_vec_out = 64'b1100011101111011100010110000101001001101001001010011011110010010;
                    1: class_vec_out = 64'b1100010101111011100010110000101001101101001101000011011110010010;
                    2: class_vec_out = 64'b1100011101111011100010110000101001101101011001000011001010010010;
                endcase
            end
            5: begin
                case (frame_index)
                    0: class_vec_out = 64'b1111110111000011101001101000000110000010101111110011011111000110;
                    1: class_vec_out = 64'b1111110101000001111001011010000110010010111111110011011111000110;
                    2: class_vec_out = 64'b1111110111010001111001111010000110000010101111110011011111100110;
                endcase
            end
            6: begin
                case (frame_index)
                    0: class_vec_out = 64'b1101110101011101010000011111000111010101001000100110011100010011;
                    1: class_vec_out = 64'b1101110111011101010000011110000111011101001000100110011100010011;
                    2: class_vec_out = 64'b1001110101011101011000011111000111010101001000100110011101010011;
                endcase
            end
            7: begin
                case (frame_index)
                    0: class_vec_out = 64'b1100100000111110011011000111000000110110001000110100100101110100;
                    1: class_vec_out = 64'b1100100000011010011010000111000000110110001100110100100101110100;
                    2: class_vec_out = 64'b1100100000011110011010100111000100110110001100110100100101110100;
                endcase
            end
        endcase
    end
endmodule