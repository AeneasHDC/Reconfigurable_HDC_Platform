"""
/**
 * @file extract_feature.py
 * @brief This script reads vectors from multiple files, computes similarities 
 *        between all vectors, plots the similarity matrix, and saves the matrix 
 *        to an output file. 
 *
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
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sys
import os
from visualizer import Visualizer 
from vectorutils import VectorUtils 


if len(sys.argv) > 1 and sys.argv[1] == "called_from_run_file":
    relative_path_prefix = ""
else:
    relative_path_prefix = "../"
    
sys.path.append(relative_path_prefix + 'src/config/')

import config_py as config
from scipy.spatial.distance import cosine

def read_vectors(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
        vectors = [np.array(list(map(float, line.strip().split(',')))) for line in lines]
    return vectors


def save_matrix_to_file(matrix, file_path):
    df = pd.DataFrame(matrix)
    df.to_csv(file_path, index=False, header=False)

def count_element_changes(vectors):
    changes = []
    for i in range(1, len(vectors)):
        change_count = np.sum(vectors[i-1] != vectors[i])
        changes.append(change_count)
    return changes

def main():
    DS_NAME = config.DS_NAME

    try:
        plot_file_path = os.path.join( relative_path_prefix, "out", DS_NAME, "ds_boxplot.png" )
        Visualizer.plot_statistics( DS_NAME, 'train_data', file_path=plot_file_path, just_save=True )  # --TODO--: Not working
        
        
    except:
        print("Error while plotting statistics --TODO--")


    input_folder_path = os.path.join( relative_path_prefix, "out", "extracted_params", DS_NAME )
    output_folder_path = os.path.join(input_folder_path, 'out_features')
    if not os.path.exists(output_folder_path):
        os.makedirs(output_folder_path)
    files_to_process = ["BaseHVs.csv", "LevelHVs.csv"]

    for file_name in files_to_process:
        input_file_path = os.path.join(input_folder_path, file_name)
        vectors = read_vectors(input_file_path)

        similarity_matrix = VectorUtils.compute_similarity_matrix(vectors)
        plot_file_path = os.path.join(output_folder_path, file_name.replace('.csv', '_plot.png'))
        Visualizer.plot_similarity_matrix(similarity_matrix, plot_file_path, just_save=True)
        output_file_path = os.path.join(output_folder_path, file_name.replace('.csv', '_matrix.csv'))
        save_matrix_to_file(similarity_matrix, output_file_path)

        changes = count_element_changes(vectors)
        changes_file_path = os.path.join(output_folder_path, file_name.replace('.csv', '_changes.csv'))
        pd.DataFrame(changes).to_csv(changes_file_path, index=False, header=["Element Changes"])

    
    

if __name__ == '__main__':
    main()
