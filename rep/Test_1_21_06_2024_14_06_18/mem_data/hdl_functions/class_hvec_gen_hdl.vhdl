
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
                    when "00" => class_vec_out <= "0001011110101010010101101101101100001101111010000110101110011010";
                    when "01" => class_vec_out <= "0001011110101010010101101101101100001101111010000110101110011010";
                    when "10" => class_vec_out <= "0001011110101010010101101101101100101101111010100110101110010010";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000110111111000001001110111010110100001000010111000101000100101";
                    when "01" => class_vec_out <= "0100010011111000001001110111010110100101000010111000101010100101";
                    when "10" => class_vec_out <= "0000010111111000001001110111010111100001000010111000101010100101";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1101111011010100010000000011000010101001001001001001110011100111";
                    when "01" => class_vec_out <= "1101111010011100010000000011000010101001001001001001110011100111";
                    when "10" => class_vec_out <= "1100111000010100010000001011000010101001001001001001100011100111";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "1011001101011100111100100001111010001011011100010011100100111110";
                    when "01" => class_vec_out <= "1011001101011100111100100001111010000011011100110011100000101110";
                    when "10" => class_vec_out <= "1111001101011100111110100001111010001111011100010011100000111110";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100110001010000000000101101110111001001110111001101000011001001";
                    when "01" => class_vec_out <= "1100110001010000001100101111010110001000110111001001000011101001";
                    when "10" => class_vec_out <= "0101110001010000000100101111110110001001110101001101000010001000";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000001100111001101110010111110111011011101000100101010110010101";
                    when "01" => class_vec_out <= "0000001100111001101110010101110111011011101000101101010110010101";
                    when "10" => class_vec_out <= "0000001100111001101110010110110111011011111000100101010110010101";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1001101010011101101001000110100010101001011100001010000110000111";
                    when "01" => class_vec_out <= "1001101010011101101001000110100010101001010101011011000111000111";
                    when "10" => class_vec_out <= "1001101010011101101101000110100010100001011100011010000110000111";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000101100111011101111011101000000110010111111110101000111111101";
                    when "01" => class_vec_out <= "1001101100111011101111011100000000110110111011011101001111110101";
                    when "10" => class_vec_out <= "0000101100111011101110011100000000110010111111110101001111111101";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;