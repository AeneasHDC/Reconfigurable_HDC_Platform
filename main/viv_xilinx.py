
import os
import sys
import subprocess
import shutil
import re
import glob
import multiprocessing

sys.path.append('src/config/')
import config_py as config            


class VivadoTCLGenerator:
    def __init__(self):
        self.tcl_script = ''

    def add_tcl_command(self, tcl_commands):
        self.tcl_script += tcl_commands + '\n'
    
    def gather_vhdl_files(self, directory):
        vhdl_files = glob.glob(directory + "/*.vhd")
        for subdir in [d for d in glob.glob(directory + "/*") if os.path.isdir(d)]:
            vhdl_files.extend(self.gather_vhdl_files(subdir))
        return vhdl_files

    def create_project(self, project_name, project_dir, part):
        self.add_tcl_command(f"create_project {project_name} {project_dir} -part {part}")
        
    def set_top(self):
        self.add_tcl_command(f"set_property top hdv_engine [current_fileset]")
        
    def add_files(self, file):
        self.add_tcl_command(f"add_files {file}")
        
    def add_files_to_fileset(self, fileset, file):
        self.add_tcl_command(f"add_files -fileset {fileset} {file}")
        
    def create_clock_xdc(self, xdc_filename, period, name, waveform):
        with open(xdc_filename, "w") as xdc_file:
            xdc_file.write(f"create_clock -period {period} -name {name} -waveform {{0.000 {waveform/2}}}")
        self.add_files_to_fileset("constrs_1", xdc_filename)
        
    def add_files(self, file):
       self.add_tcl_command(f"add_files {file}")
       
    def reset_launch(self, run_name):
        self.add_tcl_command(f"reset_run {run_name}")
        
        
    def launch_runs(self, run_name):
        self.add_tcl_command(f"launch_runs {run_name}")
        
    def wait_on_run(self, run_name):
        self.add_tcl_command(f"wait_on_run {run_name}")
        
    def open_run(self, run_name):
        self.add_tcl_command(f"open_run {run_name}")
        
    def report_utilization(self, output_file):
        self.add_tcl_command(f"report_utilization -file {output_file} -format xml")
        
    def report_power(self, output_file):
        self.add_tcl_command(f"report_power -file {output_file} -format xml")
        
    def close_project(self):
        self.add_tcl_command("close_project")

    def save_tcl_script(self, work_dir, filename='script.tcl'):
        os.makedirs(work_dir, exist_ok=True)
        with open(os.path.join(work_dir, filename), 'w') as f:
            f.write(self.tcl_script)