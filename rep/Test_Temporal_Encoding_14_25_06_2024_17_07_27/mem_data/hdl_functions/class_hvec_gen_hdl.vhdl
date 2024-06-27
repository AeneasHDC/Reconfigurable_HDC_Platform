
----
 -- @file class_hvec_gen_hdl.hpp
 -- @brief This script generates HDL code for generating high-dimensional class vectors.
 -- It is a novel method; for more information, please refer to our paper.
 --
 -- @author Saeid Jamili and Marco Angioli
 -- @note Author names are listed in alphabetical order.
 -- @email <saeid.jamili@uniroma1.it>
 -- @email <marco.angioli@uniroma1.it>
 --
 -- @contributors
 --
 -- @date Created: 24th July 2023
 -- @date Last Updated: 23th August 2023
 --
 -- @version 1.0.0
 --
 -- @institute Sapienza University of Rome
 -- @cite https://doi.org/10.xxxx/yyyyy
 --
 -- @section DEPENDENCIES
 -- - Dependency1: Description or version details.
 -- - Dependency2: Description or version details.
 --
 -- @section LICENSE
 -- This file is part of the Aeneas HyperCompute Platform.
 --
 -- Licensed under the MIT License. See the LICENSE file in the project root for full license details.
 --
 -- @section CHANGELOG
 -- @version 1.0.0-dev - 23th August 2023
 -- - Initial release
 --
 -- @todo
 -- - Complete level vector generator function
 -- - Add training
 --
 -- @see
 -- -
 -- -
 -- -
 --
 --

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity class_vec_gen is
    Port ( class_vec_out : out  STD_LOGIC_VECTOR (63 downto 0);
           frame_id : in  STD_LOGIC_VECTOR (2 downto 0);
           frame_index : in  STD_LOGIC_VECTOR (1 downto 0));
end class_vec_gen;

architecture Behavioral of class_vec_gen is
begin
    process (frame_id, frame_index)
    begin
        -- Update this function to match your requirements
        case frame_id is
            when "000" =>
                case frame_index is
                    when "00" => class_vec_out <= "0111011111111100000001110111000001110001011000100000111000111000";
                    when "01" => class_vec_out <= "0111011111111100000001110111000011110001011000000001111000111000";
                    when "10" => class_vec_out <= "0111111111111100000001110111000011100001011001100001111000111000";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000000010010011000011110000111111110000000000000000000011100100";
                    when "01" => class_vec_out <= "0000000011010001000011110000111111110000000000000000011011100000";
                    when "10" => class_vec_out <= "0000000110110011000011110000101111110000000100010000000011100000";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "0011101111100000110010000011000000000000111010010000000001100000";
                    when "01" => class_vec_out <= "0011101011100000110011000011000000000000010010010000000001100000";
                    when "10" => class_vec_out <= "0011111111100000110011000111000000000000010000010100110001100000";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0100000011111100110111000000011100000011100011110011011001100111";
                    when "01" => class_vec_out <= "0100000011111100100111000000011000000011100011110011010001100111";
                    when "10" => class_vec_out <= "0100000011111100111111000000010100000011100011110010010001100110";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000111100000001101000100110100110000001100000000010000010000011";
                    when "01" => class_vec_out <= "0000111100000011111000101111100110000001100000000010000000000011";
                    when "10" => class_vec_out <= "0000111100000001101000100110110110000100110000001011000110000011";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "1000000010000000110010010010000001001000110110100000000111001000";
                    when "01" => class_vec_out <= "1000000010000000110110010010000001001000000100100011000111001000";
                    when "10" => class_vec_out <= "1000000011000001110010000110000000001000110101100000010110001100";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100111111011111111110000000000111011111111100110000000110101100";
                    when "01" => class_vec_out <= "1100111111011111101110000000000111011111111100111000000110101000";
                    when "10" => class_vec_out <= "1100011111011111111110000000000111111111111100110000001110101100";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0001011001101100011111101000000000111000110001111000110110000011";
                    when "01" => class_vec_out <= "0000011001101110011111101000000000111000110111111000110110001011";
                    when "10" => class_vec_out <= "0000011101101100011101101001000000111000100111111001010110000011";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;