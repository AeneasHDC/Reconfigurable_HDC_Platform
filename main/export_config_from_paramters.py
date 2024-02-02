"""
/**
 * @brief 
 *
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
 * - 
 *
 * @section LICENSE
 * This file is part of the Aeneas HyperCompute Platform.
 *
 * Licensed under the MIT License. See the LICENSE file in the project root for full license details.
 *
 * @section CHANGELOG
 * @version 0.0.0=dev - 23th August 2023
 * - Initial release
 *
 * @todo
 * - 
 * - 
 *
 * @see
 * -
 */
"""

import json

import sys
import os

if len(sys.argv) > 1 and sys.argv[1] == "called_from_run_file":
    relative_path_prefix = ""
else:
    relative_path_prefix = "../"
    
sys.path.append(relative_path_prefix + 'src/config/')

import config_py as config


input_folder_path = os.path.join(relative_path_prefix, "out//extracted_params//")
output_folder_path = os.path.join(relative_path_prefix, 'src//config//')

def generate_config_files(json_files, output_folder_path):
    cpp_header = "#ifndef EXCONFIG_CPP_H\n#define EXCONFIG_CPP_H\n"
    cpp_footer = "#endif // EXCONFIG_CPP_H\n"
    sv_header = "// SystemVerilog config file generated by script\n"
    sv_footer = "// End of config file\n"
    
    cpp_config = cpp_header
    sv_config = sv_header
    
    for json_file in json_files:
        json_file_path = os.path.join(input_folder_path, json_file)
        prefix = os.path.splitext(os.path.basename(json_file))[0].upper()

        # Read the JSON file
        with open(json_file_path, 'r') as file:
            data = json.load(file)
        
        # If data is a list, handle each dict separately
        if isinstance(data, list):
            for i, d in enumerate(data):
                _prefix = f"{prefix}_{i}"
                for key, value in d.items():
                    cpp_config += f"#define CONFIG_{_prefix}_{key.upper()} {value}\n"
                    sv_config += f"`define CONFIG_{_prefix}_{key.upper()} {value}\n"
        else:
            # Generate C++ config entries
            for key, value in data.items():
                cpp_config += f"#define CONFIG_{prefix}_{key.upper()} {value}\n"

            # Generate SystemVerilog config entries
            for key, value in data.items():
                sv_config += f"`define CONFIG_{prefix}_{key.upper()} {value}\n"

    cpp_config += cpp_footer
    sv_config += sv_footer

    # Ensure the output folder exists
    if not os.path.exists(output_folder_path):
        os.makedirs(output_folder_path)

    # Write the C++ config file
    cpp_filename = 'ex_config.hpp'
    with open(os.path.join(output_folder_path, cpp_filename), 'w') as file:
        file.write(cpp_config)

    # Write the SystemVerilog config file
    sv_filename = 'ex_config.sv'
    with open(os.path.join(output_folder_path, sv_filename), 'w') as file:
        file.write(sv_config)


if __name__ == '__main__':
  
    input_folder_path = os.path.join( relative_path_prefix, "out/extracted_params/", config.DS_NAME )
    json_files = ['BaseHVs_gen.json', 'LevelHVs_gen.json'] 
    output_folder_path = os.path.join( relative_path_prefix, 'src/config/' )
    generate_config_files( json_files, output_folder_path )