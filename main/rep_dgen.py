"""
/**
 * @file rep_dgen.py
 * @brief 
 *
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
import shutil
import json
import sys
import webbrowser


class Rep_DGEN:
        
    def create_report_directory(name_project, id_project, date, time):

        # Generate directory name and path
        dir_name = f"{name_project}_{id_project}_{date}_{time}"
        dir_path = os.path.join('.', 'rep', dir_name)

        # Create directory if it doesn't exist
        if not os.path.exists(dir_path):
            os.makedirs(dir_path)
            if not os.path.exists(dir_path):  # Check if directory creation was successful
                raise Exception(f"Failed to create directory at {dir_path}")

        return dir_path

    def copy_files_to_report_directory(report_directory):

        source_dir = os.path.join('.', 'out')
        for item in os.listdir(source_dir):
            source_item = os.path.join(source_dir, item)
            destination_item = os.path.join(report_directory, item)

            if os.path.isdir(source_item):
                shutil.copytree(source_item, destination_item)
            else:
                shutil.copy2(source_item, destination_item)

        shutil.copy2(os.path.join('.', 'usr_config', 'config.json'), report_directory)

    def create_info_json(report_directory, summary, name_project, id_project, date, time):
        info_data = {
            "TEST_SUMMARY": str(summary),
            "TEST_NAME": str(name_project),
            "TEST_ID": str(id_project),
            "TEST_DATE": str(date),
            "TEST_TIME": str(time)
        }

        with open(os.path.join(report_directory, 'info.json'), 'w') as json_file:
            json.dump(info_data, json_file, indent=4)

    def run_rep_gen(report_directory):
        sys.path.append(os.path.join('.', 'main'))

        from rep_gen import rep_gen
        rep_gen(report_directory)


    def extract_folder_info(folder_name):
        parts = folder_name.split('_')
        
        if len(parts) != 4:
            return None
        formatted_date = f"{date[6:8]}/{date[4:6]}/{date[0:4]}"
        formatted_time = f"{time[0:2]}:{time[2:4]}:{time[4:6]}"
        name, id_, date, time = parts
        return name, id_, date, time