
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
                    when "00" => class_vec_out <= "0111010011000010011111110100100110000101101011000101110011111010";
                    when "01" => class_vec_out <= "0110011011000010011111110100100110000101101011000101110011111010";
                    when "10" => class_vec_out <= "0111010011000010011111110100100110000101101011000101110011111010";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "1101100110111111111000011001100011010010001100100000011101011011";
                    when "01" => class_vec_out <= "1101100110111111111000011001100011010010001100100000011101011011";
                    when "10" => class_vec_out <= "1101100110111111111000011001100011010010001100100000011101011011";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1110000110101000010011001101101011011100100100111011000000110100";
                    when "01" => class_vec_out <= "1110000100101000010011001101011111011100100100111101000010110011";
                    when "10" => class_vec_out <= "1110000100101000010011011101101011011100100100111011000010110000";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0110111001111110011101101010011000010101010111111100000100111001";
                    when "01" => class_vec_out <= "0110111000111110001101101000011000010101010111111100000100110001";
                    when "10" => class_vec_out <= "0111111001011110111101100010011100000001010111011100000100111011";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0111111100101111110011010101110000110001010000110110110100100111";
                    when "01" => class_vec_out <= "0110111100101111110011010101110000110001000000110110110100100110";
                    when "10" => class_vec_out <= "0111110000101111110011010101110010110001010000110111110100100110";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "1011001000110001010000100101011101101101111011101010110111100010";
                    when "01" => class_vec_out <= "1011001000100001010000100111011101101101111011101010110111100010";
                    when "10" => class_vec_out <= "1011001100100001010100100110011101101101111011100010110111100010";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000001101011000101001011101101001101100001000011101101000011110";
                    when "01" => class_vec_out <= "0000001101011000101001011101101001101100101000011101101010011110";
                    when "10" => class_vec_out <= "0100001100011010101001011101001001100100101000011101101000011110";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0001110111100110100000010001111110100111011010001100001110100011";
                    when "01" => class_vec_out <= "0111110010100111100101010001011110110111011010001100001110100011";
                    when "10" => class_vec_out <= "0001110111100110101000010001111110100111111010001100001110100011";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;