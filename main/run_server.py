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

CONFIG_FILE = "anaconda_config.json"

class AnacondaRootNotFoundError(Exception):
    """Custom exception for when Anaconda root directory is not found."""
    pass

def load_anaconda_root_from_config():
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, 'r') as file:
            try:
                config = json.load(file)
                return config.get("anaconda_root")
            except json.JSONDecodeError:
                return None
    return None

def save_anaconda_root_to_config(anaconda_root):
    with open(CONFIG_FILE, 'w') as file:
        json.dump({"anaconda_root": anaconda_root}, file)

def find_anaconda_root():
    # Tries to find the Anaconda root directory from the system path.
    paths = os.environ['PATH'].split(os.pathsep)
    potential_paths = []

    for path in paths:
        if 'anaconda' in path.lower():
            if 'Scripts' in path or 'bin' in path:
                potential_paths.append(path)

    if not potential_paths:
        raise AnacondaRootNotFoundError("Anaconda root directory not found in system PATH.")

    for path in potential_paths:
        anaconda_root = os.path.dirname(os.path.dirname(path))
        if os.path.isdir(anaconda_root):
            return anaconda_root

    raise AnacondaRootNotFoundError("Anaconda root directory not found after checking potential paths.")

def main():
    anaconda_root = load_anaconda_root_from_config()
    if anaconda_root and os.path.isdir(anaconda_root):
        print(f"Anaconda root directory found in config: {anaconda_root}")
    else:
        try:
            anaconda_root = find_anaconda_root()
            print(f"Anaconda root directory found: {anaconda_root}")
            save_anaconda_root_to_config(anaconda_root)
        except AnacondaRootNotFoundError as e:
            print(e)
            anaconda_root = input("Please manually enter the Anaconda root directory path: ")
            if os.path.isdir(anaconda_root):
                save_anaconda_root_to_config(anaconda_root)
                print(f"Anaconda root directory set to: {anaconda_root}")
            else:
                print("The provided path is not a valid directory.")
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
