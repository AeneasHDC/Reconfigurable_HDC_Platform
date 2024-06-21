----
 -- @file level_hvec_gen_hdl.hpp
 -- @brief This script generates HDL code for generating high-dimensional LEVEL vectors.
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

entity level_vec_gen is
    Port ( level_vec_out : out  STD_LOGIC_VECTOR (63 downto 0);
           frame_index : in  STD_LOGIC_VECTOR (2 downto 0);
           frame_id : in  STD_LOGIC_VECTOR (4 downto 0));
end level_vec_gen;

architecture Behavioral of level_vec_gen is
begin
    process (frame_index, frame_id)
    begin
        -- Update this function to match your requirements
        case frame_index is
            when "000" =>
                case frame_id is
                    when "00000" => level_vec_out <= "1101000110100011111111000001001011100100111001010101110010101000";
                    when "00001" => level_vec_out <= "1101000110100011111111000001001011110100111001010101110010101000";
                    when "00010" => level_vec_out <= "1101000110100011111111000001001011110101111001010101110010101000";
                    when "00011" => level_vec_out <= "1101000110100011111111000001001111110101111001010101110010101000";
                    when "00100" => level_vec_out <= "1101000110100011111111001001001111110101111001010101110010101000";
                    when "00101" => level_vec_out <= "1101000110100011111111001001001111110101111001010101110010101000";
                    when "00110" => level_vec_out <= "1101000110100011111111001001001111110111111001010101110010101000";
                    when "00111" => level_vec_out <= "1101000111100011111111101001001111110111111101010101110010111000";
                    when "01000" => level_vec_out <= "1101000111100011111111101001001111110111111101010101110010111000";
                    when "01001" => level_vec_out <= "1101000111100011111111101001011111110111111101010111110010111000";
                    when "01010" => level_vec_out <= "1101000111101011111111101001011111110111111101010111110010111000";
                    when "01011" => level_vec_out <= "1101000111101011111111101011011111110111111101010111110010111000";
                    when "01100" => level_vec_out <= "1101001111101011111111101011011111110111111101010111110010111000";
                    when "01101" => level_vec_out <= "1101001111101011111111101011011111110111111101110111110010111000";
                    when "01110" => level_vec_out <= "1101001111101011111111101011011111110111111101110111110010111001";
                    when "01111" => level_vec_out <= "1101001111101011111111101011011111110111111101110111110010111001";
                    when "10000" => level_vec_out <= "1101001111101011111111101011011111110111111111110111110010111001";
                    when "10001" => level_vec_out <= "1101001111101011111111101011111111110111111111110111110010111001";
                    when "10010" => level_vec_out <= "1101001111101011111111101011111111110111111111110111110011111001";
                    when "10011" => level_vec_out <= "1101001111101011111111101011111111110111111111110111110011111001";
                    when "10100" => level_vec_out <= "1101001111101011111111101011111111110111111111110111110011111001";
                    when "10101" => level_vec_out <= "1111001111101011111111101011111111110111111111110111110011111101";
                    when "10110" => level_vec_out <= "1111001111101011111111101011111111110111111111110111110011111101";
                    when "10111" => level_vec_out <= "1111001111101111111111101011111111110111111111110111111011111101";
                    when "11000" => level_vec_out <= "1111101111101111111111101011111111110111111111110111111011111101";
                    when "11001" => level_vec_out <= "1111101111101111111111101011111111110111111111110111111011111101";
                    when "11010" => level_vec_out <= "1111101111111111111111101011111111110111111111110111111011111101";
                    when "11011" => level_vec_out <= "1111101111111111111111101111111111110111111111110111111011111101";
                    when "11100" => level_vec_out <= "1111111111111111111111101111111111110111111111111111111011111101";
                    when "11101" => level_vec_out <= "1111111111111111111111101111111111110111111111111111111111111101";
                    when "11110" => level_vec_out <= "1111111111111111111111101111111111110111111111111111111111111111";
                    when "11111" => level_vec_out <= "1111111111111111111111101111111111110111111111111111111111111111";
                when others => null;
                end case;
            when "001" =>
                case frame_id is
                    when "00000" => level_vec_out <= "0010110001000000001111101000010110001010111000100110110001100100";
                    when "00001" => level_vec_out <= "0010110001000000001111101000011110001010111000100110110001100100";
                    when "00010" => level_vec_out <= "0011110001000000001111101000011110001110111000100110110001100100";
                    when "00011" => level_vec_out <= "0111110001000000001111101000011110001110111000100110110001100100";
                    when "00100" => level_vec_out <= "0111110001000000001111101000011110001110111000100110110001100100";
                    when "00101" => level_vec_out <= "0111110001100000001111101000011110001110111000100110110001100100";
                    when "00110" => level_vec_out <= "0111110001100000011111101000011110001110111000100110110001100100";
                    when "00111" => level_vec_out <= "0111110001100000011111101000011110001110111000100110110001100100";
                    when "01000" => level_vec_out <= "0111110001100000011111101000011110001110111000100110110001100100";
                    when "01001" => level_vec_out <= "0111110001110000011111101000011110001110111000100110110001100100";
                    when "01010" => level_vec_out <= "0111110001110000011111101000011110001110111000100111110101100100";
                    when "01011" => level_vec_out <= "0111110001111000011111101000011110001110111000100111110101100100";
                    when "01100" => level_vec_out <= "0111110011111000011111101100011110001110111000100111110101101100";
                    when "01101" => level_vec_out <= "0111110011111000011111101100011110001110111000100111110101101101";
                    when "01110" => level_vec_out <= "0111110011111000011111101100111110001110111000101111110111101111";
                    when "01111" => level_vec_out <= "0111111011111000011111101100111110001110111000101111110111101111";
                    when "10000" => level_vec_out <= "0111111011111000011111101100111110011110111000101111110111101111";
                    when "10001" => level_vec_out <= "0111111011111000011111101100111110011110111100101111110111101111";
                    when "10010" => level_vec_out <= "0111111011111000011111101100111110111110111111101111110111101111";
                    when "10011" => level_vec_out <= "0111111011111101011111101100111111111110111111101111110111101111";
                    when "10100" => level_vec_out <= "0111111011111101011111101100111111111110111111101111110111101111";
                    when "10101" => level_vec_out <= "0111111011111101011111101100111111111110111111101111110111111111";
                    when "10110" => level_vec_out <= "0111111011111101011111111100111111111110111111101111110111111111";
                    when "10111" => level_vec_out <= "0111111011111101111111111100111111111110111111101111111111111111";
                    when "11000" => level_vec_out <= "0111111011111101111111111100111111111110111111101111111111111111";
                    when "11001" => level_vec_out <= "0111111011111111111111111100111111111110111111101111111111111111";
                    when "11010" => level_vec_out <= "0111111111111111111111111100111111111110111111101111111111111111";
                    when "11011" => level_vec_out <= "0111111111111111111111111110111111111111111111111111111111111111";
                    when "11100" => level_vec_out <= "1111111111111111111111111110111111111111111111111111111111111111";
                    when "11101" => level_vec_out <= "1111111111111111111111111111111111111111111111111111111111111111";
                    when "11110" => level_vec_out <= "1111111111111111111111111111111111111111111111111111111111111111";
                    when "11111" => level_vec_out <= "1111111111111111111111111111111111111111111111111111111111111111";
                when others => null;
                end case;
            when "010" =>
                case frame_id is
                    when "00000" => level_vec_out <= "0111000010001010000101101110110111100111011010000001001111111111";
                    when "00001" => level_vec_out <= "0111000010001010000101101110110111100111011010000001001111111111";
                    when "00010" => level_vec_out <= "0111000010001010000101101110110111100111011010001001001111111111";
                    when "00011" => level_vec_out <= "0111000010001010100101101110110111100111011011001001001111111111";
                    when "00100" => level_vec_out <= "0111000010001010100101101111110111100111011011001001001111111111";
                    when "00101" => level_vec_out <= "0111000010001010100101101111111111100111011011001011001111111111";
                    when "00110" => level_vec_out <= "0111000010001010101101101111111111101111011011001011001111111111";
                    when "00111" => level_vec_out <= "0111000011001010101101101111111111101111011111001011011111111111";
                    when "01000" => level_vec_out <= "0111000011001010101101111111111111101111011111001011011111111111";
                    when "01001" => level_vec_out <= "0111100011001010101101111111111111101111011111001011011111111111";
                    when "01010" => level_vec_out <= "0111100011001010101101111111111111101111011111001011011111111111";
                    when "01011" => level_vec_out <= "0111100011001110101101111111111111101111011111001011011111111111";
                    when "01100" => level_vec_out <= "1111100011001110101101111111111111101111011111001011011111111111";
                    when "01101" => level_vec_out <= "1111100011001110101101111111111111101111011111001011011111111111";
                    when "01110" => level_vec_out <= "1111100011001110101101111111111111101111011111001011011111111111";
                    when "01111" => level_vec_out <= "1111100011001110101101111111111111101111111111001011011111111111";
                    when "10000" => level_vec_out <= "1111100011001110101101111111111111111111111111001011011111111111";
                    when "10001" => level_vec_out <= "1111100011001110101101111111111111111111111111001011011111111111";
                    when "10010" => level_vec_out <= "1111100011001110101101111111111111111111111111001011011111111111";
                    when "10011" => level_vec_out <= "1111100011001110101101111111111111111111111111001011011111111111";
                    when "10100" => level_vec_out <= "1111110011001111101101111111111111111111111111001111011111111111";
                    when "10101" => level_vec_out <= "1111110011001111101101111111111111111111111111001111111111111111";
                    when "10110" => level_vec_out <= "1111110011011111101111111111111111111111111111001111111111111111";
                    when "10111" => level_vec_out <= "1111110011111111101111111111111111111111111111001111111111111111";
                    when "11000" => level_vec_out <= "1111111011111111101111111111111111111111111111011111111111111111";
                    when "11001" => level_vec_out <= "1111111011111111101111111111111111111111111111011111111111111111";
                    when "11010" => level_vec_out <= "1111111011111111101111111111111111111111111111011111111111111111";
                    when "11011" => level_vec_out <= "1111111011111111101111111111111111111111111111111111111111111111";
                    when "11100" => level_vec_out <= "1111111111111111101111111111111111111111111111111111111111111111";
                    when "11101" => level_vec_out <= "1111111111111111111111111111111111111111111111111111111111111111";
                    when "11110" => level_vec_out <= "1111111111111111111111111111111111111111111111111111111111111111";
                    when "11111" => level_vec_out <= "1111111111111111111111111111111111111111111111111111111111111111";
                when others => null;
                end case;
            when "011" =>
                case frame_id is
                    when "00000" => level_vec_out <= "1010101011101001010010111110001110111000101100100101010100001111";
                    when "00001" => level_vec_out <= "1010101011101001010010111110001110111000101100100101010100001111";
                    when "00010" => level_vec_out <= "1010101011101001010010111110001110111000101100100101010100001111";
                    when "00011" => level_vec_out <= "1010101011101001010010111110001110111000101101100101010100001111";
                    when "00100" => level_vec_out <= "1010101111101001010010111110001110111000101101100101010100001111";
                    when "00101" => level_vec_out <= "1010101111101001010010111110001110111000101101100101010100001111";
                    when "00110" => level_vec_out <= "1010101111101001010010111110001111111000101101100101010100001111";
                    when "00111" => level_vec_out <= "1010101111101001010010111110001111111000101101100101010100001111";
                    when "01000" => level_vec_out <= "1010101111101001010110111110001111111000101101100101010100001111";
                    when "01001" => level_vec_out <= "1110101111101001010110111110001111111000101101100101010100001111";
                    when "01010" => level_vec_out <= "1110101111101001010110111110001111111000101101100101010100001111";
                    when "01011" => level_vec_out <= "1110101111101001010110111111001111111000101101100101010100001111";
                    when "01100" => level_vec_out <= "1110101111101001010110111111001111111010111101100101010100001111";
                    when "01101" => level_vec_out <= "1110101111101001010110111111001111111010111101100101011100001111";
                    when "01110" => level_vec_out <= "1110101111101101010110111111001111111010111101100101011100001111";
                    when "01111" => level_vec_out <= "1110101111101111010110111111001111111010111101100101011100001111";
                    when "10000" => level_vec_out <= "1110101111101111010110111111001111111010111101100101011100001111";
                    when "10001" => level_vec_out <= "1110101111101111011110111111101111111010111101100101011100001111";
                    when "10010" => level_vec_out <= "1110101111101111011110111111101111111010111101100101011100001111";
                    when "10011" => level_vec_out <= "1110101111101111011111111111101111111011111101100101011110001111";
                    when "10100" => level_vec_out <= "1110101111101111011111111111101111111011111101100101111110001111";
                    when "10101" => level_vec_out <= "1110101111101111011111111111101111111011111101100101111110001111";
                    when "10110" => level_vec_out <= "1110101111101111011111111111101111111011111101100111111110001111";
                    when "10111" => level_vec_out <= "1110101111101111011111111111101111111011111111100111111110001111";
                    when "11000" => level_vec_out <= "1110101111101111011111111111101111111011111111110111111110101111";
                    when "11001" => level_vec_out <= "1110101111101111011111111111101111111011111111111111111110101111";
                    when "11010" => level_vec_out <= "1110101111101111011111111111101111111011111111111111111111101111";
                    when "11011" => level_vec_out <= "1111101111101111011111111111101111111011111111111111111111111111";
                    when "11100" => level_vec_out <= "1111111111101111011111111111101111111111111111111111111111111111";
                    when "11101" => level_vec_out <= "1111111111101111011111111111101111111111111111111111111111111111";
                    when "11110" => level_vec_out <= "1111111111101111111111111111101111111111111111111111111111111111";
                    when "11111" => level_vec_out <= "1111111111111111111111111111101111111111111111111111111111111111";
                when others => null;
                end case;
            when "100" =>
                case frame_id is
                    when "00000" => level_vec_out <= "0101011111100100111000111101010111000011001111000000110000000011";
                    when "00001" => level_vec_out <= "0101011111100100111001111101010111000011001111000000110000000011";
                    when "00010" => level_vec_out <= "0101011111100100111001111101010111000011001111000000110000100011";
                    when "00011" => level_vec_out <= "1101011111110100111001111101010111000011001111000000110000100011";
                    when "00100" => level_vec_out <= "1101011111110100111001111101010111000011001111000000110000100011";
                    when "00101" => level_vec_out <= "1101011111110100111011111101011111000011001111000000110010100011";
                    when "00110" => level_vec_out <= "1101011111110100111011111101011111000011101111000000110010100011";
                    when "00111" => level_vec_out <= "1101011111110100111011111101011111000011101111000000110010100011";
                    when "01000" => level_vec_out <= "1101011111110100111011111101011111000011101111000000110010100011";
                    when "01001" => level_vec_out <= "1101011111110100111011111101011111000011101111000000110010100011";
                    when "01010" => level_vec_out <= "1101111111110100111111111101011111000011101111100000110010100011";
                    when "01011" => level_vec_out <= "1101111111110100111111111101011111000011101111100000110010100011";
                    when "01100" => level_vec_out <= "1101111111110100111111111101011111000011101111100000110010100011";
                    when "01101" => level_vec_out <= "1101111111110100111111111101011111000011101111110000110010100011";
                    when "01110" => level_vec_out <= "1101111111110100111111111101011111000011101111110000110110100011";
                    when "01111" => level_vec_out <= "1101111111110100111111111101011111000011101111110000110110100011";
                    when "10000" => level_vec_out <= "1101111111110100111111111101011111000011101111110000110110100011";
                    when "10001" => level_vec_out <= "1101111111110100111111111101011111000011101111111000110110100011";
                    when "10010" => level_vec_out <= "1101111111110100111111111101011111000011101111111000110110100111";
                    when "10011" => level_vec_out <= "1101111111110100111111111101011111000111101111111000110110100111";
                    when "10100" => level_vec_out <= "1101111111110100111111111111011111000111101111111000110110100111";
                    when "10101" => level_vec_out <= "1101111111110100111111111111111111000111101111111000111110100111";
                    when "10110" => level_vec_out <= "1101111111110100111111111111111111000111101111111010111110100111";
                    when "10111" => level_vec_out <= "1101111111110100111111111111111111000111101111111010111110100111";
                    when "11000" => level_vec_out <= "1101111111110101111111111111111111000111101111111010111111100111";
                    when "11001" => level_vec_out <= "1101111111110101111111111111111111000111101111111110111111110111";
                    when "11010" => level_vec_out <= "1101111111110101111111111111111111010111101111111110111111110111";
                    when "11011" => level_vec_out <= "1101111111110101111111111111111111010111101111111110111111110111";
                    when "11100" => level_vec_out <= "1101111111110101111111111111111111010111101111111110111111110111";
                    when "11101" => level_vec_out <= "1101111111110111111111111111111111010111101111111110111111110111";
                    when "11110" => level_vec_out <= "1101111111111111111111111111111111010111101111111110111111110111";
                    when "11111" => level_vec_out <= "1111111111111111111111111111111111110111101111111111111111110111";
                when others => null;
                end case;
            when "101" =>
                case frame_id is
                    when "00000" => level_vec_out <= "1101110101101100101001010111000100001010100100011111101101100100";
                    when "00001" => level_vec_out <= "1101110101101110101001010111000100001010100100011111101101101100";
                    when "00010" => level_vec_out <= "1101110101101110101001010111000100001010100100011111101101101110";
                    when "00011" => level_vec_out <= "1101110101101110101001010111000100001010100100011111101101101110";
                    when "00100" => level_vec_out <= "1101110101101110101001010111001100001110100100011111101101101110";
                    when "00101" => level_vec_out <= "1101110101101110101011010111001100001110100100011111101101101110";
                    when "00110" => level_vec_out <= "1101110101101110101011010111001100001111100100011111101101101110";
                    when "00111" => level_vec_out <= "1101110101101110101011110111001100001111100100011111101101101110";
                    when "01000" => level_vec_out <= "1101110101101110101011110111001100001111100100111111101101101110";
                    when "01001" => level_vec_out <= "1101110101101110101011110111001100001111100100111111101111101110";
                    when "01010" => level_vec_out <= "1101110111101110101011110111001100001111100100111111101111101110";
                    when "01011" => level_vec_out <= "1101110111101110101011110111001100001111100100111111101111101110";
                    when "01100" => level_vec_out <= "1101110111101110101011110111001100001111100100111111101111101110";
                    when "01101" => level_vec_out <= "1101111111101110101011110111001100001111100100111111101111101110";
                    when "01110" => level_vec_out <= "1101111111101110101011110111001100001111100100111111101111101110";
                    when "01111" => level_vec_out <= "1101111111101110101011110111001101001111100100111111111111101110";
                    when "10000" => level_vec_out <= "1101111111101111101011110111001101001111101100111111111111101110";
                    when "10001" => level_vec_out <= "1101111111101111101111110111001101001111101100111111111111101110";
                    when "10010" => level_vec_out <= "1101111111101111101111111111001101001111101100111111111111101110";
                    when "10011" => level_vec_out <= "1101111111101111101111111111001101001111101100111111111111101110";
                    when "10100" => level_vec_out <= "1101111111101111101111111111001101001111101110111111111111111110";
                    when "10101" => level_vec_out <= "1111111111101111101111111111001101001111101110111111111111111110";
                    when "10110" => level_vec_out <= "1111111111101111101111111111001101001111111110111111111111111110";
                    when "10111" => level_vec_out <= "1111111111101111101111111111001101001111111110111111111111111110";
                    when "11000" => level_vec_out <= "1111111111101111101111111111001101001111111110111111111111111110";
                    when "11001" => level_vec_out <= "1111111111101111111111111111001101001111111111111111111111111111";
                    when "11010" => level_vec_out <= "1111111111101111111111111111001101001111111111111111111111111111";
                    when "11011" => level_vec_out <= "1111111111111111111111111111001101001111111111111111111111111111";
                    when "11100" => level_vec_out <= "1111111111111111111111111111001101001111111111111111111111111111";
                    when "11101" => level_vec_out <= "1111111111111111111111111111011101001111111111111111111111111111";
                    when "11110" => level_vec_out <= "1111111111111111111111111111111101001111111111111111111111111111";
                    when "11111" => level_vec_out <= "1111111111111111111111111111111101111111111111111111111111111111";
                when others => null;
                end case;
            when "110" =>
                case frame_id is
                    when "00000" => level_vec_out <= "0001101111111010100000001111101110111110001110001100101110000100";
                    when "00001" => level_vec_out <= "0001101111111010100000001111101110111110001110001100101111000100";
                    when "00010" => level_vec_out <= "0001101111111010100000001111101110111110001110001100101111000100";
                    when "00011" => level_vec_out <= "0001101111111010100000001111101110111110001110001100101111000100";
                    when "00100" => level_vec_out <= "0001111111111010100000001111101110111110001110011100101111000100";
                    when "00101" => level_vec_out <= "0001111111111010110000001111101110111110001110011100101111000100";
                    when "00110" => level_vec_out <= "0001111111111010110000001111101110111110001110011110101111000100";
                    when "00111" => level_vec_out <= "0001111111111010110000001111101110111110001110011110101111000100";
                    when "01000" => level_vec_out <= "0101111111111010110000001111101110111110001110011110101111000100";
                    when "01001" => level_vec_out <= "0101111111111010110100001111101110111110001110011110101111010100";
                    when "01010" => level_vec_out <= "0101111111111010110100001111101110111110001110011110101111010100";
                    when "01011" => level_vec_out <= "0101111111111011110100101111101110111110001110011110101111010100";
                    when "01100" => level_vec_out <= "0111111111111011110100101111101110111110001110011110101111010100";
                    when "01101" => level_vec_out <= "0111111111111111110100101111101110111110001110011110101111010100";
                    when "01110" => level_vec_out <= "0111111111111111110100101111101110111110001110011110101111010100";
                    when "01111" => level_vec_out <= "0111111111111111110100101111101110111111001110011110101111010101";
                    when "10000" => level_vec_out <= "0111111111111111110100101111111110111111001110011110101111010101";
                    when "10001" => level_vec_out <= "0111111111111111110100101111111111111111001110011110101111010101";
                    when "10010" => level_vec_out <= "0111111111111111110100101111111111111111001110011110101111010101";
                    when "10011" => level_vec_out <= "0111111111111111110100101111111111111111001110011110101111010101";
                    when "10100" => level_vec_out <= "0111111111111111110101101111111111111111001110011110101111010101";
                    when "10101" => level_vec_out <= "0111111111111111110101111111111111111111001110011110101111010101";
                    when "10110" => level_vec_out <= "0111111111111111110101111111111111111111011111011110101111010101";
                    when "10111" => level_vec_out <= "0111111111111111110101111111111111111111011111111110101111010111";
                    when "11000" => level_vec_out <= "0111111111111111111101111111111111111111011111111110101111010111";
                    when "11001" => level_vec_out <= "0111111111111111111101111111111111111111011111111110101111010111";
                    when "11010" => level_vec_out <= "0111111111111111111101111111111111111111011111111110101111110111";
                    when "11011" => level_vec_out <= "0111111111111111111101111111111111111111011111111110101111110111";
                    when "11100" => level_vec_out <= "0111111111111111111111111111111111111111011111111111101111110111";
                    when "11101" => level_vec_out <= "0111111111111111111111111111111111111111011111111111111111110111";
                    when "11110" => level_vec_out <= "1111111111111111111111111111111111111111111111111111111111111111";
                    when "11111" => level_vec_out <= "1111111111111111111111111111111111111111111111111111111111111111";
                when others => null;
                end case;
            when "111" =>
                case frame_id is
                    when "00000" => level_vec_out <= "0011011010111100110101101010010100100010110100001000011110111000";
                    when "00001" => level_vec_out <= "0111011010111100110101101010010100100010110110001000011110111000";
                    when "00010" => level_vec_out <= "0111011010111100110101111011010100100010110110001000011110111000";
                    when "00011" => level_vec_out <= "0111011010111100110101111011010110100010110110001000011110111000";
                    when "00100" => level_vec_out <= "0111011010111100110101111111010110100010110110001000011110111000";
                    when "00101" => level_vec_out <= "0111011010111100110101111111010110100010110110001000011110111000";
                    when "00110" => level_vec_out <= "0111011010111100110101111111010110100010110110001000011110111000";
                    when "00111" => level_vec_out <= "0111011010111100110101111111010110100010110110001000011110111000";
                    when "01000" => level_vec_out <= "0111011010111110111101111111110110110010110110001000011110111000";
                    when "01001" => level_vec_out <= "0111011010111110111101111111110110110010110110001000011110111000";
                    when "01010" => level_vec_out <= "0111011010111110111101111111110110110010110110001100011110111000";
                    when "01011" => level_vec_out <= "0111011011111110111101111111110110110010110110001100111110111000";
                    when "01100" => level_vec_out <= "0111011011111110111101111111110110110010110110001100111110111000";
                    when "01101" => level_vec_out <= "0111011011111110111101111111110110111010110110001100111110111100";
                    when "01110" => level_vec_out <= "0111011111111110111101111111110110111010110110001100111110111100";
                    when "01111" => level_vec_out <= "0111011111111110111101111111110110111010110110001100111110111101";
                    when "10000" => level_vec_out <= "0111011111111110111101111111111111111010110110001100111110111101";
                    when "10001" => level_vec_out <= "0111011111111110111101111111111111111010110110001100111111111101";
                    when "10010" => level_vec_out <= "0111011111111110111101111111111111111010110110101101111111111101";
                    when "10011" => level_vec_out <= "0111011111111110111101111111111111111010110110101111111111111101";
                    when "10100" => level_vec_out <= "0111011111111110111101111111111111111010110110101111111111111101";
                    when "10101" => level_vec_out <= "0111011111111110111101111111111111111010110110101111111111111101";
                    when "10110" => level_vec_out <= "0111011111111110111101111111111111111010110110101111111111111101";
                    when "10111" => level_vec_out <= "0111011111111110111101111111111111111010110110101111111111111101";
                    when "11000" => level_vec_out <= "0111011111111110111101111111111111111010110110101111111111111101";
                    when "11001" => level_vec_out <= "0111011111111111111101111111111111111010110110101111111111111101";
                    when "11010" => level_vec_out <= "0111111111111111111101111111111111111011111110101111111111111101";
                    when "11011" => level_vec_out <= "0111111111111111111101111111111111111011111110101111111111111101";
                    when "11100" => level_vec_out <= "0111111111111111111101111111111111111011111110101111111111111101";
                    when "11101" => level_vec_out <= "0111111111111111111101111111111111111011111111101111111111111111";
                    when "11110" => level_vec_out <= "0111111111111111111101111111111111111111111111101111111111111111";
                    when "11111" => level_vec_out <= "0111111111111111111111111111111111111111111111111111111111111111";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;