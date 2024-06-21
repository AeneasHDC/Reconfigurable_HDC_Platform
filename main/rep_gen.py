"""
/**
 * @file rep_gen.py
 * @brief This file contains the functions to generate the report for the model.
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


import json
import os
import sys
import re
import shutil
from datetime import datetime
from jinja2 import Environment, FileSystemLoader
import csv
import webbrowser

sys.path.append('src/config/')
import config_py as config

#if len(sys.argv) > 1 and sys.argv[1] == "update_main":
run_mode = "update_main"



class Report:
    def __init__(self):
        pass

    def open(self):
        rep_main_page_gen('');
        path= os.getcwd()
        url = "file:///"+path + "/rep/main.html"
        webbrowser.open(url)
        pass


    
def extract_folder_info(folder_name):
    parts = folder_name.split('_')
    if len(parts) != 8:
        return None
    name, id_, day, month, year, hour, minute, second = parts
    formatted_date = f"{day}/{month}/{year}"
    formatted_time = f"{hour}:{minute}:{second}"
    
    return name, id_, formatted_date, formatted_time

def generate_table_row_main(folder_info, report_file_path):
    name, id_, date, time = folder_info
    return f'''
                <tr>
                    <td>{name}</td>
                    <td>{id_}</td>
                    <td>{date}</td>
                    <td>{time}</td>
                    <td><button onclick="loadReport('{report_file_path}')">View</button></td>
                </tr>
    '''


def format_test_summary(test_summary):
    lines = test_summary.split("\n")
    formatted_summary = "".join([f"<p>{line}</p>" for line in lines])
    return formatted_summary


def replace_placeholders_with_json_info(template_content, json_data):
    content_with_replacements = template_content

    formatted_test_summary = format_test_summary(json_data.get("TEST_SUMMARY", ""))
    
    content_with_replacements = content_with_replacements.replace('<!-- __TEST_SUMMARY__ -->', formatted_test_summary)
    content_with_replacements = content_with_replacements.replace('<!-- __TEST_NAME__ -->', json_data.get("TEST_NAME", ""))
    content_with_replacements = content_with_replacements.replace('<!-- __TEST_ID__ -->', json_data.get("TEST_ID", ""))
    content_with_replacements = content_with_replacements.replace('<!-- __TEST_DATE__ -->', json_data.get("TEST_DATE", ""))
    content_with_replacements = content_with_replacements.replace('<!-- __TEST_TIME__ -->', json_data.get("TEST_TIME", ""))

    return content_with_replacements

def parse_config_file(config_path):
    rows = []

    with open(config_path, 'r') as file:
        data = json.load(file)

    def parse_data(data, category):
        for param, config_data in data.items():
            # Exclude items where parameter name is "description"
            if param == "description":
                continue
            
            # If the data is a dictionary and has 'selected' as a key
            if isinstance(config_data, dict) and 'selected' in config_data:
                value = config_data['selected']
                rows.append((category, param, value))
            # If the data is a dictionary but doesn't have 'selected'
            elif isinstance(config_data, dict):
                parse_data(config_data, category)
            else:
                # This will handle simple key-value pairs like "LV_DATA_W_BITS": 1
                rows.append((category, param, config_data))

    for category, params in data.items():
        parse_data(params, category)

    return rows

def generate_config_table(rows):
    table_content = ''
    for category, parameter, value in rows:
        table_content += f'''<tr>
                                <td>{category}</td>
                                <td>{parameter}</td>
                                <td>{value}</td>
                            </tr>'''
    
    return table_content

def replace_dataset_placeholders(template_content, json_data):
    content_with_replacements = template_content
    placeholder_to_key = {
        "<!-- __DS_NAME__ -->": "dataset_name",
        "<!-- __DS_DISCRIPTION__ -->": "description",
        "<!-- __DS_TOTAL_DATA_SIZE__ -->": "total_data_size",
        "<!-- __DS_TRAIN_DATA_SIZE__ -->": "training_data_size",
        "<!-- __DS_TEST_DATA_SIZE__ -->": "testing_data_size",
        "<!-- __DS_FEATURE_SIZE__ -->": "feature_size",
        "<!-- __DS_DATA_TYPE__ -->": "data_type",
        "<!-- __DS_DATA_RANGE__ -->": "data_range",
        "<!-- __DS_CLASS_SIZE__ -->": "class_size",
        "<!-- __DS_SOURCE__ -->": "source",
        "<!-- __DS_DATA_COLLECTION__ -->": "date_collected",
        "<!-- __DS_DATE_PUBLISH__ -->": "date_published",
        "<!-- __DS_CRETAED_BY__ -->": "created_by",
        "<!-- __DS_PEPER_CITE__ -->": "paper_citation",
        "<!-- __DS_LINK__ -->": "dataset_link"
    }
    for placeholder, key in placeholder_to_key.items():
        content_with_replacements = content_with_replacements.replace(placeholder, str(json_data.get(key, "")))

    return content_with_replacements


def replace_image_and_csv_placeholders(template_content, rep_folder):
    
    
    dataset_name = config.DS_NAME;
    content_with_replacements = template_content.replace("<!-- __MATRIX_SIMILARITY_BASE_VECTOR__ -->", "./extracted_params/"+dataset_name+"/out_features/BaseHVs_plot.png")
    content_with_replacements = content_with_replacements.replace("<!-- __MATRIX_SIMILARITY_LEVEL_VECTOR__ -->", "./extracted_params/"+dataset_name+"/out_features/LevelHVs_plot.png")
    content_with_replacements = content_with_replacements.replace("<!-- __DATASET_STATISTICS__ -->", "./dataset/"+dataset_name+"/ds_boxplot.png")

   
    # Helper function to generate table rows from CSV file
    def generate_table_rows_from_csv(csv_path):
        rows = []
        with open(csv_path, 'r') as csvfile:
            reader = csv.reader(csvfile)
            index = 1
            for row in reader:
                # Assuming each row has a single number
                num_changes = row[0]
                rows.append(f"<tr><td>{index}</td><td>{num_changes}</td></tr>")
                index += 1
        return ''.join(rows)
    
    
    base_csv_path = f'{rep_folder}/extracted_params/{dataset_name}/out_features/BaseHVs_changes.csv'
    base_table_content = generate_table_rows_from_csv(base_csv_path)
    content_with_replacements = content_with_replacements.replace("<!-- __NUM_OF_CHANEGES_BASE_VECTOR__ -->", base_table_content)
    
    # Replacing Level Vector placeholder
    level_csv_path = f'{rep_folder}/extracted_params/{dataset_name}/out_features/LevelHVs_changes.csv'
    level_table_content = generate_table_rows_from_csv(level_csv_path)
    content_with_replacements = content_with_replacements.replace("<!-- __NUM_OF_CHANEGES_LEVEL_VECTOR__ -->", level_table_content)
    
    return content_with_replacements


def replace_evaluation_placeholders(template_content, rep_folder):
    
    ds_name = config.DS_NAME;
    placeholder_to_key = {
        "<!-- __MODEL_EVAL_CONFUSION_MAT__ -->": f"./model_eva/{ds_name}/confusion_matrix.png",
        "<!-- __HLS_EVAL_CONFUSION_MAT__ -->": f"./hls/confusion_matrix.png",
    }

    # Open the model_report.json file
    with open(f'{rep_folder}/model_eva/{ds_name}/model_report.json', "r") as json_file:
        model_report = json.load(json_file)
    with open(f'{rep_folder}/hls/hls_report.json', "r") as json_file:
        print("opened file,", json_file)
        hdl_report = json.load(json_file)

    # Update the dictionary with the values from the JSON file
    if config.PROBLEM_TYPE == config.PROBLEM_TYPE_CLASSIFICATION:
        
        placeholder_to_key["<!-- __MODEL_EVAL_ACCURACY__ -->"] = model_report.get("accuracy", "")
        placeholder_to_key["<!-- __MODEL_EVAL_PRECISION__ -->"] = model_report.get("precision", "")
        placeholder_to_key["<!-- __MODEL_EVAL_RECALL__ -->"] = model_report.get("recall", "")
        placeholder_to_key["<!-- __MODEL_EVAL_F1SCORE__ -->"] = model_report.get("f1_score", "")
        placeholder_to_key["<!-- __MODEL_EVAL_ROC_AUC__ -->"] = model_report.get("roc_auc", "")
        placeholder_to_key["<!-- __MODEL_EVAL_MSE__ -->"] = ""


        placeholder_to_key["<!-- __HDL_EVAL_ACCURACY__ -->"] = hdl_report.get("accuracy", "")
        placeholder_to_key["<!-- __HDL_EVAL_PRECISION__ -->"] = hdl_report.get("precision", "")
        placeholder_to_key["<!-- __HDL_EVAL_RECALL__ -->"] = hdl_report.get("recall", "")
        placeholder_to_key["<!-- __HDL_EVAL_F1SCORE__ -->"] = hdl_report.get("f1_score", "")
        placeholder_to_key["<!-- __HDL_EVAL_ROC_AUC__ -->"] = hdl_report.get("roc_auc", "")
        placeholder_to_key["<!-- __HDL_EVAL_MSE__ -->"] = ""

    if config.PROBLEM_TYPE == config.PROBLEM_TYPE_REGRESSION:
        placeholder_to_key["<!-- __MODEL_EVAL_ACCURACY__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_PRECISION__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_RECALL__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_F1SCORE__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_ROC_AUC__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_MSE__ -->"] = model_report.get("MSE", "")

        placeholder_to_key["<!-- __MODEL_EVAL_ACCURACY__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_PRECISION__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_RECALL__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_F1SCORE__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_ROC_AUC__ -->"] = ""
        placeholder_to_key["<!-- __MODEL_EVAL_MSE__ -->"] = hdl_report.get("MSE", "")

    if config.PROBLEM_TYPE == config.PROBLEM_TYPE_CLUSTERING:
        placeholder_to_key["<!-- __MODEL_EVAL_ACCURACY__ -->"] = model_report.get("accuracy", "")
        placeholder_to_key["<!-- __MODEL_EVAL_PRECISION__ -->"] = model_report.get("precision", "")
        placeholder_to_key["<!-- __MODEL_EVAL_RECALL__ -->"] = model_report.get("recall", "")
        placeholder_to_key["<!-- __MODEL_EVAL_F1SCORE__ -->"] = model_report.get("f1_score", "")
        placeholder_to_key["<!-- __MODEL_EVAL_ROC_AUC__ -->"] = model_report.get("roc_auc", "")
        placeholder_to_key["<!-- __MODEL_EVAL_MSE__ -->"] = ""


        placeholder_to_key["<!-- __HDL_EVAL_ACCURACY__ -->"] = hdl_report.get("accuracy", "")
        placeholder_to_key["<!-- __HDL_EVAL_PRECISION__ -->"] = hdl_report.get("precision", "")
        placeholder_to_key["<!-- __HDL_EVAL_RECALL__ -->"] = hdl_report.get("recall", "")
        placeholder_to_key["<!-- __HDL_EVAL_F1SCORE__ -->"] = hdl_report.get("f1_score", "")
        placeholder_to_key["<!-- __HDL_EVAL_ROC_AUC__ -->"] = hdl_report.get("roc_auc", "")
        placeholder_to_key["<!-- __HDL_EVAL_MSE__ -->"] = ""






    # Replace the placeholders in the content
    content_with_replacements = template_content
    for placeholder, value in placeholder_to_key.items():
        content_with_replacements = content_with_replacements.replace(placeholder, str(value))

    return content_with_replacements


import os
import json

def replace_resource_placeholders(template_content, rep_folder):
    
    # Define placeholders and their corresponding keys in the JSON for each resource type
    resource_map = {
        "LUTs": {
            "<!-- __HDL_RESOURCE_LUT_USED__ -->": "Used",
            "<!-- __HDL_RESOURCE_LUT_AVAIL__ -->": "Available",
            "<!-- __HDL_RESOURCE_LUT_UTIL__ -->": "Util%"
        },
        "FF": {
            "<!-- __HDL_RESOURCE_FF_USED__ -->": "Used",
            "<!-- __HDL_RESOURCE_FF_AVAIL__ -->": "Available",
            "<!-- __HDL_RESOURCE_FF_UTIL__ -->": "Util%"
        },
        "CARRY8": {
            "<!-- __HDL_RESOURCE_CARRY8_USED__ -->": "Used",
            "<!-- __HDL_RESOURCE_CARRY8_AVAIL__ -->": "Available",
            "<!-- __HDL_RESOURCE_CARRY8_UTIL__ -->": "Util%"
        },
        "DSPs": {
            "<!-- __HDL_RESOURCE_DSPs_USED__ -->": "Used",
            "<!-- __HDL_RESOURCE_DSPs_AVAIL__ -->": "Available",
            "<!-- __HDL_RESOURCE_DSPs_UTIL__ -->": "Util%"
        }
    }
    
    table_template = """
    <h4>Site Resource Usage estimated by <!-- __HDL_SYNTHESIS_TOOL_FOR_REPORT_RESOURCE__ --> </h4>
    <table>
        <thead>
            <tr>
                <th>Site Type</th>
                <th>Used</th>
                <th>Available</th>
                <th>Util%</th>
            </tr>
        </thead>
        <tbody>
            <!--RESOURCE_ROWS-->
        </tbody>
    </table>
    """
    
    resource_row_template = """
    <tr>
        <td>{site_type}</td>
        <td>{used}</td>
        <td>{available}</td>
        <td>{util}</td>
    </tr>
    """
    
    def process_json_file(filename, tool_name):
        with open(filename, "r") as json_file:
            resource_report = json.load(json_file)
        
        resources = resource_report.get("resources", [])
        
        rows = ""
        for resource in resources:
            site_type = resource.get("Site Type")
            rows += resource_row_template.format(
                site_type=site_type,
                used=resource.get("Used", ""),
                available=resource.get("Available", ""),
                util=resource.get("Util%", "")
            )
        
        content = table_template.replace("<!--RESOURCE_ROWS-->", rows)
        content = content.replace("<!-- __HDL_SYNTHESIS_TOOL_FOR_REPORT_RESOURCE__ -->", tool_name)
        return content

    # Check if the JSON files exist and process them
    resource_path = f"{rep_folder}/hdl/hdl_resource_report.json"
    
    table_content = ""
    if os.path.exists(resource_path):
        table_content = process_json_file(resource_path, "VIVADO")

    # Replace the placeholder in the main template with the table content
    return template_content.replace("<!-- __HDL_REPORT_RESOURCE__ -->", table_content)



def replace_timing_placeholders(template_content, rep_folder):

    json_path = f"{rep_folder}/hls/hdl_timming_report.json"
    
    if not os.path.exists(json_path):
        return template_content

    with open(json_path, "r") as json_file:
        timing_data = json.load(json_file)
  
    if "TOTAL_EXECUTE_TIME_ADJUSTED" in timing_data:
        template_content = template_content.replace("<!-- __HDL_TIME_TOTAL_ADJUSTED__ -->", str(timing_data["TOTAL_EXECUTE_TIME_ADJUSTED"]))

    if "TOTAL_EXECUTE_TIME" in timing_data:
        template_content = template_content.replace("<!-- __HDL_TIME_TOTAL_EXECUTE__ -->", str(timing_data["TOTAL_EXECUTE_TIME"]))
                
                
    return template_content

def replace_power_placeholders(template_content, rep_folder):
    # Path to the JSON file
    json_path = f"{rep_folder}/hls/hdl_power_consumption.json"
    
    # Check if the JSON file exists
    if not os.path.exists(json_path):
        return template_content
    
    # If it exists, process it
    with open(json_path, "r") as json_file:
        power_data = json.load(json_file)
    
    # Replace power consumption info
    for entry in power_data.get("powerConsumptionInfo", []):
        if entry["category"] == "Static Power Consumption":
            template_content = template_content.replace("<!-- __HDL_POWER_STATIC__ -->", str(entry["value"]))
        elif entry["category"] == "Dynamic Power Consumption":
            template_content = template_content.replace("<!-- __HDL_POWER_DYN__ -->", str(entry["value"]))
    
    # Replace synthesis tool name
    try:
        resource_usage_info = power_data.get("resourceUsageInfo", {})
        synthesis_tool_placeholder = "<!-- __HDL_SYNTHESIS_TOOL_FOR_REPORT_RESOURCE__ -->"
        template_content = template_content.replace(synthesis_tool_placeholder, resource_usage_info["value"])
        
        # Replace detailed resource usage info
        for detail in resource_usage_info.get("resourceUsageDetails", []):
            if detail["category"] == "Clocks":
                template_content = template_content.replace("<!-- __POWER_DYN_CLOCK_USAGE__ -->", detail["powerUsageW"])
                template_content = template_content.replace("<!-- __POWER_DYN_CLOCK_USAGE_PERCENT__ -->", detail["powerUsagePercent"])
            elif detail["category"] == "Signals":
                template_content = template_content.replace("<!-- __POWER_DYN_SIG_USAGE__ -->", detail["powerUsageW"])
                template_content = template_content.replace("<!-- __POWER_DYN_SIG_USAGE_PERCENT__ -->", detail["powerUsagePercent"])
            elif detail["category"] == "Logic":
                template_content = template_content.replace("<!-- __POWER_DYN_LOGIC_USAGE__ -->", detail["powerUsageW"])
                template_content = template_content.replace("<!-- __POWER_DYN_LOGIC_USAGE_PERCENT__ -->", detail["powerUsagePercent"])
            elif detail["category"] == "BRAM":
                template_content = template_content.replace("<!-- __POWER_DYN_BRAM_USAGE__ -->", detail["powerUsageW"])
                template_content = template_content.replace("<!-- __POWER_DYN_BRAM_USAGE_PERCENT__ -->", detail["powerUsagePercent"])

    except Exception as e:
        print(f"--TODO--")

    return template_content


def rep_main_page_gen(_rep_folder):
    directory_path = './rep/'+ os.path.basename(_rep_folder);    
    folders = [folder for folder in os.listdir('./rep/') if os.path.isdir(os.path.join('./rep/', folder))]
    table_rows = []

    for folder in folders:
        folder_info = extract_folder_info(folder)
        if folder_info:
            report_file_path = f"./{folder}/report.html"
            table_rows.append(generate_table_row_main(folder_info, report_file_path))

    table_html = ''.join(table_rows)

    with open(r'./main/web/rep_template/template_main.html', 'r') as template_file:
        template_content = template_file.read()

    new_content = template_content.replace('<!-- __REPORT_LISTS__ -->', table_html)

    with open('./rep/main.html', 'w') as output_file:
        output_file.write(new_content)

def rep_gen(_rep_folder):

    directory_path = './rep/'+ os.path.basename(_rep_folder);    
    

    with open('./main/web/rep_template/template_report.html', 'r') as template_file:
        template_content = template_file.read()

    new_content = template_content;
    info_json_path = f'{directory_path}/info.json'
    config_path = f'{directory_path}/config.json'
    
    if os.path.exists(info_json_path):
        with open(info_json_path, 'r') as json_file:
            json_data = json.load(json_file)
        new_content = replace_placeholders_with_json_info(template_content, json_data)
        
    if os.path.exists(config_path):
        rows = parse_config_file(config_path)
        table_content = generate_config_table(rows)
        new_content = new_content.replace('<!-- __CONFIG__ -->', table_content)
        
    dataset_name = config.DS_NAME;
    with open(f"./datasets/{dataset_name}/dataset_info.json", "r") as json_file:
        dataset_info = json.load(json_file)
        
    new_content = replace_dataset_placeholders(new_content, dataset_info)
    new_content = replace_image_and_csv_placeholders(new_content, directory_path)
    new_content = replace_evaluation_placeholders(new_content, directory_path)
    new_content = replace_resource_placeholders(new_content, directory_path)
    new_content =  replace_power_placeholders(new_content, directory_path)
    new_content = replace_timing_placeholders(new_content, directory_path)
 

    with open(f'{directory_path}/report.html', 'w') as output_file:
        output_file.write(new_content)
        
        
def main():
    rep_gen('');
    rep_main_page_gen('');

if __name__ == "__main__":
    main()