
import os
import sys
import subprocess
import shutil
import re
import glob
import multiprocessing

sys.path.append('src/config/')
import config_py as config


class VitisHLSTCLGenerator:
    def __init__(self):
        self.tcl_script = ''

    def add_tcl_command(self, tcl_commands):
        self.tcl_script += tcl_commands + '\n'

    def open_project(self, project_name):
        self.add_tcl_command(f"open_project {project_name}")

    def set_top(self, top_function):
        self.add_tcl_command(f"set_top {top_function}")

    def add_file(self, file_path):
        self.add_tcl_command(f"add_files {file_path}")

    def add_testbench(self, tb_file_path):
        self.add_tcl_command(f"add_files -tb {tb_file_path}")

    def open_solution(self, solution_name):
        self.add_tcl_command(f'open_solution "{solution_name}" -flow_target vivado')

    def set_part(self, part):
        self.add_tcl_command(f"set_part {part}")

    def create_clock(self, period, name):
        self.add_tcl_command(f"create_clock -period {period} -name {name}")

    def csynth_design(self):
        
        self.add_tcl_command("csynth_design")

    def run_simulation(self):
        self.add_tcl_command("set fileId [open \"../src/config/hls_configs.hpp\" w]")
        self.add_tcl_command("close $fileId")
        self.add_tcl_command("csim_design")

    def run_cosimulation(self, enable_wave):
        self.add_tcl_command("set fileId [open \"../src/config/hls_configs.hpp\" a]")
        self.add_tcl_command("puts $fileId \"#ifndef COSIM\"")
        self.add_tcl_command("puts $fileId \"#define COSIM\"")
        self.add_tcl_command("puts $fileId \"#endif\"")
        self.add_tcl_command("close $fileId")
        command = "cosim_design"
        if enable_wave:
            command += " -rtl verilog -trace_level all" 
        self.add_tcl_command(command)

    def config_op(self, op, **kwargs):
        cmd = f"config_op {op}"
        for key, value in kwargs.items():
            cmd += f" -{key} {value}"
        self.add_tcl_command(cmd)
        
    def config_export(self, **kwargs):
        cmd = "config_export"
        for key, value in kwargs.items():
            cmd += f" -{key} {value}"
        self.add_tcl_command(cmd)

    def export_rtl(self, **kwargs):
        cmd = "export_design"
        for key, value in kwargs.items():
            cmd += f" -{key} {value}"
        self.add_tcl_command(cmd)


        
    def close_project(self):
        self.add_tcl_command("close_project")
        self.add_tcl_command("exit")

    def save_tcl_script(self, work_dir, filename='script.tcl'):
        os.makedirs(work_dir, exist_ok=True)
        with open(os.path.join(work_dir, filename), 'w') as f:
            f.write(self.tcl_script)