"""
/**
 * @brief 
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
import os
import sys
from datetime import datetime
sys.path.append('src/config/')
import config_py

# Define the C data types and their sizes in bits
c_data_types = {
    'uint64_t': 64,
    'uint32_t': 32,
    'uint16_t': 16,
    'uint8_t': 8
}

# Function to convert data according to data type
def convert_data(data):
    if config_py.HD_DATA_TYPE == 'BIPOLAR' and data == -1:
        return 0
    return data

# Function to pack values into a single integer of given size
def pack_values(values, size):
    packed = 0
    for i, value in enumerate(values):
        packed |= value << (i * size)
    return packed

# Function to generate the file header comment
def generate_header(filename, brief):
    header = f"""
/**
 * @file {filename}
 * @brief {brief}
 * @author Saeid Jamili, Marco Angioli
 * @email saeid.jamili@uniroma1.it, marco.angioli@uniroma1.it
 * @date Created on: 24th July 2023
 * @date Last updated on: {datetime.now().strftime("%dth %B %Y, %H:%M:%S")}
 * @institution Sapienza University of Rome
 *
 * @ref :
 * https://doi.org/10.xxxx/yyyyy
 */
"""
    return header

# Names of CSV files
csv_files = ['baseHVs.csv', 'classHVs.csv', 'levelHVs.csv']


for csv_file in csv_files:
    # Load the data
    df = pd.read_csv("out//extracted_params//"+csv_file)

    # Process the data
    df = df.applymap(convert_data)

    # Convert DataFrame to 1D numpy array
    data = df.values.flatten()

    # Generate C header files
    for c_type, bits in c_data_types.items():
        num_values = bits // config_py.HD_DATA_W_BITS  # How many data values can fit in c_type
        output_filename = f'out//mem_data//hd_mem_{csv_file[:-4]}_{c_type}.h'
        with open(output_filename, 'w') as f:
            f.write(generate_header(output_filename, f"C memory for {csv_file}"))
            f.write(f'#ifndef HD_MEM_{csv_file[:-4].upper()}_{c_type.upper()}_H\n')
            f.write(f'#define HD_MEM_{csv_file[:-4].upper()}_{c_type.upper()}_H\n\n')
            f.write(f'{c_type} data[] = {{\n')
            for i in range(0, len(data), num_values * 8):
                line = ', '.join([f'0x{pack_values(data[j:j+num_values], config_py.HD_DATA_W_BITS):016x}' for j in range(i, min(i+num_values*8, len(data)), num_values)])
                f.write(f'    {line},\n')
            f.write('};\n\n#endif /* HD_MEM_{csv_file[:-4].upper()}_{c_type.upper()}_H */')

    # Generate HLS memory file
    output_filename = f'out//mem_data//hd_mem_{csv_file[:-4]}_HLS.txt'
    with open(output_filename, 'w') as f:
        f.write(generate_header(output_filename, f"HLS memory for {csv_file}"))
        f.write(f'#ifndef HD_MEM_{csv_file[:-4].upper()}_HLS_H\n')
        f.write(f'#define HD_MEM_{csv_file[:-4].upper()}_HLS_H\n\n')
        f.write(f'ap_uint<{config_py.HD_DATA_W_BITS}> data[] = {{\n')
        for i in range(0, len(data), 8):
            line = ', '.join((str(value) if config_py.HD_DATA_W_BITS < 3 else f'0x{value:0{config_py.HD_DATA_W_BITS // 4}x}') for value in data[i:i+8])
            f.write(f'    {line},\n')
        f.write('};\n\n')
        f.write(f'#endif /* HD_MEM_{csv_file[:-4].upper()}_HLS_H */')

    # Generate Xilinx memory file
    num_values = 32 // config_py.HD_DATA_W_BITS  # How many data values can fit in 32 bits
    output_filename = f'out//mem_data//hd_mem_{csv_file[:-4]}_Xilinx.coe'
    with open(output_filename, 'w') as f:
        f.write(generate_header(output_filename, f"Xilinx memory for {csv_file}"))
        f.write('memory_initialization_radix=16;\n')
        f.write('memory_initialization_vector=\n')
        for i in range(0, len(data), num_values):
            f.write(f'    0x{pack_values(data[i:i+num_values], config_py.HD_DATA_W_BITS):08x},\n')
        f.write(';')
