
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
                    when "00" => class_vec_out <= "1010001100000111101100110000000011101100000010110001000100011101";
                    when "01" => class_vec_out <= "1010011100000111101100110000000111101100000010110001000100011001";
                    when "10" => class_vec_out <= "1110011100000111101100110000000011001100000010110001000110011001";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0001100111001000110010100101001000101011001011100101101011010110";
                    when "01" => class_vec_out <= "1001100111001000110010101101001000101011001010100101100011010110";
                    when "10" => class_vec_out <= "1001100111001000110010100101001001101011001010100101111011010010";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100000000000010011000111111101010110001001110101111001111000000";
                    when "01" => class_vec_out <= "0100000000000010011000011111101010110001000110101111001011000000";
                    when "10" => class_vec_out <= "0000000000000010011000011111100010110001001110101111011111000000";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0111101101111001101111011010100000011001000100000110101110000101";
                    when "01" => class_vec_out <= "0111101101111001111111011010100000011001000100000110101110000111";
                    when "10" => class_vec_out <= "0111101111111001101111011010000000111001000100001010101110000111";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0001111110001001010001001110110000011100110111100011100000011010";
                    when "01" => class_vec_out <= "0001111110001101000001001110110000011100100111100011101000011010";
                    when "10" => class_vec_out <= "0001111110001001010001001110110000011100110111100011101000011010";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "0010011110101100000110000101011100111001010101011110010110100100";
                    when "01" => class_vec_out <= "0010111010001100000100000101011100101001110101011100010110110100";
                    when "10" => class_vec_out <= "0010011110001100000100000101011100111101110101011110010110100100";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1000001100000100110001101100101110111111001111001110111000100000";
                    when "01" => class_vec_out <= "1000001100000100111101101100101110111111001101101110111000100000";
                    when "10" => class_vec_out <= "1000001100000100110001111100101110111111001111101110111110100100";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0101111111100010001001010101000101101001010100011100100000011010";
                    when "01" => class_vec_out <= "0101110111100010001001010100000111101001010100011000100001011010";
                    when "10" => class_vec_out <= "0101110111101010001001010101000101101001011101011110100000011010";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;