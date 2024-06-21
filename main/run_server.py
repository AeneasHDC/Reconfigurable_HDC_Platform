"""
/**
 * @file run_server.py
 * @brief This file contains the code to run the server for the Jupyter notebook.
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
import os
import subprocess
import sys
import webbrowser
import time

def find_anaconda_root():
    # Tries to find the Anaconda root directory from the system path.
    for path in os.environ['PATH'].split(os.pathsep):
        if 'anaconda' in path.lower() and 'Scripts' in path:
            return os.path.dirname(path)
    return None

def main():
    anaconda_root = "C:/Users/disa/anaconda3/"#find_anaconda_root()
    if not anaconda_root:
        print("Anaconda installation not found.")
        sys.exit(1)

    cwp_path = os.path.join(anaconda_root, 'cwp.py')
    python_path = os.path.join(anaconda_root, 'python.exe')
    jupyter_path = os.path.join(anaconda_root, 'Scripts', 'jupyter-notebook-script.py')
    
    # Set the notebook directory to the current directory where this script is running
    notebook_directory = os.getcwd()
    print(notebook_directory)

    # Run the cwp.py script to set up the Anaconda environment asynchronously
    subprocess.Popen([python_path, cwp_path, anaconda_root, python_path, jupyter_path, notebook_directory])

if __name__ == "__main__":
    main()
