"""
/**
 * @file extract_feature.py
 * @brief This script reads vectors from multiple files, computes similarities 
 *        between all vectors, plots the similarity matrix, and saves the matrix 
 *        to an output file. 
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
 * @cite https:doi.org/10.xxxx/yyyyy
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
