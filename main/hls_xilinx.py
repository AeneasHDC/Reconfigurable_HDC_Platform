
"""
/**
 * @file hls_xilinx_gen.py
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
 * - VIVADO v2023.1
 * - VITIS v2023.1
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

import os
import sys
import subprocess
import shutil
import re
import glob
import multiprocessing
from utils import Utils

from vitis_hls_xilinx import VitisHLSTCLGenerator
from viv_xilinx import VivadoTCLGenerator

sys.path.append('src/config/')
import config_py as config

if len(sys.argv) > 1 and sys.argv[1] == "vitis":
    run_mode = "vitis"
if len(sys.argv) > 1 and sys.argv[1] == "synth_viv":
    run_mode = "vivado"
if len(sys.argv) > 1 and sys.argv[1] == "all":
    run_mode = "all"
    
OUT_IP_PATH = "..//out//hls//ip"
EXPORT_CONFIG_OPTIONS = {
    "dir": "./exported_rtl",
    "format": "ip",
}

EXPORT_DESIGN_OPTIONS = {
    "format": "ip",
    "rtl": "verilog",  # or "vhdl" based on your preference
}

OP_CONFIG_OPTIONS = {
    "option_name": "value",
}



def read_file_list(file_name):
    with open(file_name, 'r') as f:
        lines = f.readlines()

    category = None
    files = {'src': [], 'header': [], 'tb': []}

    for line in lines:
        line = line.strip()
        if line.startswith('[') and line.endswith(']'):
            category = line[1:-1]
        elif category and line:
            files[category].append(line)

    return files


def remove_directory(dir_path):
    """Removes a directory and its contents."""
    if os.path.exists(dir_path):
        shutil.rmtree(dir_path)
        

os.chdir('main')

num_cores = multiprocessing.cpu_count()

project_name_vitis = "_hdc_hls_xilinx"
work_dir = project_name_vitis

period = 1000 / config.OP_FREQ


    
    
if run_mode == "vitis" or run_mode == "all":

    remove_directory(work_dir)
    remove_directory(OUT_IP_PATH)
    # Read file list and setup Vitis HLS TCL Generator
    file_list = read_file_list('./../src/filelist_hls_xilinx.txt')
    vitis = VitisHLSTCLGenerator()
    
    
    vitis.open_project(project_name_vitis)
    
    for file in file_list['src']:
        vitis.add_file(file)
    
    vitis.add_testbench("./../src/hw/hls_xilinx/tb/tb.cpp")
    #vitis.add_testbench("./../src/hw/hls_xilinx/tb/tb_modules.cpp")
    
    solution_name = "solution1"
    vitis.open_solution(solution_name)
    vitis.set_top('hdv_engine')
    device = config.TARGET_DEVICE
    vitis.set_part(device)
    
    vitis.create_clock(str(period), "default")
    
    vitis.run_simulation()
    vitis.csynth_design()
    
    vitis.run_cosimulation(enable_wave=True)
    
    # Configuring export and exporting RTL
    #vitis.config_export(**EXPORT_CONFIG_OPTIONS)
    #vitis.export_rtl(**EXPORT_DESIGN_OPTIONS)
    
    # If you have specific operations to configure with config_op
    #vitis.config_op("your_specific_op", **OP_CONFIG_OPTIONS)
    
    vitis.close_project()

    
    vitis.save_tcl_script(work_dir)
    
    # Run the TCL script using Vitis HLS
    tcl_script_path = os.path.join(work_dir, 'script.tcl')
    result = subprocess.run([config.VITIS_HLS_XILINX_PATH, '-f', tcl_script_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        
    if result.returncode != 0:
        print(f"Script exited with error: {result.stderr.decode()}")
    else:
        print(f"Output: {result.stdout.decode()}")
    
    
    try:
        
        base_solution_dir = os.path.join(project_name_vitis, solution_name)
        csim_report_dir = os.path.join(base_solution_dir, 'csim', 'report')
        syn_report_dir = os.path.join(base_solution_dir, 'syn', 'report')
        sim_report_dir = os.path.join(base_solution_dir, 'sim', 'report','verilog')
        solution_data_file = f"{base_solution_dir}\\{solution_name}_data.json"
        
        output_dir = '../out/hls/'
        os.makedirs(output_dir, exist_ok=True)
        
        def copy_files(source_dir: str, dest_dir: str):
            """
            Copies all files from source_dir to dest_dir.
            """
            if not os.path.exists(source_dir):
                print(f"Warning: Source directory '{source_dir}' does not exist.")
                return  # Exit the function since there's no source directory to copy from
        
            for item in os.listdir(source_dir):
                s = os.path.join(source_dir, item)
                d = os.path.join(dest_dir, item)
                if os.path.isdir(s):
                    shutil.copytree(s, d, False, None)
                else:
                    shutil.copy2(s, d)
        
        # Assuming csim_report_dir, syn_report_dir, and solution_data_file are defined
        copy_files(csim_report_dir, output_dir)
        copy_files(syn_report_dir, output_dir)
        copy_files(sim_report_dir, output_dir)
        shutil.copy(solution_data_file, output_dir)


    except subprocess.CalledProcessError as e:
        print(f"Error occurred while generating report: {e}")
    
    # Define the source path
    source_path = os.path.join(work_dir, 'solution1', 'impl', 'vhdl')
    
    # Check if the destination exists and remove if it does
    if os.path.exists(OUT_IP_PATH):
        shutil.rmtree(OUT_IP_PATH)
    
    # Now copy the directory
    shutil.copytree(source_path, OUT_IP_PATH)
    
    #remove_directory(work_dir+"/solution1/csim/build")
    

if run_mode == "vivado" or run_mode == "all":
    
    project_name_viv = "viv"
    work_dir = os.path.join(".", work_dir, project_name_viv)
    remove_directory(work_dir)
    
    vivado = VivadoTCLGenerator()

    
    os.makedirs(work_dir, exist_ok=True)
    os.chdir(work_dir)
    

    paths_res = {
        "resource": {
            "xml": "./../../../out/hls/resource_util.xml",
            "json": "./../../../out/hls/resource_util.json"
        },
        "power": {
            "xml": "./../../../out/hls/power_estimation.xml",
            "json":  "./../../../out/hls/power_estimation.json"
        }
    }

    print(paths_res["resource"]["xml"])
    vivado.create_project( project_name_viv , "./", config.TARGET_DEVICE )
    #vivado.set_property("board_part", "xilinx.com:zcu106:part0:1.0", "[current_project]")
    for vhdl_file in vivado.gather_vhdl_files( ".//..//..//"+OUT_IP_PATH ):
        vhdl_file = vhdl_file.replace("\\", "//")
        vivado.add_files(vhdl_file)
        
    vivado.create_clock_xdc("./"+"const.xdc", period, "ap_clk", period)
    vivado.set_top()
    vivado.launch_runs("synth_1 -jobs " + str(num_cores))
    vivado.wait_on_run("synth_1")
    vivado.open_run("synth_1")
    
    vivado.report_utilization(paths_res["resource"]["xml"])
    vivado.report_power(paths_res["power"]["xml"])
    vivado.close_project()
    vivado.save_tcl_script("./")

    tcl_script_path = os.path.join(".", 'script.tcl')
    
    result = subprocess.run([config.VIVADO_XILINX_PATH, '-mode', 'batch', '-source', tcl_script_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    
    if result.returncode != 0:
        print(f"Script exited with error: {result.stderr.decode()}")
    else:
        print(f"Output: {result.stdout.decode()}")
        
    for key, path_dict in paths_res.items():
        Utils.convert_xml_to_json(path_dict["xml"], path_dict["json"])
        
    work_dir = os.path.join(".", work_dir, project_name_viv);
    remove_directory(work_dir)        