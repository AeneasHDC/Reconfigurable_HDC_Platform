/**
 * @file CSVReader.hpp
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


#ifndef CSVREADER_HPP
#define CSVREADER_HPP

#include <fstream>
#include <sstream>
#include <string>
#include <stdexcept>
#include <iostream>
#include <type_traits>
#include <limits>

template<typename T>
class CSVReader {
    std::ifstream inputFile;
    std::string currentLine;
    std::istringstream lineStream;

public:
    // Constructor
	CSVReader(const std::string &filename) : inputFile(filename) {
		if (!inputFile.is_open()) {
			throw std::runtime_error("Unable to open file: " + filename);
		}
	}

    // Destructor
    ~CSVReader() {
        if (inputFile.is_open()) {
            inputFile.close();
        }
    }

    // Opens the CSV file
    bool openFile() {
        if (!inputFile.is_open()) {
            std::cerr << "Error opening file!" << std::endl;
            return false;
        }
        return true;
    }

    // Closes the CSV file
    void closeFile() {
        if (inputFile.is_open()) {
            inputFile.close();
        }
    }

    // Reads an entire row of values
    std::vector<T> readRow() {
        std::vector<T> rowValues;
        if (std::getline(inputFile, currentLine)) {
            lineStream.clear();
            lineStream.str(currentLine);

            T value;
            while (readValue(value)) {
                rowValues.push_back(value);
            }
        }
        return rowValues;
    }

    // Reads values one by one
    bool readValue(T &value) {
        std::string token;
        if (std::getline(lineStream, token, ',')) {
            try {
                if (std::is_same<T, int>::value) {
                    value = std::stoi(token);
                } else if (std::is_same<T, float>::value) {
                    value = std::stof(token);
                } else {
                    throw std::invalid_argument("Unsupported type");
                }
                return true;
            } catch (const std::exception &e) {
                std::cerr << "Error reading value: " << e.what() << std::endl;
            }
        }
        return false;
    }


};

#endif // CSVREADER_HPP
