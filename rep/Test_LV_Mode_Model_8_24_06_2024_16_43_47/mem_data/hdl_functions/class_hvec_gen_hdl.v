
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
                    0: class_vec_out = 64'b0100101101010100000110111100101010111101111011001000001010001111;
                    1: class_vec_out = 64'b0000101100110100000110111101001010101100111011001001001010001110;
                    2: class_vec_out = 64'b1000111100000100001110101101101010101000111011011001001110111111;
                endcase
            end
            1: begin
                case (frame_index)
                    0: class_vec_out = 64'b1010110101110010011110111101000110001110000101101101110010000001;
                    1: class_vec_out = 64'b1100111101110011011110111101110100011110001000111101011010000001;
                    2: class_vec_out = 64'b1110010101100010011010111101110110001110000000101100100010000010;
                endcase
            end
            2: begin
                case (frame_index)
                    0: class_vec_out = 64'b0001000010111011110111011111000011011001001000001101011010100111;
                    1: class_vec_out = 64'b0001000000011011110011011111000111011001001001011101011010100011;
                    2: class_vec_out = 64'b0011000000111011111011011111110110011001001001001110011010100111;
                endcase
            end
            3: begin
                case (frame_index)
                    0: class_vec_out = 64'b1100110000100100001010111010100001001001000001100110001110001110;
                    1: class_vec_out = 64'b1100110000100000001010111010100001001001000001100110001110001110;
                    2: class_vec_out = 64'b1100110000100100001110111010100001001001000001100110001110001110;
                endcase
            end
            4: begin
                case (frame_index)
                    0: class_vec_out = 64'b0111001010110011111111110010001101111110001111011011001011110010;
                    1: class_vec_out = 64'b0111001010110011111111110010001101111110001111011011001011110010;
                    2: class_vec_out = 64'b0111001010110011111111110010001101111110001111011011001011110010;
                endcase
            end
            5: begin
                case (frame_index)
                    0: class_vec_out = 64'b1110101010100011100000110010101011110011101001010001000100011001;
                    1: class_vec_out = 64'b1110101010100011100000110010101011110011101001010001000100011001;
                    2: class_vec_out = 64'b1110101010100011100000110010101011110011101001010001000100011001;
                endcase
            end
            6: begin
                case (frame_index)
                    0: class_vec_out = 64'b1010010010001100010110100000100011000000011010000111011011011001;
                    1: class_vec_out = 64'b1010010010001100010110100000100011000000011010000111011011011001;
                    2: class_vec_out = 64'b1010010010001100010110100000100011000000011010000111011011011001;
                endcase
            end
            7: begin
                case (frame_index)
                    0: class_vec_out = 64'b0001110011001110110000100110101100111110000111111110111111111100;
                    1: class_vec_out = 64'b0001110011001110110000100110101100111110000111111110111111111100;
                    2: class_vec_out = 64'b0001110011001110110000100110101100111110000111111110111111111100;
                endcase
            end
        endcase
    end
endmodule