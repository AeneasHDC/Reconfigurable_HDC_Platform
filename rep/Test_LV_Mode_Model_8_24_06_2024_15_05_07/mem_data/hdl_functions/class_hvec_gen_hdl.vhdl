
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
                    when "00" => class_vec_out <= "1100100011100010110011100011000110100100010101101100001011101101";
                    when "01" => class_vec_out <= "1000000011100010110111101011000010100110010100000100111010011100";
                    when "10" => class_vec_out <= "1101001011100010110011110010001110100110110100111100011111101111";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0100010101111111010011000101100101011011110100001010010100010000";
                    when "01" => class_vec_out <= "0100010001111111010011001101100111011001110100001010010000001001";
                    when "10" => class_vec_out <= "0100011001110111001011100100100111010101000101101010010100011001";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1101101111101000101001100001000101111100100000011101110011100000";
                    when "01" => class_vec_out <= "1101101111001000101000100000000100111100000000011100100011000101";
                    when "10" => class_vec_out <= "1101101101111000101001110001000010111100100000011100110011100000";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0111110110101010100101100110000100111011010100000111010011001001";
                    when "01" => class_vec_out <= "0111110110101010101101100110000000111011010100000101010011001000";
                    when "10" => class_vec_out <= "1111110110101010100101100110000100111011010100000111010011001001";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0011100100000101001100111000110001110110011001010010110001000101";
                    when "01" => class_vec_out <= "0011100100000101001100111000110001110110011001010010110001000101";
                    when "10" => class_vec_out <= "0011100100000101001100111000110001110110011001010010110001000101";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "1110001111011011011011110000101010100111111000111111011100101110";
                    when "01" => class_vec_out <= "1110001111011011011011110000101010100111111000111111011100101110";
                    when "10" => class_vec_out <= "1110001111011011011011110000101010100111111000111111011100101110";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "0100010100011101010110001100010000100000001111000111100101010011";
                    when "01" => class_vec_out <= "0100010100011101010110001100010000100000001111000111100101010011";
                    when "10" => class_vec_out <= "0100010100011101010110001100010000100000001111000111100101010011";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010101101100001111110000101111111100011000011101110110110001000";
                    when "01" => class_vec_out <= "0010101101100001111110000101111111100011000011101110110110001000";
                    when "10" => class_vec_out <= "0010101101100001111110000101111111100011000011101110110110001000";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;