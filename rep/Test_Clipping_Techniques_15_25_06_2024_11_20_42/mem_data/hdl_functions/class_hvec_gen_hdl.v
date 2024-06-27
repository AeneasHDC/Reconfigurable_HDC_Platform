
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
                    0: class_vec_out = 64'b0000000000001000000000000000000000000000000000000000000000000000;
                    1: class_vec_out = 64'b0000000000000000000000000000000000000000001000000000000000000000;
                    2: class_vec_out = 64'b0000000000001000000000000000000000000000000000000100000000000000;
                endcase
            end
            1: begin
                case (frame_index)
                    0: class_vec_out = 64'b0000000000000000000000000000000000000000000000000000000000000000;
                    1: class_vec_out = 64'b0000000000000000000000000000000000000000000000000000000000000000;
                    2: class_vec_out = 64'b0000000000000000100000000000000000000000000000000000000000000000;
                endcase
            end
            2: begin
                case (frame_index)
                    0: class_vec_out = 64'b0000000000000000000000000000000000000000010000000000000000000010;
                    1: class_vec_out = 64'b0000000000000000000000000000000000000000000000000000000000000000;
                    2: class_vec_out = 64'b0000000010000000000000000000000000000000000000000000000000000000;
                endcase
            end
            3: begin
                case (frame_index)
                    0: class_vec_out = 64'b0000000000000000000000000000000000000001000000100000000000000000;
                    1: class_vec_out = 64'b0000000000000000100001101000000000000000000000000000000000000000;
                    2: class_vec_out = 64'b0000000100000000000000100000000000000000000000000100000100000000;
                endcase
            end
            4: begin
                case (frame_index)
                    0: class_vec_out = 64'b0000000000000000000000000000000000000000000000000000000000000000;
                    1: class_vec_out = 64'b0000000000000000000000000000000000000000000000000000000000000000;
                    2: class_vec_out = 64'b0000001000000000000000000000000000000000000000000000000000000000;
                endcase
            end
            5: begin
                case (frame_index)
                    0: class_vec_out = 64'b0000000000000000000000000000000000000000000000000000000000000000;
                    1: class_vec_out = 64'b0000000000000000000000000000000000000000000000000000000000000000;
                    2: class_vec_out = 64'b0000100000000000000000000000000000000000000000000000000010000000;
                endcase
            end
            6: begin
                case (frame_index)
                    0: class_vec_out = 64'b0000000000000010000000000000001000000000000000000000000000000000;
                    1: class_vec_out = 64'b0000000000000010000000000000000000000000000000010000000000000000;
                    2: class_vec_out = 64'b0000000000000000000000000000000000000000000000000000000000000000;
                endcase
            end
            7: begin
                case (frame_index)
                    0: class_vec_out = 64'b0100000000000000000000000000000000000000000000000000000000000000;
                    1: class_vec_out = 64'b0000000000000000100000000000000000000000000000000000000000000000;
                    2: class_vec_out = 64'b0000000000000000100000000000000000000000000000000000000000000000;
                endcase
            end
        endcase
    end
endmodule