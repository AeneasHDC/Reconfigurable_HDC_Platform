
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
                    when "00" => class_vec_out <= "1011010110001100010001110011010000010011001011001001000000000000";
                    when "01" => class_vec_out <= "1011010110001000010001110011010000010001001111101001000000000100";
                    when "10" => class_vec_out <= "1011010110001100010001110001010000010011001101101001000001000000";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "1000010000101110001010000011011001001111000001100100011100010011";
                    when "01" => class_vec_out <= "1000010000101110001010010011011001101111000001100100011100010011";
                    when "10" => class_vec_out <= "1000010000101110001010000011010001001011000001100101011100010011";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100101001110000011101111111010110110010101101010110000110001011";
                    when "01" => class_vec_out <= "1100101001110000011101111110011110111010101100110110000110001011";
                    when "10" => class_vec_out <= "1100101001110000011111111111011110110010101101010110010110001011";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "1110101110011111111100111010100100100110001101001100101100001111";
                    when "01" => class_vec_out <= "1110101110011111110100111010000100100110001101001110101100001111";
                    when "10" => class_vec_out <= "1110101110011111110100111010000101100111001101001100100100001111";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100111110110001000000101000110111011011000110010001010101010101";
                    when "01" => class_vec_out <= "1100111110110001000001101010110111011011000110011001010110110101";
                    when "10" => class_vec_out <= "1100111110110001000100101000110111011011000110110001010111110101";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "1011001100011011100001011111101101101101110000010111000001001111";
                    when "01" => class_vec_out <= "1011001100011011100111011111101101101101110010010111000011001111";
                    when "10" => class_vec_out <= "1011001100011011100001010111101101101001111000010111000011001111";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "0111110110011001111000110110011100010100000110100100001100101110";
                    when "01" => class_vec_out <= "0111110110011001111000010110011101010100000110100100001101101110";
                    when "10" => class_vec_out <= "0111110110011001111000110110011101010100000110100100001100101110";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "1010110010101011001111111000010001000111101000000010011111001110";
                    when "01" => class_vec_out <= "1110110110101000001111101000010000000111101000000010011111001110";
                    when "10" => class_vec_out <= "1010110110101000001111101000010010000111101000000010011111001110";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;