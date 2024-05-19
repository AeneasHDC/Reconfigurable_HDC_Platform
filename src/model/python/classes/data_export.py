"""
/**
 * @file data_export.py
 * @brief This file contains the data export functions used in the model.
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
 * @Authors: Marco Angioli & Saeid Jamili
 * @note Author names are listed in alphabetical order.
 */
"""
import csv
import pandas as pd
import json

class DataExporter:
    """
    A class that exports data in specific formats such as CSV.
    """
    
    def __init__(self, output_dir='out//extracted_params//'):
        self.output_dir = output_dir

    def export_data(self, data, file_name):
        """
        Exports the provided data dictionary to a CSV file.

        :param data_dict: The dictionary to be exported.
        :param file_name: The name of the file where the data will be saved.
        """
        # Define the CSV file path
        csv_file = f'{self.output_dir}{file_name}'

        # Export the transposed array to a CSV file
        with open(csv_file, 'w', newline='') as csvfile:
            csvwriter = csv.writer(csvfile)
            for row in data:
                csvwriter.writerow(row)
                
        print(f"Data exported to {csv_file} successfully.")
                
    def export_splitdataset(self, data, file_name):
        """
        Exports the provided training data to a CSV file.
    
        :param training_data: The training data to be exported ([Xtr, ytr]).
        :param file_name: The name of the file where the data will be saved.
        """
        # Xtr, ytr = data
        Xtr= data
        df = pd.DataFrame(Xtr)
#        df['target'] = ytr  # append ytr as a new column to the DataFrame
    
        csv_file = f'{self.output_dir}{file_name}'
        df.to_csv(csv_file, index=False)
    
        print(f"Training data exported to {csv_file} successfully.")
        
    def export_dict_to_json(self, data_dict, file_name):
        """
        Exports the provided dictionary to a JSON file.

        :param data_dict: The dictionary to be exported.
        :param file_name: The name of the file where the data will be saved.
        """
        # Define the JSON file path
        json_file = f'{self.output_dir}{file_name}.json'

        # Export the dictionary as a JSON-formatted string to the file
        with open(json_file, 'w') as file:
            json.dump(data_dict, file)
            
        print(f"Dictionary exported to {json_file} successfully.")
