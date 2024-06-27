
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
                    when "00" => class_vec_out <= "0010010011010111000011100010100001010011110111001110101011000000";
                    when "01" => class_vec_out <= "0010010110010110000011110010100000010001110101001110101011000000";
                    when "10" => class_vec_out <= "1010010111010001000011100010100001011011110111000110101011000000";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "1010000011110011000011100001110010010100100011101000010000000110";
                    when "01" => class_vec_out <= "1110000011110010000011001010110010010100100011001000010000000110";
                    when "10" => class_vec_out <= "1110000011110011000010000010110010010100100011101000010000000110";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1000000110101110000110110000011100100010000011101110101101000011";
                    when "01" => class_vec_out <= "1000000110101110000110110000011100100010000111101110101111000111";
                    when "10" => class_vec_out <= "1100000110101010000110110000011100111010010011101110101111100011";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000011011001011000011111100001100100111111101011111100100010100";
                    when "01" => class_vec_out <= "0000011111001010000011111110001100100111111101001111100100010100";
                    when "10" => class_vec_out <= "0000011011001010000011111100001100100111111101001110100100010100";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0001111011100110100110111000111110111001101000010110010010100101";
                    when "01" => class_vec_out <= "0001111011100110100110111100011110111101101000010110010010100101";
                    when "10" => class_vec_out <= "0001111011100100100110111100111111111001101000010100010010110101";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "0101010011101101011010010100110001111010100111110111100110000000";
                    when "01" => class_vec_out <= "0111010011101110011010010100110001111010100111110111110110000000";
                    when "10" => class_vec_out <= "0111010011101101011010010100110001111010100110100111110110001000";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100011110110100011101010001010010011011011101110110101111101100";
                    when "01" => class_vec_out <= "1100111110110000011101010001010010011011011101110110101111101100";
                    when "10" => class_vec_out <= "1100111110110100011101010001010010111011011101110111101111101100";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "1001010010000001101010111001010011000110101110110000100010100001";
                    when "01" => class_vec_out <= "1001010011000011101010110001010011000110101110110000110011100001";
                    when "10" => class_vec_out <= "1001010010000000101010011001010011000110101110010000110011100001";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;