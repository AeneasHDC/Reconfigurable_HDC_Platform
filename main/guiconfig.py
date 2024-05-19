"""
/**
 * @file guiconfig.py
 * @brief This is the GUI configuration file.
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


class GUIConfig:

    def __init__(self):
        pass   
     
    def update():
        with open('./usr_config/config.json', 'r') as json_file:
            json_content = json_file.read()

        with open('./main/web/rep_template/usr_config_tmp.html', 'r') as html_file:
            html_content = html_file.read()

        html_content = html_content.replace('<!-- __config__ -->', json_content)

        with open('./usr_config/usr_config.html', 'w') as html_file:
            html_file.write(html_content)
    pass
