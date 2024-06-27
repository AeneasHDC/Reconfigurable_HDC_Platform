
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
                    when "00" => class_vec_out <= "0000000000000011000000000111110011111110011100000010000110001100";
                    when "01" => class_vec_out <= "0000000000000011000000000111110011111111011100001010000110011100";
                    when "10" => class_vec_out <= "1000000000010011000000000111110011111111011100000000000110001100";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "1100001111110111000000000001011111111110000000000111111111001111";
                    when "01" => class_vec_out <= "1100011111110111000000000101011111101110000000000111111111011111";
                    when "10" => class_vec_out <= "1110000111110111000000000001011111101110000000000111111111000111";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "1111110011101111001111111001111000000011011111110111110000000001";
                    when "01" => class_vec_out <= "1111000000001111000111111011111000000011011111100011110000000000";
                    when "10" => class_vec_out <= "1111000010101111001111111001111000000111011101110111110000000001";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "1111100000011111101000001110000000001111111111111100111000001110";
                    when "01" => class_vec_out <= "1111100000001111101000001110000000001111111111111100111000011110";
                    when "10" => class_vec_out <= "1111100000001111000000001110000000001111111111011100111000001110";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000111100011100001011110001111000111100111000000000011111000111";
                    when "01" => class_vec_out <= "0000111100011100001111100001111000111100111010000000011111000111";
                    when "10" => class_vec_out <= "0000111100011110001111110000111000111000111000000000011111000111";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "0011100011100111100011111111100001011111000011001110000100000101";
                    when "01" => class_vec_out <= "0011100011000111000011111111110001011111000000001110001100000111";
                    when "10" => class_vec_out <= "0001100011100111000011111111100001111111000000001110000100001111";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "1101111100010111011111110000001011100000011111111100011100000111";
                    when "01" => class_vec_out <= "1001111100011111011111110000001011100000001111111100011111000111";
                    when "10" => class_vec_out <= "1001111100010111011111100000000011100000011111111100011101000111";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "1001111111110001100001111000000111000111111111001100000011111111";
                    when "01" => class_vec_out <= "1000111111110001100001111000000111100011111111001100001111111111";
                    when "10" => class_vec_out <= "1001111111110001100001111000000111100111111111001110000011111111";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;