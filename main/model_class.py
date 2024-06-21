"""
/**
 * @file model_class.py
 * @brief This file contains the implementation of the Model class.
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
import sys
import json
import subprocess
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from pathlib import Path
import time

from vectorutils import VectorUtils 
from visualizer import Visualizer


# Import the config
sys.path.append('src/config/')
import config_py as config



class Model_class:

    def __init__(self):
        self.compiler_path = None

    def info(self):
        model_lang = config.MODEL_LANG
        return f"Selected model language: {model_lang}"

    def set_compiler_path(self, path):
        self.compiler_path = Path(path)

    def get_eval(self, filename=None):
        if filename is None:
            ds_name = config.DS_NAME
            filename = Path(f"./out/model_eva/{ds_name}/model_report.json")
        with filename.open('r') as f:
            eval_data = json.load(f)
        return eval_data

    def _load_vector_from_csv(self, file_path):
        return pd.read_csv(file_path).values.tolist()

    def _get_vector(self, file=None, name=None):
        if file is None:
            ds_name = config.DS_NAME
            file = Path(f"./out/extracted_params/{ds_name}/{name}.csv")
        return self._load_vector_from_csv(file)

    def get_base_vector(self, file=None):
        return self._get_vector(file, 'BaseHVs')

    def get_level_vector(self, file=None):
        return self._get_vector(file, 'LevelHVs')

    def get_class_vector(self, file=None):
        return self._get_vector(file, 'ClassHVs')


    def run(self):
        model_lang = config.MODEL_LANG
        
        if model_lang == config.PYTHON:
            script_path = Path(f"./src/model/python/model.py")
            process = subprocess.Popen(["python", str(script_path), "called_from_run_file"], stdout=subprocess.PIPE, stderr=subprocess.PIPE);
        elif model_lang == config.C:
            script_path = Path(f"./src/model/c/model.c")
            if not self.compiler_path:
                raise ValueError("Compiler path not set for C/C++ models.")
            process = subprocess.Popen([str(self.compiler_path), str(script_path)], stdout=subprocess.PIPE, stderr=subprocess.PIPE); 
            if process.returncode == 0:  # if compilation was successful, then run the executable
                process = subprocess.Popen(["./a.out"], stdout=subprocess.PIPE, stderr=subprocess.PIPE); 
        elif model_lang == config.CPP:
            script_path = Path(f"./src/model/cpp/model.cpp")
            if not self.compiler_path:
                raise ValueError("Compiler path not set for C/C++ models.")
            process = subprocess.Popen([str(self.compiler_path), str(script_path)], stdout=subprocess.PIPE, stderr=subprocess.PIPE); 
            if process.returncode == 0:  # if compilation was successful, then run the executable
                process = subprocess.Popen(["./a.out"], stdout=subprocess.PIPE, stderr=subprocess.PIPE);
        elif model_lang == config.MATLAB:
            script_path = Path(f"./src/model/matlab/model.m")
            process = subprocess.Popen(["matlab", "-r", f"run('{script_path}')"], stdout=subprocess.PIPE, stderr=subprocess.PIPE); 
        elif model_lang == config.RUST:
            script_path = Path(f"./src/model/rust/model.m")
            process = subprocess.Popen(["cargo", "run", "--manifest-path", str(script_path)], stdout=subprocess.PIPE, stderr=subprocess.PIPE); 
        else:
            raise ValueError(f"Unsupported model language: {model_lang.upper()}")

        # Print logs in real-time
        for line in iter(process.stdout.readline, b''):
            print(line.decode(), end='')
    
        # Handle errors, if any
        for line in iter(process.stderr.readline, b''):
            print(line.decode(), end='', file=sys.stderr)
            
        process.wait()

        process = subprocess.Popen(["python","main//extract_feature.py", "called_from_run_file"], stdout=subprocess.PIPE, stderr=subprocess.PIPE); process.wait()
        process = subprocess.Popen(["python","main//export_config_from_paramters.py", "called_from_run_file"], stdout=subprocess.PIPE, stderr=subprocess.PIPE); process.wait()
        process = subprocess.Popen(["python", "main//gen_code_class_vectors.py", "called_from_run_file"], stdout=subprocess.PIPE, stderr=subprocess.PIPE); process.wait()
        process = subprocess.Popen(["python", "main//gen_code_level_vectors.py", "called_from_run_file"], stdout=subprocess.PIPE, stderr=subprocess.PIPE); process.wait()
        



        pass
