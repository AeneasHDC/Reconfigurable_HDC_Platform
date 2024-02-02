/**
 * @file definitions.hpp
 * @brief
 *
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


#ifndef _DEFINITIONS_H_
#define _DEFINITIONS_H_

#define RELATIVE_PATH_MAIN_HEADER "./../../../../../"

#define TB_PATH_EXPORT_PARAMS  "./../../../../../out/extracted_params/"
#define TB_PATH_EXPORT_DATASET "./../../../../../out/dataset/"
#define TB_PATH_EXPORT_HLS_OUT "./../../../../../out/hls/"

#if N_GRAM==0
    #define TB_DS_TEST_DATA_FILE            (TB_PATH_EXPORT_DATASET DS_NAME "/test_data.csv")
    #define TB_DS_TEST_LABELES_FILE         (TB_PATH_EXPORT_DATASET DS_NAME "/test_label.csv")
    #define TB_DS_TRAIN_DATA_FILE           (TB_PATH_EXPORT_DATASET DS_NAME "/train_data.csv")
    #define TB_DS_TRAIN_LABELES_FILE        (TB_PATH_EXPORT_DATASET DS_NAME "/train_label.csv")
    #define TB_DS_VALIDATION_DATA_FILE      (TB_PATH_EXPORT_DATASET DS_NAME "/validation_data.csv")
    #define TB_DS_VALIDATION_LABELES_FILE   (TB_PATH_EXPORT_DATASET DS_NAME "/validation_label.csv")
#else
    #define TB_DS_TEST_DATA_FILE            (TB_PATH_EXPORT_DATASET DS_NAME "/n_gram_test_data.csv")
    #define TB_DS_TEST_LABELES_FILE         (TB_PATH_EXPORT_DATASET DS_NAME "/n_gram_test_labels.csv")
    #define TB_DS_TRAIN_DATA_FILE           (TB_PATH_EXPORT_DATASET DS_NAME "/n_gram_train_data.csv")
    #define TB_DS_TRAIN_LABELES_FILE        (TB_PATH_EXPORT_DATASET DS_NAME "/n_gram_train_labels.csv")
    #define TB_DS_VALIDATION_DATA_FILE      (TB_PATH_EXPORT_DATASET DS_NAME "/validation_data.csv")
    #define TB_DS_VALIDATION_LABELES_FILE   (TB_PATH_EXPORT_DATASET DS_NAME "/validation_label.csv")
#endif

#define TB_HLS_METRIC_FILE_OUT  (TB_PATH_EXPORT_HLS_OUT "/hls_report.json")

#define TB_BASEHVS_FILE  (TB_PATH_EXPORT_PARAMS DS_NAME "/baseHVs.csv")
#define TB_LEVELHVS_FILE (TB_PATH_EXPORT_PARAMS DS_NAME "/levelHVs.csv")
#define TB_CLASSHVS_FILE (TB_PATH_EXPORT_PARAMS DS_NAME "/ClassHVs.csv")

// Test module selection
/** @brief Disable test modules. */
#define TB_TEST_MODULES_DISABLE 0
/** @brief Use random generator for test modules. */
#define TB_TEST_MODULES_RANDOM_GEN 1
/** @brief Base vectors test module. */
#define TB_TEST_MODULES_BASE_VECTORS 2
/** @brief Binding test module. */
#define TB_TEST_MODULES_BINDING 3
/** @brief Bunding test module. */
#define TB_TEST_MODULES_BUNDING 4
/** @brief Level vectors test module. */
#define TB_TEST_MODULES_LEVEL_VECTORS 5
/** @brief Complete encoding procedure */
#define TB_TEST_MODULES_ENCODING 6

/** @brief Selected test module for the current build. */
#define TB_SELECTED_TEST_MODULE TB_TEST_MODULES_DISABLE

#define TB_TEST_INTEGRATED_DISABLE 0
#define TB_TEST_INTEGRATED_M1 1
#define TB_SELECTED_TEST_INTEGRATED TB_TEST_INTEGRATED_M1

// Scaling factor for similarity measurement
/** @brief Factor used for scaling similarity measures. */
#define SIMILARITY_SCALING_FACTOR 10000
#define LR_SCALING_FACTOR 10


#define RND_REM_FIRST_BITS 3

// Status codes
/** @brief Status code indicating success. */
#define SUCCESS 1
/** @brief Status code indicating failure. */
#define FAILED  !SUCCESS

#define RESET_ENABLED  0
#define RESET_DISABLED !RESET_ENABLED

#endif


