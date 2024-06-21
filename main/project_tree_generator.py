"""
/**
 * @file project_tree_generator.py
 * @brief This script generates a project tree for the specified directory.
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
import os


if len(sys.argv) > 1 and sys.argv[1] == "called_from_run_file":
    relative_path_prefix = ""
else:
    relative_path_prefix = "../"
    
sys.path.append(relative_path_prefix + 'src/config/')

import config_py as config


def is_valid(name):
    return not (name.startswith('.') or name.startswith('_'))

def generate_project_tree(startpath, textfile, latexfile, detailed):
    with open(textfile, 'w') as txt, open(latexfile, 'w') as tex:
        tex.write('\\documentclass{article}\n')
        tex.write('\\usepackage{forest}\n')
        tex.write('\\begin{document}\n')
        tex.write('\\begin{forest}\n')
        for root, dirs, files in os.walk(startpath):
            dirs[:] = [d for d in dirs if is_valid(d)]
            level = root.replace(startpath, '').count(os.sep)
            indent = ' ' * 4 * (level)
            txt.write(f'{indent}{os.path.basename(root)}/\n')
            subindent = ' ' * 4 * (level + 1)
            if detailed:
                for fname in files:
                    if is_valid(fname):
                        txt.write(f'{subindent}{fname}\n')
            if level == 0:
                tex.write(f'[ {os.path.basename(root)}\n')
            else:
                tex.write(' ' * 2 * level + f'[ {os.path.basename(root)}\n')
        tex.write('\\end{forest}\n')
        tex.write('\\end{document}\n')
        

    
if __name__ == '__main__':
    startpath = relative_path_prefix
    out_path = relative_path_prefix + '/doc/'
    textfile = out_path + 'project_tree.txt' 
    textfile_detail = out_path +'project_tree_detail.txt'

    latexfile = relative_path_prefix + 'doc/project_tree.tex' 
    pdffile = out_path + 'project_tree.pdf' # change this to the desired PDF output file name

    generate_project_tree(startpath, textfile, latexfile, detailed=False)
    generate_project_tree(startpath, textfile_detail, latexfile, detailed=True)


