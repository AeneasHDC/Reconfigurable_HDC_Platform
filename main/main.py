"""
/**
 * @file main.py
 * @brief Main file for the Aeneas framework.
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

from dataset import Dataset
from visualizer import Visualizer
from configuration  import Configuration 
from model_class  import Model_class 
from vectorutils import VectorUtils
from visualizer import Visualizer
from hdl import HDL
from req import Requirments
from rep_gen import Report
from utils import Utils
from prj import PRJ

class Aeneas:

    dataset = Dataset()
    visualizer = Visualizer(dataset)
    configuration = Configuration()
    model = Model_class()
    vectorutils = VectorUtils()
    hdl = HDL()
    report = Report()
    requirments = Requirments()
    utils = Utils()
    prj = PRJ()