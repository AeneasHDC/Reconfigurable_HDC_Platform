"""
/**
 * @class Report
 * @brief A class responsible for generating, managing and storing the evaluation reports of a given model.
 *
/**
 * @file data_export.py
 * @brief 
 *
 * @author Saeid Jamili and Marco Angioli
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

 *
 *
 * Licensed under the MIT License. See the LICENSE file in the project root for full license details.
 *
 * @section CHANGELOG
 * @version 0.0.0=dev - 23th August 2023
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


from sklearn.metrics import accuracy_score, precision_score, recall_score
from sklearn.metrics import f1_score, roc_auc_score, confusion_matrix
from sklearn.preprocessing import LabelBinarizer
from sklearn.metrics.cluster import normalized_mutual_info_score
from sklearn.metrics import mean_squared_error
import sys
sys.path.append("../")
import config_py as config
import json

class Report:
    def __init__(self, problem, problem_type='binary'):
        self.problem = problem
        self.problem_type = problem_type
        self.report = {}

    def generate_report(self, y_test, y_pred):
        if self.problem == config.PROBLEM_TYPE_CLUSTERING:
            self.report['NMI'] = normalized_mutual_info_score(y_test, y_pred)
        elif self.problem == config.PROBLEM_TYPE_REGRESSION:
            self.report['MSE'] = mean_squared_error(y_test, y_pred)
        if self.problem == config.PROBLEM_TYPE_CLASSIFICATION:
            lb = LabelBinarizer()
            lb.fit(y_test)
            y_test_bin = lb.transform(y_test)
            y_pred_bin = lb.transform(y_pred)

            self.report['accuracy'] = accuracy_score(y_test, y_pred)

            if self.problem_type == 'binary':
                self.report['precision'] = precision_score(y_test, y_pred)
                self.report['recall'] = recall_score(y_test, y_pred)
                self.report['f1_score'] = f1_score(y_test, y_pred)
                self.report['roc_auc'] = roc_auc_score(y_test_bin, y_pred_bin)
            elif self.problem_type == 'multiclass':
                self.report['precision'] = precision_score(y_test, y_pred, average='macro')
                self.report['recall'] = recall_score(y_test, y_pred, average='macro')
                self.report['f1_score'] = f1_score(y_test, y_pred, average='macro')
                self.report['roc_auc'] = roc_auc_score(y_test_bin, y_pred_bin, multi_class='ovr', average='macro')
            
            self.report['confusion_matrix'] = confusion_matrix(y_test, y_pred).tolist()

    def save_report(self, filename):
        with open(filename, 'w') as f:
            json.dump(self.report, f, indent=4)
