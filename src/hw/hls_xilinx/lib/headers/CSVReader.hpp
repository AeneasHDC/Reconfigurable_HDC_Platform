/**
 * @file CSVReader.hpp
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
