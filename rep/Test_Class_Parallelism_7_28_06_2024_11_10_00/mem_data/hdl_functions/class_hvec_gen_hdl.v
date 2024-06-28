
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
                    0: class_vec_out = 64'b0110100000001111000111100101100011010100111111110110100110110011;
                    1: class_vec_out = 64'b0110100000011110000110100101100011110100111111110110110110110011;
                    2: class_vec_out = 64'b0110100100011111000111100101100011010100101111110111110110110011;
                endcase
            end
            1: begin
                case (frame_index)
                    0: class_vec_out = 64'b1011000101010111100001111011110011011010011011111010010000010000;
                    1: class_vec_out = 64'b1011000101110111100001111011110010011010011001111010011000110010;
                    2: class_vec_out = 64'b1010100101110111100001011011110010011010011001111010011000011000;
                endcase
            end
            2: begin
                case (frame_index)
                    0: class_vec_out = 64'b1011000101110000010110100010011110111001011001000010100000100101;
                    1: class_vec_out = 64'b1011100100110000010110100010011110111001011001000010100000100101;
                    2: class_vec_out = 64'b0011000100110000010111100010011110111001011001000010101000100101;
                endcase
            end
            3: begin
                case (frame_index)
                    0: class_vec_out = 64'b1010101111011111011010110100100001010110011010000100100000101110;
                    1: class_vec_out = 64'b1010101101011111011000111100100101010110010011000100100010101110;
                    2: class_vec_out = 64'b1010101011011111011010110110100001010110010010000100100001101110;
                endcase
            end
            4: begin
                case (frame_index)
                    0: class_vec_out = 64'b1101111010101011110100000000011011000110111110001100100000101011;
                    1: class_vec_out = 64'b1101111000101011110100000000011011100110111110101100100000101110;
                    2: class_vec_out = 64'b1101111010101011110110000000011111000110111110001100100000101001;
                endcase
            end
            5: begin
                case (frame_index)
                    0: class_vec_out = 64'b1110101011010000110011101001101110101001100110001011011011001010;
                    1: class_vec_out = 64'b1110101011110010110011101001101110111001100110001011011011001111;
                    2: class_vec_out = 64'b1110101111010010110011101001101110101001100110000011011011001011;
                endcase
            end
            6: begin
                case (frame_index)
                    0: class_vec_out = 64'b0011100111000110100010001110001110110011011110100000111111111100;
                    1: class_vec_out = 64'b0011100111000110100011000110001010110011011110100000111111011100;
                    2: class_vec_out = 64'b0011100111000100100010001110001111110011011110100000111111011100;
                endcase
            end
            7: begin
                case (frame_index)
                    0: class_vec_out = 64'b0111010010101101010101010101011011101110010101101010111101111000;
                    1: class_vec_out = 64'b0110010010110101010001000101011011101010000001001010111101111000;
                    2: class_vec_out = 64'b0111010011101101010001010111011011111110010001001010111001111000;
                endcase
            end
        endcase
    end
endmodule