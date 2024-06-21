"""
/**
 * @file prj.py
 * @brief This file contains the Project class that is used to create and save projects.
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
from datetime import datetime
from rep_dgen import Rep_DGEN
import os
import shutil

class PRJ:
    def __init__(self):
        self._name = None
        self._id = None
        self._date = None
        self._time = None
        self._test_summary = None
        self.report_directory = None

    # Setter methods
    def set_name(self, name: str):
        self._name = name

    def set_id(self, id: int):
        self._id = id

    def set_date(self, date=None):
        if not date:
            _date = datetime.now()
            _date = _date.strftime('%Y%m%d')
        else:
            _date = date
        self._date = f"{_date[6:8]}_{_date[4:6]}_{_date[0:4]}"
        
        

    def set_time(self, time=None):
        if not time:
            _time = datetime.now()
            _time = _time.strftime('%H%M%S')
        else:
            _time = time
        self._time = f"{_time[0:2]}_{_time[2:4]}_{_time[4:6]}"

    def set_test_summary(self, summary: str):
        self._test_summary = summary

    # Getter methods
    def get_name(self) -> str:
        return self._name

    def get_id(self) -> int:
        return self._id

    def get_date(self) -> str:
        return self._date

    def get_time(self) -> str:
        return self._time

    def get_test_summary(self) -> str:
        return self._test_summary
    
    def create_project(self):
        try:
            self.set_date()
            self.set_time()
            self.report_directory = Rep_DGEN.create_report_directory(self._name, self._id, self._date, self._time)
            return True  
        except Exception as e:
            print(f"Error creating project directory: {e}")
            return False

    def save(self):
        if not self.report_directory:
            print("Report directory is not initialized. Cannot save project.")
            return False
        try:
            Rep_DGEN.copy_files_to_report_directory(self.report_directory)
            Rep_DGEN.create_info_json(self.report_directory, self._test_summary, self._name, self._id, self._date, self._time)
            Rep_DGEN.run_rep_gen(self.report_directory)

            #shutil.rmtree('./out/')
            return True 
        except Exception as e:
            print(f"Error saving project: {e}")
            return False
        
    
    def load_project(self, project_path):
        # TODO: Implement this method
        pass
    

    def __str__(self):
        return (f"Project Details:\n"
                f"Name: {self._name}\n"
                f"ID: {self._id}\n"
                f"Date: {self._date}\n"
                f"Time: {self._time}\n"
                f"Test Summary: {self._test_summary}\n")