
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
                    when "00" => class_vec_out <= "0011110110001010111111100100000101000110100000000110011101011111";
                    when "01" => class_vec_out <= "0011110101001010111111100101000000100101100000011111011100011110";
                    when "10" => class_vec_out <= "1011110110000010110111001101000101100111000001000110011111011110";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "1010101110010010110101000011110100110010101110111100001010010110";
                    when "01" => class_vec_out <= "1000101010010010010101000011010100110000100110111000001010110100";
                    when "10" => class_vec_out <= "1001001010000011010101000110110100001000100110011000011110110100";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010011010110010000100111100110110100110111000001101110110011101";
                    when "01" => class_vec_out <= "0010101010110010000100111100101110100010110100001111110111011110";
                    when "10" => class_vec_out <= "0000110010110010000100111000110110100110111000101111110110011100";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "1011100000001001110000001000010101100110011011110001101011010110";
                    when "01" => class_vec_out <= "1011100000001001110000001000010101000110011011110001111011010111";
                    when "10" => class_vec_out <= "1011100000011001110000001000010101100110011011110001101011010110";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0101001011010010100101000011110011111001011010001110101100001101";
                    when "01" => class_vec_out <= "0101001011010010100101000011110011111001011010001110101100001101";
                    when "10" => class_vec_out <= "0101001011010010100101000011110011111001011010001110101100001101";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "1110110101010010111010101010110100000001100101011010011111101100";
                    when "01" => class_vec_out <= "1110110101010010111010101010110100000001100101011010011111101100";
                    when "10" => class_vec_out <= "1110110101010010111010101010110100000001100101011010011111101100";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "0100111100011100100110010011010001011111110011000011000100111100";
                    when "01" => class_vec_out <= "0100111100011100100110010011010001011111110011000011000100111100";
                    when "10" => class_vec_out <= "0100111100011100100110010011010001011111110011000011000100111100";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "1111101010010111010000111100101100001100001101001001101100001110";
                    when "01" => class_vec_out <= "1111101010010111010000111100101100001100001101001001101100001110";
                    when "10" => class_vec_out <= "1111101010010111010000111100101100001100001101001001101100001110";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;