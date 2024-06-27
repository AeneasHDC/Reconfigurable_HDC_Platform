
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
                    when "00" => class_vec_out <= "1100001100010111111101100110101100111111111110000100100110100000";
                    when "01" => class_vec_out <= "1100001100010111111101000110101100111111111111000100100110000000";
                    when "10" => class_vec_out <= "1110001100110111111101000110111100111111111110000100100110100000";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0100000000111101100111000000111011110111011000010000101010010010";
                    when "01" => class_vec_out <= "0100000000111101100101001001111011110111011001010000101010010010";
                    when "10" => class_vec_out <= "0100000000111101100111001000111011110111011001010000101010010110";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010100100001010111111101000011000000000000110001101010110101110";
                    when "01" => class_vec_out <= "0010100100011010111111101000011000000001100110001101110110101110";
                    when "10" => class_vec_out <= "0010100100001011111111101000001000000101100110001101110110100110";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0100111100001101000110000100001111100110010100010110101101010011";
                    when "01" => class_vec_out <= "0100111100001101000110000001001011100010010100010110101100010010";
                    when "10" => class_vec_out <= "0100111100001111000110000000011111000110010100010110101101010011";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "1110011011101110100111001110000110010101011111000000011000000011";
                    when "01" => class_vec_out <= "1110111011101110100111001111000111010101011111000010011000100010";
                    when "10" => class_vec_out <= "0110111011100110100111001111000111010101011110000000011000100010";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "1010111011111100011011111111101011001111100001010010101010000010";
                    when "01" => class_vec_out <= "1110111011111100011011111101101011001111100001010010101000000010";
                    when "10" => class_vec_out <= "1010101011111100011011111111001011001111110001010010101010000110";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010010011100111001111101110111001010110110110000001000110110111";
                    when "01" => class_vec_out <= "0010010011100111001111100110111001010110110110000001000110110111";
                    when "10" => class_vec_out <= "0010010011100111001111101110111001010110110110000001000110110111";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0110110101110101001111001011110110011010111011011101111101101110";
                    when "01" => class_vec_out <= "0110110101110001001111001011110110011010111011011101011101001010";
                    when "10" => class_vec_out <= "0110010101010101001111001011010110011011111011011101111101101010";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;