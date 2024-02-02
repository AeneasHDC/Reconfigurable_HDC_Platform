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
