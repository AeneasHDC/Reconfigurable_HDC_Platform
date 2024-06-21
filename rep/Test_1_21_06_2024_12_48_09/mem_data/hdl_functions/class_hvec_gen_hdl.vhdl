
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
                    when "00" => class_vec_out <= "1001111100101111100011010011011010000111010000101110010101010111";
                    when "01" => class_vec_out <= "1001111100111111100001010011011010000111010000101110000101010111";
                    when "10" => class_vec_out <= "1000111100100111100001011011011010000111010000101110010101010111";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000110000100011001111100001010100100110100010011110100111111110";
                    when "01" => class_vec_out <= "0010110000100011001111100001010110100110100000011110100111011110";
                    when "10" => class_vec_out <= "0000010000100011001111100001010101100110100000011110100111111110";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1101111001111001100011101111000010101011011111000110011010101100";
                    when "01" => class_vec_out <= "1101111101111001100011100111000010101011111011001010011010101100";
                    when "10" => class_vec_out <= "1101111001111001100001101111000010101011011111000110011010101100";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "1010111001011111010011011110111000101111101001000101011000011001";
                    when "01" => class_vec_out <= "1010111001011111010011111100111000101111101001000101011000011001";
                    when "10" => class_vec_out <= "1010111001011111010011001110111000101111101001010100011001011001";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000100011110001111010010010101101000100010001000101100011010011";
                    when "01" => class_vec_out <= "0000000111110001111011010010101101000000010001000101100011110011";
                    when "10" => class_vec_out <= "0000000111110101111010010010101101001100010001000101100011110011";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "0011100111010111100100011001001101111110001100001111111001010100";
                    when "01" => class_vec_out <= "0011100111010101100100011001001101111111001100001111111001010100";
                    when "10" => class_vec_out <= "0011100111010111100100111001001101111111001100001111111001010111";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1011010101010011001011101000100000000010111100100110100000110111";
                    when "01" => class_vec_out <= "1011010101010011001111100000100001100010111100100110100000110111";
                    when "10" => class_vec_out <= "1011010101010111001011100000100001000011111100100110100100110111";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0011001110001000010011000011111010100111111000111101000011000100";
                    when "01" => class_vec_out <= "0010001110001000010011000011111010100101111000101101001011000100";
                    when "10" => class_vec_out <= "0010001110001000010011000011111010100111111000101100101011000100";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;