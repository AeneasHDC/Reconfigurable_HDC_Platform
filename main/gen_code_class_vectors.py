"""
/**
 * @file class_hvec_gen_hdl.py
 * @brief This script generates HDL code for generating high-dimensional class vectors.
 * It is a novel method; for more information, please refer to our paper.
 *
 *
 * @author Marco Angioli and Saeid Jamili
 * @email marco.angioli@uniroma1.it and saeid.jamili@uniroma1.it
 * @note Author names are listed in alphabetical order.
 * @date Created on: 12th August 2023
 * @date Last updated on: 5th May 2024
 * @institution Sapienza University of Rome
 *
 * @section LICENSE
    Copyright 2024 Sapienza University of Rome

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    Authors: Marco Angioli & Saeid Jamili

 * @section CHANGELOG
 * @version 1.0.2
 * @date May 2024
 */
"""

import pandas as pd
import numpy as np
import math

import sys
import os

if len(sys.argv) > 1 and sys.argv[1] == "called_from_run_file":
    relative_path_prefix = ""
else:
    relative_path_prefix = "../"
    
sys.path.append(relative_path_prefix + 'src/config/')

import config_py as config




TOP_COMMENT = """
/**
 * @file class_hvec_gen_hdl.hpp
 * @brief This script generates HDL code for generating high-dimensional class vectors.
 * It is a novel method; for more information, please refer to our paper.
 *
 * @author Saeid Jamili and Marco Angioli
 * @note Author names are listed in alphabetical order.
 * @email <saeid.jamili@uniroma1.it>
 * @email <marco.angioli@uniroma1.it>
 *
 * @contributors
 *
 * @date Created: 24th July 2023
 * @date Last Updated: 23th August 2023
 *
 * @version 1.0.0
 *
 * @institute Sapienza University of Rome
 * @cite https://doi.org/10.xxxx/yyyyy
 *
 * @section DEPENDENCIES
 * - Dependency1: Description or version details.
 * - Dependency2: Description or version details.
 *
 * @section LICENSE
 * This file is part of the Aeneas HyperCompute Platform.
 *
 * Licensed under the MIT License. See the LICENSE file in the project root for full license details.
 *
 * @section CHANGELOG
 * @version 1.0.0-dev - 23th August 2023
 * - Initial release
 *
 * @todo
 * - Complete level vector generator function
 * - Add training
 *
 * @see
 * -
 * -
 * -
 *
 */
"""
# Function to generate HDL code for HLS (C++/HLS code)
def generate_hls_code(file_name, DI_PARALLEL_W_BITS):
    hls_code = []

    # Add the top comment to the code
    hls_code.extend(TOP_COMMENT.split('\n'))

    hls_code.append("#ifndef CLASS_VEC_GEN_H")
    hls_code.append("#define CLASS_VEC_GEN_H")
    hls_code.append("#include <ap_int.h>")

    data_rows = []
    with open(file_name, 'r') as f:
        for line in f:
            bits = ''.join(map(lambda x: '1' if float(x.strip()) == 1.0 else '0', line.split(',')))
            data_rows.append(bits)

    frame_id_width = math.ceil(math.log2(len(data_rows[0]) // DI_PARALLEL_W_BITS))
    frame_index_width = math.ceil(math.log2(len(data_rows)))

    hls_code.append(f"static void class_vec_gen(ap_uint<{DI_PARALLEL_W_BITS}> &class_vec_out, ap_uint<{frame_id_width}> frame_id, ap_uint<{frame_index_width}> frame_index) {{")
    hls_code.append("    // Update this function to match your requirements")
    hls_code.append("    switch(frame_id) {")

    for frame_id in range(0, len(data_rows[0]) // DI_PARALLEL_W_BITS):
        start_index = frame_id * DI_PARALLEL_W_BITS
        end_index = start_index + DI_PARALLEL_W_BITS
        hls_code.append(f"        case {frame_id}:")
        hls_code.append(f"            switch(frame_index) {{")
        for i, bits in enumerate(data_rows):
            if len(bits) >= end_index:
                hls_code.append(f"                case {i}:")
                hls_code.append(f"                    class_vec_out = 0b{bits[start_index : end_index]};")
                hls_code.append("                    break;")
            else:
                print(f"Skipping frame_index {i}, frame_id {frame_id} due to insufficient data. Length: {len(bits)}")
        hls_code.append("            }")
        hls_code.append("            break;")

    hls_code.append("    }")
    hls_code.append("}")
    hls_code.append("#endif")
    return "\n".join(hls_code)

# Function to generate HDL code for SystemVerilog
def generate_sv_code(file_name, DI_PARALLEL_W_BITS):
    sv_code = []
    sv_code.append(TOP_COMMENT)
    data = pd.read_csv(file_name, header=None).values
    n_rows, n_cols = data.shape
    
    frame_id_bits = math.ceil(math.log2(n_cols // DI_PARALLEL_W_BITS))
    frame_index_bits = math.ceil(math.log2(n_rows))
    
    sv_code.append("module class_hvec_gen #(parameter int DI_PARALLEL_W_BITS = {}) (".format(DI_PARALLEL_W_BITS))
    sv_code.append("  input logic [{}:0] frame_id,".format(frame_id_bits - 1))
    sv_code.append("  input logic [{}:0] frame_index,".format(frame_index_bits - 1))
    sv_code.append("  output logic [DI_PARALLEL_W_BITS-1:0] class_vec_out")
    sv_code.append(");")
    sv_code.append("  always_comb begin")
    sv_code.append("    case (frame_id)")
    for i in range(0, n_cols, DI_PARALLEL_W_BITS):
        sv_code.append("      {}:".format(i // DI_PARALLEL_W_BITS))
        sv_code.append("        case (frame_index)")
        for j in range(n_rows):
            sv_code.append("          {}:".format(j))
            row = data[j]
            row_bin = "".join(map(lambda x: "{:1.0f}".format(x), row[i:i+DI_PARALLEL_W_BITS]))
            sv_code.append("            class_vec_out = {}'b{};".format(DI_PARALLEL_W_BITS, row_bin))
        sv_code.append("        endcase")
    sv_code.append("    endcase")
    sv_code.append("  end")
    sv_code.append("endmodule")
    return "\n".join(sv_code)

# Function to generate HDL code for Verilog
def generate_verilog_code(file_name, DI_PARALLEL_W_BITS):
    verilog_code = []

    # Add the top comment to the code
    verilog_code.extend(TOP_COMMENT.split('\n'))

    data_rows = []
    with open(file_name, 'r') as f:
        for line in f:
            bits = ''.join(map(lambda x: '1' if float(x.strip()) == 1.0 else '0', line.split(',')))
            data_rows.append(bits)

    frame_id_width = math.ceil(math.log2(len(data_rows[0]) // DI_PARALLEL_W_BITS))
    frame_index_width = math.ceil(math.log2(len(data_rows)))

    verilog_code.append(f"module class_vec_gen (")
    verilog_code.append(f"    output reg [{DI_PARALLEL_W_BITS-1}:0] class_vec_out,")
    verilog_code.append(f"    input [{frame_id_width-1}:0] frame_id,")
    verilog_code.append(f"    input [{frame_index_width-1}:0] frame_index")
    verilog_code.append(");")

    verilog_code.append(f"    always @(*) begin")
    verilog_code.append("        // Update this function to match your requirements")
    verilog_code.append(f"        case (frame_id)")
    
    for frame_id in range(0, len(data_rows[0]) // DI_PARALLEL_W_BITS):
        start_index = frame_id * DI_PARALLEL_W_BITS
        end_index = start_index + DI_PARALLEL_W_BITS
        verilog_code.append(f"            {frame_id}: begin")
        verilog_code.append(f"                case (frame_index)")
        for i, bits in enumerate(data_rows):
            if len(bits) >= end_index:
                verilog_code.append(f"                    {i}: class_vec_out = {DI_PARALLEL_W_BITS}'b{bits[start_index : end_index]};")
            else:
                print(f"Skipping frame_index {i}, frame_id {frame_id} due to insufficient data. Length: {len(bits)}")
        verilog_code.append("                endcase")
        verilog_code.append("            end")
    
    verilog_code.append("        endcase")
    verilog_code.append("    end")
    verilog_code.append("endmodule")
    return "\n".join(verilog_code)

# Function to generate VHDL code
def generate_vhdl_code(file_name, DI_PARALLEL_W_BITS):
    vhdl_code = []

    # Modify the top comment for VHDL
    vhdl_comment = TOP_COMMENT.replace("/*", "--").replace("*/", "--").replace("**", "--").replace("*", "--")
    vhdl_code.extend(vhdl_comment.split('\n'))

    data_rows = []
    with open(file_name, 'r') as f:
        for line in f:
            bits = ''.join(map(lambda x: '1' if float(x.strip()) == 1.0 else '0', line.split(',')))
            data_rows.append(bits)

    frame_id_width = math.ceil(math.log2(len(data_rows[0]) // DI_PARALLEL_W_BITS))
    frame_index_width = math.ceil(math.log2(len(data_rows)))

    vhdl_code.append(f"library IEEE;")
    vhdl_code.append(f"use IEEE.STD_LOGIC_1164.ALL;")
    vhdl_code.append(f"use IEEE.STD_LOGIC_ARITH.ALL;")
    vhdl_code.append(f"use IEEE.STD_LOGIC_UNSIGNED.ALL;")
    vhdl_code.append(f"")
    vhdl_code.append(f"entity class_vec_gen is")
    vhdl_code.append(f"    Port ( class_vec_out : out  STD_LOGIC_VECTOR ({DI_PARALLEL_W_BITS-1} downto 0);")
    vhdl_code.append(f"           frame_id : in  STD_LOGIC_VECTOR ({frame_id_width-1} downto 0);")
    vhdl_code.append(f"           frame_index : in  STD_LOGIC_VECTOR ({frame_index_width-1} downto 0));")
    vhdl_code.append(f"end class_vec_gen;")
    vhdl_code.append(f"")
    vhdl_code.append(f"architecture Behavioral of class_vec_gen is")
    vhdl_code.append(f"begin")
    vhdl_code.append(f"    process (frame_id, frame_index)")
    vhdl_code.append(f"    begin")
    vhdl_code.append(f"        -- Update this function to match your requirements")
    vhdl_code.append(f"        case frame_id is")
    
    for frame_id in range(0, len(data_rows[0]) // DI_PARALLEL_W_BITS):
        start_index = frame_id * DI_PARALLEL_W_BITS
        end_index = start_index + DI_PARALLEL_W_BITS
        vhdl_code.append(f"            when \"{format(frame_id, f'0{frame_id_width}b')}\" =>")
        vhdl_code.append(f"                case frame_index is")
        for i, bits in enumerate(data_rows):
            if len(bits) >= end_index:
                vhdl_code.append(f"                    when \"{format(i, f'0{frame_index_width}b')}\" => class_vec_out <= \"{bits[start_index : end_index]}\";")
            else:
                print(f"Skipping frame_index {i}, frame_id {frame_id} due to insufficient data. Length: {len(bits)}")
        vhdl_code.append("                when others => null;")
        vhdl_code.append("                end case;")
    
    vhdl_code.append("            when others => null;")
    vhdl_code.append("        end case;")
    vhdl_code.append("    end process;")
    vhdl_code.append("end Behavioral;")
    return "\n".join(vhdl_code)





FILE_NAME = relative_path_prefix + "out//extracted_params//"+config.DS_NAME+"//ClassHVs.csv"
# Read the CSV file
df = pd.read_csv(FILE_NAME, header=None)
data = df.values.astype(int)

OUTPUT_PATH = relative_path_prefix + "out//mem_data//hdl_functions//"
# Write the HDL code to separate files
with open(OUTPUT_PATH+"class_hvec_gen_hdl.hpp", "w") as f:
    f.write(generate_hls_code(FILE_NAME, config.CV_IN_DATA_W_BITS))
# Write the Verilog code to a separate file
with open(OUTPUT_PATH+"class_hvec_gen_hdl.v", "w") as f:
    f.write(generate_verilog_code(FILE_NAME, config.CV_IN_DATA_W_BITS))
    # Write the VHDL code to a separate file
with open(OUTPUT_PATH+"class_hvec_gen_hdl.vhdl", "w") as f:
    f.write(generate_vhdl_code(FILE_NAME, config.CV_IN_DATA_W_BITS))
# Write the SystemVerilog code to a separate file
with open(OUTPUT_PATH+"class_hvec_gen_hdl.sv", "w") as f:
    f.write(generate_sv_code(FILE_NAME, config.CV_IN_DATA_W_BITS))