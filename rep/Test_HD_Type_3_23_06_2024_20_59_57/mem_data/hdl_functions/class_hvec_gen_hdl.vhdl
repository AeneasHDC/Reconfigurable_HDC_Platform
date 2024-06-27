
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
                    when "00" => class_vec_out <= "0110101110011011110100110111000011101000100111101001111110111001";
                    when "01" => class_vec_out <= "0110101110111011110100110111000011001000100111111001111110111001";
                    when "10" => class_vec_out <= "0110101110111011110100110111010010101100100110101001111110111000";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0111011100001101100001000110011001001101001101010001111001000100";
                    when "01" => class_vec_out <= "0111011100001101100001000111011011001101000101010001111001100000";
                    when "10" => class_vec_out <= "0011011100011101100001000111011001001101001001010001111001000100";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000110011010001100001010000100010101110001001101010111101100001";
                    when "01" => class_vec_out <= "0000110001010001100001010000100010101110001001101010111101011001";
                    when "10" => class_vec_out <= "0000110011010001100101010000100010101010001001101010111101100011";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000001110010001101001110001010000111110001110101111101100001100";
                    when "01" => class_vec_out <= "0000000110010001101001110001010000111110101110100111101100001100";
                    when "10" => class_vec_out <= "0000000110010000101001110001010000101110101110100111101100001100";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0011111011011101100011101110110000110101001000001110011110000011";
                    when "01" => class_vec_out <= "0011111011001101101011001110110000010101001001001110011110000011";
                    when "10" => class_vec_out <= "0011011011011100100011001110110000100101001000001010001110000011";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100110001111000010111001010101110011011111111001101111111010110";
                    when "01" => class_vec_out <= "1000110001011000010101001010101111011011011111001101111111010110";
                    when "10" => class_vec_out <= "1100110010111000010111001010101110011001011111001101111111010110";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1110100101100000001000010011101010001101110000100010111000101110";
                    when "01" => class_vec_out <= "1110100101100100001000010011001010001100110000100100111001101110";
                    when "10" => class_vec_out <= "1110100101100100001000010011101010001100110000100000111000101110";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "1001011001001010110010011001010000111010111010110101000011111110";
                    when "01" => class_vec_out <= "1100001001001110110011011001010000111010111011110101000011111110";
                    when "10" => class_vec_out <= "0001001001001110110010011001010000111010111010110101000011111110";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;