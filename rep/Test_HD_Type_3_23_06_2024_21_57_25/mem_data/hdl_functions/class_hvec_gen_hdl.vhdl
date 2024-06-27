
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
                    when "00" => class_vec_out <= "1111111111000000101011101111100110010100011111111000001011001111";
                    when "01" => class_vec_out <= "0111101111000000101111101010100111110100011111111000001010001101";
                    when "10" => class_vec_out <= "1111111111000000101011101111100110010100011111111100101010001111";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0100111011010000010001101011101100001110110111010010101000010110";
                    when "01" => class_vec_out <= "0100101011010000011001101011101100011110110111010010101000000111";
                    when "10" => class_vec_out <= "0100110011000000111001101011101100001110110111010010001000000110";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1000100010010010001101000111110010011101011000000010110110101111";
                    when "01" => class_vec_out <= "1000100010010010001101001111110010011101011001000010110110101011";
                    when "10" => class_vec_out <= "1000000110010010001101001111110010011101001000000010110110101011";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0110101110101000101100110111001111111101111100110000111110000010";
                    when "01" => class_vec_out <= "0110111110101100101100110111000111111101111101100000111110000000";
                    when "10" => class_vec_out <= "0110101110101000101100110111000111111101111100100000111110000010";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100011101111011100010110000101001001101001001010011011110010010";
                    when "01" => class_vec_out <= "1100010101111011100010110000101001101101001101000011011110010010";
                    when "10" => class_vec_out <= "1100011101111011100010110000101001101101011001000011001010010010";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "1111110111000011101001101000000110000010101111110011011111000110";
                    when "01" => class_vec_out <= "1111110101000001111001011010000110010010111111110011011111000110";
                    when "10" => class_vec_out <= "1111110111010001111001111010000110000010101111110011011111100110";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1101110101011101010000011111000111010101001000100110011100010011";
                    when "01" => class_vec_out <= "1101110111011101010000011110000111011101001000100110011100010011";
                    when "10" => class_vec_out <= "1001110101011101011000011111000111010101001000100110011101010011";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100100000111110011011000111000000110110001000110100100101110100";
                    when "01" => class_vec_out <= "1100100000011010011010000111000000110110001100110100100101110100";
                    when "10" => class_vec_out <= "1100100000011110011010100111000100110110001100110100100101110100";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;