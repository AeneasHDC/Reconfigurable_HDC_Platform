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
 * @version 1.0.0 - 23th August 2023
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

def convert_config(input_file):
    lang_map = {
        'c': 'config_c.h',
        'cpp': 'config_cpp.hpp',
        'python': 'config_py.py',
        'matlab': 'config_matlab.m',
        'rust': 'config_rust.rs',
        'systemverilog': 'config_sv.sv',
        'vhdl': 'config_vhdl.vhd',
        'verilog': 'config_v.v'
    }

    format_strs = {
        'c': '#define {} {}\n',
        'cpp': '#define {} {}\n',
        'python': '{} = {}\n',
        'matlab': '{} = {};\n',
        'rust': 'pub const {}: &str = {};\n',
        'systemverilog': '`define {} {}\n',
        'vhdl': 'constant {} : string := {}\n',
        'verilog': '`define {} {}\n'
    }

    headers = {
        'c': '#ifndef _CONFIG_C_H_\n#define _CONFIG_C_H_\n',
        'cpp': '#ifndef CONFIG_CPP_H\n#define CONFIG_CPP_H\n',
        'python': '""" Configuration file for Python """\n',
        'matlab': '% Configuration file for MATLAB\n',
        'rust': '// Configuration file for Rust\n',
        'systemverilog': '// Configuration file for SystemVerilog\n',
        'vhdl': '-- Configuration file for VHDL\n',
        'verilog': '// Configuration file for Verilog\n'
    }

    footers = {
        'c': '#endif // _CONFIG_C_H_\n',
        'cpp': '#endif // _CONFIG_CPP_H_\n',
        'python': '',
        'matlab': '',
        'rust': '',
        'systemverilog': '',
        'vhdl': '',
        'verilog': ''
    }

    var_values = {}

    with open(input_file, 'r') as config_file:
        config_data = json.load(config_file)

    def extract_from_dict(d):
        for k, v in d.items():
            if isinstance(v, dict):
                if "options" in v:
                    for inner_k, inner_v in v["options"].items():
                        var_values[inner_k] = inner_v
                        
                if "selected" in v:
                    selected_key = [key for key, value in v["options"].items() if value == v["options"][v["selected"]]][0]
                    var_values[k] = selected_key
                else:
                    extract_from_dict(v)
            else:
                var_values[k] = v

    extract_from_dict(config_data)

    # generate the files
    for lang, filename in lang_map.items():
        with open("src//config//" + filename, 'w') as output_file:
            output_file.write(headers[lang])

            for key, value in var_values.items():
                if isinstance(value, str) and not value.isdigit() and not key == value and not value in var_values:
                    value = f'"{value}"'
                line_ending = ';' if lang in ['matlab', 'vhdl', 'verilog', 'systemverilog', 'python'] else ''
                value_str = f'{value}{line_ending}'
                output_file.write(format_strs[lang].format(key, value_str))

            output_file.write(footers[lang])

if __name__ == '__main__':
    convert_config('usr_config//config.json')



