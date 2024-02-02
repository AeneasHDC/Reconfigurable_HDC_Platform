"""
/**
 * @file rep_dgen.py
 * @brief 
 *
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