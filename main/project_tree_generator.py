"""
/**
 * @file project_tree_generator.py
 * @brief This script generates a project tree for the specified directory.
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


