/**
 * @file CSVWriter.hpp
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
#ifndef CSVWRITER_HPP
#define CSVWRITER_HPP

#include <fstream>
#include <vector>
#include <string>
#include <sstream>

template<typename T>
class CSVWriter {
    std::ofstream outputFile;

public:
    // Constructor
    CSVWriter(const std::string &filename) {
        outputFile.open(filename);
        if (!outputFile.is_open()) {
            throw std::runtime_error("Unable to open file for writing: " + filename);
        }
    }

    // Destructor
    ~CSVWriter() {
        if (outputFile.is_open()) {
            outputFile.close();
        }
    }

    // Writes a row of values to the CSV file
    void writeRow(const std::vector<T> &rowValues) {
        std::stringstream ss;
        for (size_t i = 0; i < rowValues.size(); ++i) {
            ss << rowValues[i];
            if (i < rowValues.size() - 1) ss << ",";
        }
        ss << "\n";
        outputFile << ss.str();
    }

    // Closes the CSV file
    void closeFile() {
        if (outputFile.is_open()) {
            outputFile.close();
        }
    }
};

#endif // CSVWRITER_HPP
