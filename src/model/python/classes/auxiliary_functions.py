"""
 * @file auxiliary_functions.py
 * @brief This file contains the auxiliary functions used in the model.
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
import numpy as np
import math
# Quantization:
def quantization_levels(min_value,max_value,levels):
    levelList = []
    length = max_value - min_value
    gap = length / levels
    for level in range(levels-1):
        levelList.append(min_value + level*gap)
    levelList.append(max_value)
    return levelList

def get_quantized_level(value, quantization_levels):
    if value <= quantization_levels[0]:
        return 0
    if value >= quantization_levels[-1]:
        return len(quantization_levels)-1
    
    for i, level in enumerate(quantization_levels):
        if value <= level:
            return max(0, i)
        
    return len(quantization_levels)-1

def compute_sparsity_factor(vector):
    total_elements = len(vector)
    num_ones = np.count_nonzero(vector == 1)
    return num_ones/total_elements


def create_lut_efficient(bits):
    max_val = 2 ** bits
    lookup_table = {}
    current_exponent = 0
    next_power_of_two = 1

    for i in range(0, max_val + 1):
        # Check if we should move to the next exponent
        if i == next_power_of_two:
            current_exponent += 1
            next_power_of_two = 2 ** current_exponent

        # Check for the nearest power of two
        lower_power_of_two = 2 ** (current_exponent - 1) if current_exponent > 0 else 0
        higher_power_of_two = 2 ** current_exponent

        if i - lower_power_of_two <= higher_power_of_two - i:
            nearest_exponent = current_exponent - 1
        else:
            nearest_exponent = current_exponent

        # Correct handling for the case when i = 0
        if i == 0:
            nearest_exponent = 0

        # Update the range in the lookup table
        if nearest_exponent not in lookup_table:
            lookup_table[nearest_exponent] = [i, i]
        else:
            lookup_table[nearest_exponent][1] = i

    return lookup_table

def get_closest_poweroftwo_using_lut(lookup_table, value):
    if value == 0:
        return 0

    for power_of_two, (start, end) in lookup_table.items():
        if start <= value <= end:
            return power_of_two
    
    # If the value is larger than the largest key, set it to the largest power of two
    return max(lookup_table.keys())
