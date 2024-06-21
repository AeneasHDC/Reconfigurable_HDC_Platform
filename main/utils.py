"""
/**
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
import xmltodict

class Utils:

    def __init__(self):
        pass
    @staticmethod
    def convert_xml_to_json(xml_file_path, json_file_path):
        with open(xml_file_path, 'r') as xml_file:
            xml_data = xml_file.read()
        
        data_dict = xmltodict.parse(xml_data)
        json_data = json.dumps(data_dict, indent=4)
        
        with open(json_file_path, 'w') as json_file:
            json_file.write(json_data)

    @staticmethod
    def display_dict(d, indent=0):
        out = ""
        for key, value in d.items():
            out += "<div style='margin-left: {}px; margin-top: 10px; padding: 8px; border: 1px solid #eee; border-radius: 4px;'>".format(indent * 20)
            
            # If value is another dictionary, recurse
            if isinstance(value, dict):
                out += "<span style='color: #2c3e50; font-weight: bold;'>{}</span>:<br>".format(key)
                out += Utils.display_dict(value, indent + 1)
            else:
                out += "<span style='color: #2980b9; font-weight: bold;'>{}</span>: <span style='color: #e74c3c;'>{}</span>".format(key, value)
            out += "</div>"
        return out