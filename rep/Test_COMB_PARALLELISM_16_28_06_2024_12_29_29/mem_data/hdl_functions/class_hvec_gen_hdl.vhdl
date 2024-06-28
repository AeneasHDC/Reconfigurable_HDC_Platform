
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
                    when "00" => class_vec_out <= "1110100110111101000001001110101011001101101100010010111111101001";
                    when "01" => class_vec_out <= "1110100110101101000001011100101011001101100100011010011111101001";
                    when "10" => class_vec_out <= "1110100110111101000001001110101011001101101100010011011111101001";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0111111100011010100001111100101100111010011000111000001010111000";
                    when "01" => class_vec_out <= "0111111100011010000001111100101000111011011000101010001010111000";
                    when "10" => class_vec_out <= "0111110100011010100001111100101100111010001000111001001011111000";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1110100110011100101100011001111011010110001100101110110000111011";
                    when "01" => class_vec_out <= "1110101110011101111100011001111011010110001100101110110000011011";
                    when "10" => class_vec_out <= "1110100110011100011100011001111011010110001100101110010000011011";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "1000110111001010110111010001001110100010101110010000000101011010";
                    when "01" => class_vec_out <= "1000110111001010110111010001001110100010101110010000100101011010";
                    when "10" => class_vec_out <= "1000111111001011110111010101001110100010101101010000000101011010";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "1101111111101010010011101101001001000111001110110001100011100011";
                    when "01" => class_vec_out <= "1111111111001001010011101101001001000111001110110001100011100010";
                    when "10" => class_vec_out <= "1101011111001001010011101101001001000110001110110101100011100011";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "0001110010001000011000101001110110001000111110001111000010000111";
                    when "01" => class_vec_out <= "0011110010001000011000101001110100001000111110001101000000010111";
                    when "10" => class_vec_out <= "0001110010001000011000101001110110001000101110001111000000000111";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000000101101110001000111101011010101000101100111010001011110000";
                    when "01" => class_vec_out <= "0000000101101010001000011101011010101000101100111010001011110000";
                    when "10" => class_vec_out <= "0000000101101110001010111101010010101000101100111001001011110100";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0100101100101000000111111000101111101110111110000010111110000011";
                    when "01" => class_vec_out <= "0100101100101000000111111000101101101110111110000010111110000011";
                    when "10" => class_vec_out <= "1100101100101000000111111000101101101110111110000110101100000011";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;