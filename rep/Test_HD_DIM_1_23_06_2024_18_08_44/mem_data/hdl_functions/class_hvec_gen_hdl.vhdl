
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
                    when "00" => class_vec_out <= "1010111100100100110110011000011000000010100101111010001111101100";
                    when "01" => class_vec_out <= "1010110100100000110111010010011000000010100101111010001111101100";
                    when "10" => class_vec_out <= "1010111100000100110110011000011000000010100101111010001111101100";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0100111010100110000010011100000011111101101000010101001110100110";
                    when "01" => class_vec_out <= "0100111110100110000010011100000011110101101000010101011110100110";
                    when "10" => class_vec_out <= "0100111010100110000010011100000010111101101000010101011110100110";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1011111011001111100000101001000010111011000111100110100001110001";
                    when "01" => class_vec_out <= "1011111011001111100000101001000010111011000111100110100000110100";
                    when "10" => class_vec_out <= "1011111011001111100001101001000010111011000111100111100000110111";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0101101100000100100010111001000010111010101111001101011010111101";
                    when "01" => class_vec_out <= "0101101100000100001010111001000010111010101111001101111010111101";
                    when "10" => class_vec_out <= "0101101100000000000010111001000010111010101111001101111010111101";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0101110011101101000101010010011010111000100011011100000000001110";
                    when "01" => class_vec_out <= "0101110111101101001001010010011000111000100011011100000000001110";
                    when "10" => class_vec_out <= "0101010011101101001101010010011000011000100001011101000000001110";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100010010011011001100100011000110110000100100010110001111110001";
                    when "01" => class_vec_out <= "1100010010011011000110010011000110110000100100010111001111110000";
                    when "10" => class_vec_out <= "1100010010111011000100110011100110110000110100010010001111110000";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1110110111001011010111101110010001111000111011000000010000011001";
                    when "01" => class_vec_out <= "0100110111001011010111101100010001111000101010000000000000011011";
                    when "10" => class_vec_out <= "0110110111001011010111101110010000111000101010000000010000011001";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0111011101011111110001001010001100101101101000111010110000110010";
                    when "01" => class_vec_out <= "1111111101011111110001001010000100101101101010110010110000110010";
                    when "10" => class_vec_out <= "0011111101010111110001001010000100101101101010110010110000110010";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;