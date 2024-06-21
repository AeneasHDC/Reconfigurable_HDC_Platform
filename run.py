"""
/**
 * @file model.py
 @brief This interactive script offers a centralized hub for automating various project tasks ranging from configuration generation, model execution, feature extraction, and report generation to interacting with external tools like the HLS Xilinx Generator. It also facilitates project setup through options like generating the project tree and installing necessary requirements.
 * @author Marco Angioli and Saeid Jamili
 * @email marco.angioli@uniroma1.it and saeid.jamili@uniroma1.it
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

import subprocess
import os
import sys
import shutil
import subprocess
import time
import webbrowser
import signal
import datetime
from PyQt5.QtWidgets import QApplication
from PyQt5.QtWebEngineWidgets import QWebEngineView
from PyQt5.QtCore import QUrl, Qt
from PyQt5.QtGui import QIcon



sys.path.append('src/config/')
import config_py as config


def change_configuration():
    try:
        result = subprocess.run(["python", "main//update_config_ui.py"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print(result.stdout)
        app = QApplication([])
        view = QWebEngineView()
        view.setWindowTitle("Configuration")
        view.setWindowIcon(QIcon('./doc/.img/ico/conf_16.png'))  
        view.load(QUrl("http://localhost:3000/usr_config.html"))
        view.showMaximized()
        app.exec_()
        result = subprocess.run(["python", "main//update_config_ui.py"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while updating configuration gui: {e}")
        print("Error Output:")
        print(e.stderr)
    
def generate_configurations():
    print("Generating configurations...")
    try:
        result = subprocess.run(["python", "main//config_gen.py"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Output:")
        print(result.stdout)
        print("Configurations generated successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while generating configurations: {e}")
        print("Error Output:")
        print(e.stderr)

def run_model():
    """
    Run the model script based on the specified language in config.MODEL_LANG.
    """
    print(f"Running model...")
    try:
        if config.MODEL_LANG == config.PYTHON:
            cmd = ["python", "src/model/python/model.py", "called_from_run_file"]
        elif config.MODEL_LANG == "MATLAB":
            cmd = ["matlab", "-batch", "run('src/model/matlab/model.m')"]
        elif config.MODEL_LANG == config.CPP:
            os.system("g++ -o src/model/cpp/model src/model/cpp/model.cpp")
            cmd = ["./src/model/cpp/model"]
        elif config.MODEL_LANG == config.C:
            os.system("gcc -o src/model/c/model src/model/c/model.c")
            cmd = ["./src/model/c/model"]
        elif config.MODEL_LANG == config.RUST:
            os.system("rustc -o src/model/rust/model src/model/rust/model.rs")
            cmd = ["./src/model/rust/model"]
        else:
            raise ValueError(f"Unsupported model language")

        result = subprocess.run(cmd, check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print(f"model executed successfully!")
        print("Output:")
        print(result.stdout)

    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running {config.MODEL_LANG} model: {e}")
        print("Error Output:")
        print(e.stderr)
    except ValueError as e:
        print(e)

def run_extract_feature():
    """
    Run the extract_feature script.
    """
    print("Running extract_feature...")
    try:
        result = subprocess.run(["python", "main//extract_feature.py", "called_from_run_file"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Output features generated successfully!")
        print("Output:")
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running extract_feature: {e}")
        print("Error Output:")
        print(e.stderr)
        
def run_extracted_params():
    """
    Run the extracted_params script.
    """
    print("Running export_config_from_paramters...")
    try:
        result = subprocess.run(["python", "main//export_config_from_paramters.py", "called_from_run_file"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Output paramter extracted successfully!")
        print("Output:")
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running extracted_params: {e}")
        print("Error Output:")
        print(e.stderr)

def run_class_hv_gen_hdl():
    """
    Run the extracted_params script.
    """
    print("Running generate class high-dimentional vector by using hdl function...")
    try:
        result = subprocess.run(["python", "main//gen_code_class_vectors.py", "called_from_run_file"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Output generated successfully!")
        print("Output:")
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running run_class_hv_gen_hdl: {e}")
        print("Error Output:")
        print(e.stderr)
        
def run_level_hv_gen_hdl():
    """
    Run the extracted_params script.
    """
    print("Running generate level high-dimentional vector by using hdl function...")
    try:
        result = subprocess.run(["python", "main//gen_code_level_vectors.py", "called_from_run_file"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Output generated successfully!")
        print("Output:")
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running run_level_hv_gen_hdl: {e}")
        print("Error Output:")
        print(e.stderr)
        
def generate_mem_files():
    print("Generating memory parameters...")
    try:
        result = subprocess.run(["python", "main//dmem_gen.py"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Python model executed successfully!")
        print("Output:")
        print(result.stdout)
        print("Memory parameters generated successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while generating memory parameters: {e}")
        print("Error Output:")
        print(e.stderr)

def run_hls_xilinx_gen():
    """
    Run the hls_xilinx_gen.py script.
    """
    print("Running HLS Xilinx Generator...")
    try:
        result = subprocess.run(["python", "main//hls_xilinx_gen.py", "vitis"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("HLS Xilinx Generator executed successfully!")
        print("Output:")
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running HLS Xilinx Generator: {e}")
        print("Error Output:")
        print(e.stderr)
        
def run_hls_xilinx_gen_viv():
    """
    Run the hls_xilinx_gen.py script.
    """
    try:
        result = subprocess.run(["python", "main//hls_xilinx_gen.py", "vivado"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("HLS Xilinx Generator executed successfully!")
        print("Output:")
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running HLS Xilinx Generator: {e}")
        print("Error Output:")
        print(e.stderr)
        

                 
def generate_report(project_info, summary):
    """
    Run the report generation script.
    """
    print("Generating report...")
    try:
        result = subprocess.run(["python", "./main/rep_dgen.py", str(project_info), str(summary)], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Report generated successfully!")
        print("Output:")
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while generating report: {e}")
        print("Error Output:")
        print(e.stderr)

def generate_project_tree():
    print("Generating project tree...")
    try:
        result = subprocess.run(["python", "path/to/project_tree_generator.py"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Output:")
        print(result.stdout)
        print("Project tree generated successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while generating project tree: {e}")
        print("Error Output:")
        print(e.stderr)

def install_requirements():
    print("Installing requirements...")
    try:
        result = subprocess.run(["pip", "install", "-r", "requirements.txt"], check=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print("Output:")
        print(result.stdout)
        print("Requirements installed successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while installing requirements: {e}")
        print("Error Output:")
        print(e.stderr)



def main():
    project_name = ''
    project_id = ''
    project_created_datetime =''
    
    print("Select the task you want to run:")
    print("1: Create a project")
    print("2: Change configurations")
    print("3: Generate configurations")
    print("4: Run model")
    print("5: Extract feature")
    print("6: Extracted params")
    print("7: Extracted hdl function class HV")
    print("8: Extracted hdl function level HV")
    print("9: Generate memory files")
    print("10: Generate report") #need to modify
    print("11: Run HLS Xilinx Generator")
    print("12: Run Synthesis with vivado")
    print("13: Run all")
    
    print("20: Generate project tree")
    print("21: Install requirements")
    
    

    
    
    user_choice = input("Enter the number of the task you want to run: ")
    
    if user_choice == '1':
        
        project_name = input("Enter the name of the project: ")
        project_id = input("Enter the project ID: ")
        
        current_datetime = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
        # Ask 
        answer = input("Do you want to change configuration? (yes/y or no/n): ").lower()
        if answer == "yes" or answer == "y":
            change_configuration()
            
        generate_configurations()
        
        run_model()
        
        run_extract_feature()  
        run_extracted_params()  
        run_level_hv_gen_hdl()  
        run_class_hv_gen_hdl()
        generate_mem_files()
        
       # Prompt 
        answer = input("Do you want to run hls simulation? (yes/y or no/n): ").strip().lower()
        if answer in ["yes", "y"]:
            run_hls_xilinx_gen()
    
        # Prompt 
        answer = input("Do you want to run synthesis for resource usage and power report? (yes/y or no/n): ").strip().lower()
        if answer in ["yes", "y"]:
            run_hls_xilinx_gen_viv()
            
            
            
        generate_report('test2_1_202302_123021','test for')


    elif user_choice == '2':
        change_configuration()
    elif user_choice == '3':
        generate_configurations()
    elif user_choice == '4':
        run_model()
    elif user_choice == '5':
        run_extract_feature()  
    elif user_choice == '6':
        run_extracted_params()  
    elif user_choice == '7':
        run_class_hv_gen_hdl()  
    elif user_choice == '8':
        run_level_hv_gen_hdl()  
    elif user_choice == '9':
        generate_mem_files()
    elif user_choice == '10':
        generate_report('test2_1_202302_123021','test for')
    elif user_choice == '11':
        run_hls_xilinx_gen()
    elif user_choice == '12':
        run_hls_xilinx_gen_viv()
            
    elif user_choice == '13':
        generate_configurations()
        run_model()
        run_extract_feature()  
        run_extracted_params()  
        run_class_hv_gen_hdl()  
        run_level_hv_gen_hdl()
        run_hls_xilinx_gen()
        
    elif user_choice == '20':
        install_requirements()
    elif user_choice == '21':
        generate_project_tree()
    else:
        print("Invalid choice.")
        
if __name__ == "__main__":
    main()