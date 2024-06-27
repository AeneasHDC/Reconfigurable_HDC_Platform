
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
                    when "00" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "01" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "10" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                when others => null;
                end case;
            when "001" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000000000000010000000000000000000000000000000000000000000000000";
                    when "01" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "10" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                when others => null;
                end case;
            when "010" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "01" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "10" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                when others => null;
                end case;
            when "011" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "01" => class_vec_out <= "0000000000000000000000000000000000000000010000000000000000000000";
                    when "10" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                when others => null;
                end case;
            when "100" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "01" => class_vec_out <= "0000000000000000000000100000000000000000000000000000000000000000";
                    when "10" => class_vec_out <= "0000010000000000000000000000000000000000000000000000001000000000";
                when others => null;
                end case;
            when "101" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "01" => class_vec_out <= "0000000000000000000000000000000000000000000001000000000000100000";
                    when "10" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                when others => null;
                end case;
            when "110" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "01" => class_vec_out <= "0000000000000000000000000000000000000000001000000000000000000000";
                    when "10" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                when others => null;
                end case;
            when "111" =>
                case frame_index is
                    when "00" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "01" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                    when "10" => class_vec_out <= "0000000000000000000000000000000000000000000000000000000000000000";
                when others => null;
                end case;
            when others => null;
        end case;
    end process;
end Behavioral;