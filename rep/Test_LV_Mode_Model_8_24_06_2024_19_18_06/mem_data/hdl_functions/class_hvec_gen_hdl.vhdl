
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
                    when "00" => class_vec_out <= "0111110110011010100011101101101101011011011000011011110001101010";
                    when "01" => class_vec_out <= "0111110110011010100011101101101101011011011000011011110001100010";
                    when "10" => class_vec_out <= "0111110110011010100011101101101101011011011000011011110001101010";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010100100001111101111110111101000101111110010100010111100011000";
                    when "01" => class_vec_out <= "0010100100011111101111100111111000101111110010100010111100011000";
                    when "10" => class_vec_out <= "0010100100001111101111110111101000101111110010100000111100011000";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010011111101100000000100001010101011000011000110100010010110110";
                    when "01" => class_vec_out <= "0010011111101100000000100001011001011000011010101000011011110110";
                    when "10" => class_vec_out <= "0010011111101100000000100001010101011000011000111100010011110110";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "1110101011110010000011000100101110100100110100000101101010111010";
                    when "01" => class_vec_out <= "1110101011100110000011000100101110100100110100000101101110110010";
                    when "10" => class_vec_out <= "1110101011110011000011000000111110100100110100001101101110100010";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010100110111011010000011111101110011000101001100100010101101110";
                    when "01" => class_vec_out <= "0010100110111011010000011111101111011000101001100110010001100110";
                    when "10" => class_vec_out <= "0010100110111011110000001110101111011000101001100100000101101110";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010111101110000010010100110001101010010111110011010110110111100";
                    when "01" => class_vec_out <= "0010111101110000010010100110001101011010101110011010110110111110";
                    when "10" => class_vec_out <= "0010111101110000010010100110001100110010101110011010011100111110";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1000011001010000000011011101011010011110100001010111001011011010";
                    when "01" => class_vec_out <= "1000011001010000000011111101011011011110100001011111001011011000";
                    when "10" => class_vec_out <= "1000011001010000000011111101001010011110100001010111001011011001";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0011110101101100101101110010011010111111011100010100000011110100";
                    when "01" => class_vec_out <= "0011110101101101111001100010010010111111111100010000000001110100";
                    when "10" => class_vec_out <= "1011110101001101111101100010010010111111111100010100010001110110";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;