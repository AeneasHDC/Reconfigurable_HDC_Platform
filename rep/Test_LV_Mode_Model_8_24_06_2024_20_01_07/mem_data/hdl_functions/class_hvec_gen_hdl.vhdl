
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
                    when "00" => class_vec_out <= "0101110010001100010011011110110010110010101000010011011100001011";
                    when "01" => class_vec_out <= "1101110011001101110001011001010001111010001000010010011100001011";
                    when "10" => class_vec_out <= "1101010010001101111011011100111000110010100000000011011110101001";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010110110000000000100110111101101110001010101110010000000111110";
                    when "01" => class_vec_out <= "1010010110011000010100110111001101010101010000110000000000111110";
                    when "10" => class_vec_out <= "1010110101000000010100110111001101110100010000111000000001101110";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "0101100011001001111111000111101011101111110111000100000010100011";
                    when "01" => class_vec_out <= "0101110011001001110111010111001010000011110011000100000000100011";
                    when "10" => class_vec_out <= "0101110011000001111100101011001111001111110011000100010010100011";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0110001111101000111000011110101000101000111101111000000111111011";
                    when "01" => class_vec_out <= "0110011101101001111001011100101000101000111101111000000111111011";
                    when "10" => class_vec_out <= "1110001111101001111000011100101000101000111101111000000111111011";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "1101010110010011100010111101001001100010010001000000101110000000";
                    when "01" => class_vec_out <= "1101010110010011100010111101001001100010010001000000101110000000";
                    when "10" => class_vec_out <= "1101010110010011100010111101001001100010010001000000101110000000";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000001000111110101110001001000111110010110111110011110000000111";
                    when "01" => class_vec_out <= "0000001000111110101110001001000111110010110111110011110000000111";
                    when "10" => class_vec_out <= "0000001000111110101110001001000111110010110111110011110000000111";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1011011001101001110111011010111000000010010101110101100011011100";
                    when "01" => class_vec_out <= "1011011001101001110111011010111000000010010101110101100011011100";
                    when "10" => class_vec_out <= "1011011001101001110111011010111000000010010101110101100011011100";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0001100000011000101011001101011010101011001110110001010001001111";
                    when "01" => class_vec_out <= "0001100000011000101011001101011010101011001110110001010001001111";
                    when "10" => class_vec_out <= "0001100000011000101011001101011010101011001110110001010001001111";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;