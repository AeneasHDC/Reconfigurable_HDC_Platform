
/**
 * @file tb.cpp
 * @brief Test bench for High-Level Synthesis (HLS) and SystemVerilog
 *
 * This file contains the main test bench used for the evaluation of HLS
 * and SystemVerilog implementation of High-Dimentional Computing.
 * The methodologies and results derived from this test bench are
 * discussed in detail in our accompanying research paper
 *
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

#include <iostream>
#include <vector>
#include <numeric>
#include <fstream>
#include <sstream>
#include <hls_stream.h>

// Standard library includes
#include <cstdlib>
#include <cstdio>
#include <cstdint>
#include <ctime>
#include <cstring>
#include <fstream>
#include <thread>
#include <iostream>

// Project-specific includes
#include "../lib/headers/ConfusionMatrix.hpp"
#include "../lib/headers/DataQuantizer.hpp"
#include "../lib/headers/FileWriter.hpp"
#include "../lib/headers/CSVReader.hpp"
#include "../lib/headers/CSVWriter.hpp"
#include "../headers/datatypes.hpp"
#include "../headers/main.hpp"
#include "./../../../config/hls_configs.hpp"
#include "../headers/definitions.hpp"
#include "./../../../config/config_cpp.hpp"

//#include "tb_modules.hpp"


// Third-party libraries
#include "ap_axi_sdata.h"


AXI_STREAM sdata_i;                ///< Input stream providing data to the HDV engine.

dataf_in_p_t df_i;                 ///< Data structure holding input data for HDV processing.

sys_status_t status_o;             ///< Output data structure that provides information about the current system status.

bhv_p_t bhv_i;                     ///< Input data structure containing base hyperdimensional vectors.

lhv_p_t lhv_i;                     ///< Input data structure containing level hyperdimensional vectors.

chv_p_t chv_i;                     ///< Input data structure containing class hyperdimensional vectors.
chv_t chv_o;                     ///< Output data structure containing class hyperdimensional vectors.

frame_in_t frame_in;               ///< Input data structure that holds information about the current frame being processed.

if_axi_cmd_t axi_if_cmd;
if_axi_data_t axi_if_data;

bool nrst_i = RESET_ENABLED;       ///< Reset input signal for HDV engine.

op_mode_t op_mode_i;
uint16_t lr_in;
bool permutation_repeat;
uint16_t beta;
uint32_t error_rate;
uint8_t  n_gram_idx;


typedef struct {
	#if ( TRAIN_ON_HW )
			#if ( HD_DATA_TYPE == BINARY && RETRAIN_ON_HW == 0 && PROBLEM_TYPE != PROBLEM_TYPE_REGRESSION )	// ADDED 
    			ap_uint<HD_BUNDLE_W_BITS> cvh1[HD_DIM];
			#else
    			ap_int<HD_BUNDLE_W_BITS> cvh1[HD_DIM];
			#endif
	#else
			#if ( HD_DATA_TYPE == BINARY && RETRAIN == 0 && PROBLEM_TYPE != PROBLEM_TYPE_REGRESSION)							// ADDED 
    			ap_uint<CV_DATA_W_BITS> cvh1[HD_DIM];
			#else
    			ap_int<CV_DATA_W_BITS> cvh1[HD_DIM];
			#endif
	#endif
} chv_mem_t;

chv_mem_t chv_mem[DS_CLASSES_SIZE];
#if (PROBLEM_TYPE == PROBLEM_TYPE_CLUSTERING)
	chv_mem_t chv_mem2[DS_CLASSES_SIZE];
#endif
pred_class_t pred_class_o; ///< Output data structure that holds the results of the class prediction made by the HDV engine.
int32_t pred_value_o;
pred_class_t lable_class_i; ///< class label for training


/**
 * @brief Executes the HDV engine.
 *
 * This function calls the HDV engine based on the selected HDL language.
 */
void run_HdlProcessing()
{
#if HDL_LANGUAGE == HLS
	   hdv_engine(
			nrst_i,
			op_mode_i,
			frame_in,
			#if IN_DATA_MODE == DI_M_STREAM
				sdata_i,
			#elif ( IN_DATA_MODE == DI_M_PARTIAL_PARALLEL || IN_DATA_MODE == DI_M_PARALLEL )
				df_i,
			#endif

			#if ( CV_MODE  == CV_M_INT_MEM )
				chv_i,
				#if ( TRAIN_ON_HW )
				&chv_o,
				#endif
			#endif
			#if ( BV_MODE  == BV_M_INT_MEM )
				 bhv_i,
			#endif
			#if ( LV_MODE == LV_M_INT_MEM )
			     lhv_i,
			#endif

			#if ( AXI_CNTR_PORT_EN )
				axi_if_cmd,
				&axi_if_data,
			#endif

			#if ( TRAIN_ON_HW )
				lable_class_i,
			#endif
			
			#if ( LR_DECAY == LR_ITER )//ADDED
				lr_in,
			#endif

			#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM || N_GRAM == 1 )//ADDED
				permutation_repeat,
			#endif

			#if ( N_GRAM == 1 )
				n_gram_idx,
			#endif

			#if ( PROBLEM_TYPE != PROBLEM_TYPE_REGRESSION)
				&pred_class_o,
			#else
				&pred_value_o,
			#endif
			&status_o

	   );
   #elif HDL_LANGUAGE == SYSTEM_VERILOG
   {
	   // Implement code for the SYSTEM_VERILOG language here
   }
   #endif
}


void save_chv_mem_to_csv(const char* filename, chv_mem_t* chv_mem, int size) {
    CSVWriter<int> csvWriter(filename);

    for (int i = 0; i < size; ++i) {
        std::vector<int> rowData(std::begin(chv_mem[i].cvh1), std::end(chv_mem[i].cvh1));
        csvWriter.writeRow(rowData);
    }

    csvWriter.closeFile(); // Close the file when done.
}


/**
 * @brief Main function to execute the HDV engine test harness.
 *
 * Initializes required data structures, reads the CSV files for data sets and labels,
 * processes the data, and calls the HDV engine for classification. The function
 * iterates over the data, performs the required operations based on the defined modes.
 *
 * @return int Execution status: 0 if successful, -1 otherwise.
 */
int main( )
{

	#if ( PROBLEM_TYPE == PROBLEM_TYPE_CLASSIFICATION || PROBLEM_TYPE == PROBLEM_TYPE_CLUSTERING )
    	ConfusionMatrix confusionMatrix(DS_CLASSES_SIZE); 	// Confusion matrix for evaluation, defined just for classification problems.
	#endif
	#ifndef COSIM
    	FileWriter file_res_out(TB_HLS_METRIC_FILE_OUT);	// File writer for test results.
	#endif

	// Pointers to CSVReader objects. Used for reading datasets and labels.
	CSVReader<float>* file_ds_ptr = nullptr; 	// Pointer for dataset
	CSVReader<int>* file_label_ptr = nullptr; 	// Pointer for labels

    // Open CSV files for reading datasets and labels.
    CSVReader<float> file_ds_test(TB_DS_TEST_DATA_FILE);
    CSVReader<int> file_ds_test_label(TB_DS_TEST_LABELES_FILE);
    CSVReader<float> file_ds_train(TB_DS_TRAIN_DATA_FILE);
    CSVReader<int> file_ds_train_label(TB_DS_TRAIN_LABELES_FILE);
    CSVReader<float> file_ds_validate(TB_DS_VALIDATION_DATA_FILE);
	CSVReader<int> file_ds_validate_label(TB_DS_VALIDATION_LABELES_FILE);

    std::vector<float> data_ds_test_vec;
    std::vector<int> data_ds_label_vec;

	// Vectors for reading BV, LV, and CV from memory (used when BV_MODE, LV_MODE, and CV_MODE are set to *_M_INT_MEM)
    std::vector<int> datalvh;
    std::vector<int> databvh;
    std::vector<int> datacvh;

	// Performance evaluation variables
    int n_of_data = 0;
	int corrected_data=0;
	double mse = 0;


    // Loading class vector from CSV file.
    CSVReader<int> file_cvh(TB_CLASSHVS_FILE);
	for ( int i = 0; i < DS_CLASSES_SIZE; i++ ){
		datacvh = file_cvh.readRow();

		// Validate the data size.
		if ( datacvh.size() > HD_DIM )
		{
			std::cout << "Error: More columns in CSV file than expected (datacvh.size() > HD_DIM)!" << std::endl;
			return -1;
		}
		for ( int j = 0; j < HD_DIM; j++ ){
			chv_mem[i].cvh1[j] = datacvh[j];
			//printf("Assigning: %d",datacvh[j]);
			#if (PROBLEM_TYPE==PROBLEM_TYPE_CLUSTERING && TRAIN_ON_HW)
				chv_mem2[i].cvh1[j] = datacvh[j];
			#endif
		}
	}
	#if ( CV_MODE  == CV_M_INT_MEM )
		file_cvh.closeFile();
	#endif

	// RESET: the HDL engine is reset
    nrst_i = RESET_ENABLED;
    run_HdlProcessing();
    nrst_i = RESET_DISABLED;

	// Initializations: the HDL engine is initialized
	#if ( AXI_CNTR_PORT_EN )
		axi_if_cmd.id = 1;
		axi_if_cmd.req = 1;
	#endif
	error_rate=0;
	beta=0;
	
    run_HdlProcessing();		
	n_gram_idx=0;


	// Set the tasks to be executed by the hardware model.
	// The hardware model can be selectively configured to execute one or more of the following tasks:
	// - OP_MODE_TRAINING: Training mode
	// - OP_MODE_RETRAIN:  Retraining mode
	// - OP_MODE_TESTING:  Testing mode
	// The tasks are defined in the hls_configs.hpp file. 

	#ifdef COSIM
		// If COSIM is defined, set tasks for testing mode only
		int tasks[] = { OP_MODE_TESTING };
	#else
		#if TRAIN_ON_HW
			#if PROBLEM_TYPE == PROBLEM_TYPE_CLUSTERING
				int tasks[] = { OP_MODE_TRAINING };
			#elif RETRAIN_ON_HW
				int tasks[] = { OP_MODE_TRAINING, OP_MODE_RETRAIN, OP_MODE_TESTING };
			#else
				int tasks[] = { OP_MODE_TRAINING, OP_MODE_TESTING };
			#endif
		#elif RETRAIN_ON_HW
			int tasks[] = { OP_MODE_RETRAIN, OP_MODE_TESTING };
		#else
			int tasks[] = { OP_MODE_TESTING };
		#endif
	#endif

	// Iterate over the required tasks and execute them.
    for ( int task_ind = 0; task_ind < sizeof(tasks)/sizeof(tasks[0]) ; task_ind++ )
    {
		// Set the current task.
    	op_mode_i.mode = tasks[task_ind]; 

		
		// Extract the number of data points to be processed based on the current task.
		// ---INFERENCE MODE---
		if ( op_mode_i.mode == OP_MODE_TESTING )					
		{
			#ifdef COSIM
					n_of_data = 3;									// When COSIM is defined, only 3 data points are processed, for testing purposes.
			#else
				#if ( N_GRAM == 1 )									// Temporal encoding technique
					n_of_data = DS_TEST_SIZE - N_GRAM_SIZE + 1;		
					if ( n_of_data < 0 )
						n_of_data=1;
				#else
					n_of_data = DS_TEST_SIZE;						// Normal encoding technique (Spatial encoding)
				#endif
			#endif
			file_ds_ptr     = &file_ds_test;						// Pointer to the Test Dataset
			file_label_ptr  = &file_ds_test_label; 					// Pointer to the Test labels
			op_mode_i.phase = PHASES_INFERENCE_NORMAL;				// Set the phase to PHASES_INFERENCE_NORMAL
		}
		// ---TRAINING MODE---
		else if ( op_mode_i.mode == OP_MODE_TRAINING )				
		{
			#if ( N_GRAM == 1 )										// Temporal encoding technique
				n_of_data   = DS_TRAIN_SIZE - N_GRAM_SIZE + 1;		
			#else
				n_of_data   = DS_TRAIN_SIZE;						// Normal encoding technique (Spatial encoding)
			#endif
			file_ds_ptr     = &file_ds_train; 						// Pointer to the Training Dataset
			file_label_ptr  = &file_ds_train_label; 				// Pointer to the Training labels
			op_mode_i.phase = PHASES_TRAIN_NORMAL;					// Set the phase to PHASES_TRAIN_NORMAL
		}
		// ---RETRAINING MODE---
		else if ( op_mode_i.mode == OP_MODE_RETRAIN )				
		{
			#if ( N_GRAM == 1 )										// Temporal encoding technique
				n_of_data   = DS_VALIDATION_SIZE - N_GRAM_SIZE + 1;	
			#else
				n_of_data   = DS_VALIDATION_SIZE;					// Normal encoding technique (Spatial encoding)
			#endif

			file_ds_ptr     = &file_ds_validate; 					// Pointer to the Validation Dataset
			file_label_ptr  = &file_ds_validate_label;  			// Pointer to the Validation labels
			op_mode_i.phase = PHASES_RETRAIN_NORMAL;
		}

		// Read the first data point from the CSV files.
		data_ds_test_vec = file_ds_ptr->readRow();
		data_ds_label_vec = file_label_ptr->readRow();


		// Generate Quantization Levels, exactly as the AeneasHDC Software Library
		std::vector<float> levelList;
		float step = (float)(DS_DATA_RANGE_MAX - DS_DATA_RANGE_MIN) / (HD_LV_LEN);
		for (int i = 0; i < HD_LV_LEN; ++i) {
			levelList.push_back(DS_DATA_RANGE_MIN + i * step);
		}


		// Iterate over the data points and process them, calling the HDV engine.
		for (int test_idx = 0; test_idx < n_of_data; test_idx++)
		{

			// Read and quantize data from the CSV file.
			data_ds_test_vec = file_ds_ptr->readRow();
			std::vector<int> data_ds_vec_q = DataQuantizer::quantize(data_ds_test_vec, levelList);

			

			// Read the label from the CSV file.
			data_ds_label_vec = file_label_ptr->readRow();
			if (data_ds_label_vec.empty()) {
				std::cout << "Error: The data_ds_label_vec is empty." << std::endl;
				return -1;
			}

			// Initializations
			uint8_t retrain_en_flg=0;
			permutation_repeat=0;

			//// ENCODING PHASE ////////////////////////////////////////////////////////////////////////////////
			ENCODING_LABEL:																	// This label is used when performing retraining
			for ( int frame_id = 0; frame_id < HD_DIM; frame_id+=DI_PARALLEL_W_BITS )
			{

				// When training the model, the CVs are updated at each iteration.
				#if (PROBLEM_TYPE == PROBLEM_TYPE_CLASSIFICATION)
					if ( op_mode_i.mode == OP_MODE_TRAINING )
					{
						for ( int j = 0; j < CV_IN_DATA_W_BITS; j++ ){
							chv_i.el[0].cvh1[j] = chv_mem[static_cast<int>(data_ds_label_vec[0])].cvh1[j+frame_id];
						}
					}
				#endif
				// Since the classification is a supervised learning problem, the class label is provided to the HDV engine.
				if ( op_mode_i.mode == OP_MODE_TRAINING || op_mode_i.mode == OP_MODE_RETRAIN )
				{
					lable_class_i.c1 = data_ds_label_vec[0];		
				}

				// Set the frame ID. The frame ID is used to identify the current frame being processed and
				// eanbles the HDV engine to process the data in parallel.
				// Look at Element-level Parallelism in the reference paper.
				frame_in.id = (frame_id == 0) ? frame_id : frame_id/DI_PARALLEL_W_BITS;

				// Process feature data.
				#if ( ENCODING_TECHNIQUE==ENCODING_RECORD && BV_MODE == BV_M_INT_MEM )
					CSVReader<int> file_bvh( TB_BASEHVS_FILE );
				#endif


				// In the encoding phase, the HDV engine is recieving the features data.
				// The features data is processed in parallel, based on the defined parallelism (PARALLELISM_FEATURES)
				// Look at Feature-level Parallelism in the reference paper.
				frame_in.type = FRAME_IN_TYPE_FEATURES;

				#if N_GRAM==1																							
				for ( int feature_id = 0; feature_id < DS_FEATURE_SIZE*N_GRAM_SIZE; feature_id+=PARALLELISM_FEATURES )	// Temporal encoding technique
				{
				#else																									// Spatial encoding technique
				for ( int feature_id = 0; feature_id < DS_FEATURE_SIZE; feature_id+=PARALLELISM_FEATURES )
				{
				#endif
					frame_in.index = feature_id;
					
					//printf("In TB --> processing feature:%d\n",feature_id);
					int end_index;

					#if N_GRAM==1 
						if ( feature_id+PARALLELISM_FEATURES > DS_FEATURE_SIZE*N_GRAM_SIZE )
							end_index = DS_FEATURE_SIZE-feature_id;
						else
							end_index= PARALLELISM_FEATURES;
					#else
						if ( feature_id+PARALLELISM_FEATURES > DS_FEATURE_SIZE ){
							end_index = DS_FEATURE_SIZE-feature_id;
						}else{
							end_index= PARALLELISM_FEATURES;
						}
					#endif

					AXI_VALUE aValue;
					for ( int feature_p_id = 0; feature_p_id < end_index; feature_p_id+=1 )
					{
						#if ( IN_DATA_MODE == DI_M_STREAM )
						{
							// Streaming mode.							
							aValue.data = data_ds_vec_q[ feature_id + feature_p_id ];
							aValue.last = ( feature_id + feature_p_id == DS_FEATURE_SIZE - 1 );
							sdata_i.write( aValue );
						}
						#else
						{
							// Parallel mode.
							df_i.d1[feature_p_id].d1[frame_in.index] = static_cast<ap_uint<8>>(data_ds_vec_q[feature_id + feature_p_id]);
						}
						#endif


						// For each quantized feature, read the corresponding LV from memory.
						#if ( LV_MODE == LV_M_INT_MEM )
						{
							#if ( LV_MODE == LV_M_INT_MEM )
							{
								CSVReader<int> file_lvh(TB_LEVELHVS_FILE);
								for ( int i = -1; i < data_ds_vec_q[ feature_id + feature_p_id ]; i++ )
									datalvh = file_lvh.readRow();
								file_lvh.closeFile();
							}
							#endif

							// Validate data size.
							if ( datalvh.size() > HD_DIM )
							{
								std::cout << "Error: More columns in CSV file than expected (datalvh.size() > HD_DIM)!" << std::endl;
								return -1;
							}
						}
						#endif

						// For each feature, read the corresponding index BV from memory. (Only for the Record encoding technique)
						#if ( ENCODING_TECHNIQUE==ENCODING_RECORD && BV_MODE == BV_M_INT_MEM )			
						{
							#if N_GRAM==1																
							if ( n_gram_idx == 0 )														
							{																			
							#endif																		
								databvh = file_bvh.readRow();
							#if N_GRAM==1																
							}																			
							#endif																		

							// Validate data size.
							if ( databvh.size() > HD_DIM )
							{
								std::cout << "Error: More columns in CSV file than expected (databvh.size() > HD_DIM)!" << std::endl;
								return -1;
							}
						}
						#endif

						// Send the data to the HDV engine.
						#if ( LV_MODE == LV_M_INT_MEM )
						{
							// Process the data.
							for ( int i = 0; i < DI_PARALLEL_W_BITS; i++ )
							{
								lhv_i.el[feature_p_id].lvh[i] = datalvh[ frame_id + i ];
							}
						}
						#endif
						#if ( ENCODING_TECHNIQUE==ENCODING_RECORD && BV_MODE == BV_M_INT_MEM ) // MODIFIED
						{
							// Process data based on its value.
							for ( int i = 0; i < DI_PARALLEL_W_BITS; i++ )
							{
								bhv_i.el[feature_p_id].bvh[i] = databvh[ frame_id + i ];
							}
						}
						#endif

					}

					// Call the engine through the run_HdlProcessing function
					run_HdlProcessing();

					// TODO: Check if the parallelism features work when N_GRAM is enabled
					#if ( N_GRAM == 1 )							
					{
						n_gram_idx += PARALLELISM_FEATURES;		
						if ( n_gram_idx > N_GRAM_SIZE - 1 ){
							n_gram_idx=0;
						}


					}
					#endif										
				}
				#if N_GRAM==1
					n_gram_idx=0;
				#endif

				#if ( ENCODING_TECHNIQUE==ENCODING_RECORD && BV_MODE  == BV_M_INT_MEM )	
					file_bvh.closeFile();
				#endif


				///////// INFERENCE PHASE //////////////////////////////////////////////////////////////////
				// In the inference phase, the HDV engine is receiving the class vector.
				// The class vector is processed in parallel, based on the defined parallelism (PARALLELISM_CLASS)
				// Look at Class-level Parallelism in the reference paper.
				// -----
				// Note 1:
				// When using the Spatial N-Gram encoding or the temporal encoding, a permutation of the HV is required:
				// To do this frame elements per time, the first frame must be repeated at the end of the encoding.
				// This does not apply to the Record encoding technique or when the element-level parallelism is equal to HD_DIM.
				// -----
				// Note 2:
				// When performing retrain and the prediction is wrong, the encoding frame should be repeated, 
				// in order to update the class vector without storing the entire encodedHV.
				// -----
				#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM || N_GRAM == 1 )				
					if ( frame_id != 0 || permutation_repeat )							
					{
				#endif
						if ( (PROBLEM_TYPE==PROBLEM_TYPE_CLUSTERING && op_mode_i.mode == OP_MODE_TRAINING) || op_mode_i.mode == OP_MODE_TESTING || (op_mode_i.mode == OP_MODE_RETRAIN && retrain_en_flg==0) )	
						{
							frame_in.type = FRAME_IN_TYPE_CLASS;
							
							for ( int class_id = 0; class_id < DS_CLASSES_SIZE; class_id+=PARALLELISM_CLASS )
							{
								frame_in.index = class_id ;
								for ( int class_p_id = 0; class_p_id < PARALLELISM_CLASS; class_p_id+=1 )
								{
									// Check the CV_M_INT_MEM and read class hyperdimensional vectors.
									#if ( CV_MODE == CV_M_INT_MEM )
									{
										// printf("TB CLASS: [");
										for ( int i = 0; i < DI_PARALLEL_W_BITS; i++ )
										{
											//printf("loading the frame of CLASS\n");
											chv_i.el[class_p_id].cvh1[i] = chv_mem[class_id].cvh1[frame_id + i]; 
											// printf("%d ", chv_mem[class_id].cvh1[frame_id + i]);
										}
										// printf("]\n");
									}
									#endif
								}

								// Call the run_HdlProcessing function
								run_HdlProcessing();
							}
						}

				// After processing the entire HV once, lets go back to the first frame when a permutation is required.
				#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM || N_GRAM == 1 )													
				if ( op_mode_i.mode == OP_MODE_RETRAIN && ((frame_id == 0 && permutation_repeat ) && retrain_en_flg==0 ))	
				{
				#elif ( PROBLEM_TYPE == PROBLEM_TYPE_CLUSTERING )
				if ( op_mode_i.mode == OP_MODE_TRAINING && (frame_id == ( HD_DIM - DI_PARALLEL_W_BITS ) && retrain_en_flg==0 ) )
				{
				#else
				if ( op_mode_i.mode == OP_MODE_RETRAIN && (frame_id == ( HD_DIM - DI_PARALLEL_W_BITS ) && retrain_en_flg==0 ))
				{
				#endif
					#if ( PROBLEM_TYPE == PROBLEM_TYPE_CLASSIFICATION ) 
						if ( static_cast<int>( data_ds_label_vec[0] ) != static_cast<int>( pred_class_o.c1 ) )
						{
					#endif
						retrain_en_flg=1;
						printf("going back to encoding..\n");
						goto ENCODING_LABEL;
					#if ( PROBLEM_TYPE == PROBLEM_TYPE_CLASSIFICATION ) 
						}	
					#endif						
				}																											
				
				# if (PROBLEM_TYPE == PROBLEM_TYPE_CLASSIFICATION)
					if ( op_mode_i.mode == OP_MODE_TRAINING )
					{						
						for ( int j = 0; j < CV_IN_DATA_W_BITS; j++ ){
							chv_mem[static_cast<int>( data_ds_label_vec[0])].cvh1[frame_id+j] = chv_o.cvh1[j];
						}
					}	
				#endif

				// CLUSTERING TRAIN
				#if ( PROBLEM_TYPE == PROBLEM_TYPE_CLUSTERING  )
				if ( retrain_en_flg==1 && op_mode_i.mode == OP_MODE_TRAINING )
				{

					// printf("Updating the memory. Prediction: %d\n", pred_class_o.c1);
					op_mode_i.phase = PHASES_CLUSTERING_UPDATE;
					frame_in.id = (frame_id == 0) ? frame_id : frame_id/DI_PARALLEL_W_BITS;			// ADDED
					#if ( CV_MODE == CV_M_INT_MEM )
					{
						for ( int i = 0; i < DI_PARALLEL_W_BITS; i++ )
						{
							chv_i.el[0].cvh1[i] = chv_mem2[static_cast<int>( pred_class_o.c1 )].cvh1[frame_id + i];
						}
					}
					#endif
					
					// Call the run_HdlProcessing function
					run_HdlProcessing();
			
					for ( int j = 0; j < CV_IN_DATA_W_BITS; j++ ){
						chv_mem2[static_cast<int>( pred_class_o.c1 )].cvh1[frame_id+j] = chv_o.cvh1[j];
					}
					op_mode_i.phase= PHASES_TRAIN_NORMAL;
				}				
				#endif

				
				//// RETRAIN PHASE ////////////////////////////////////////////////////////////////////////////////
				if (  retrain_en_flg==1 && op_mode_i.mode == OP_MODE_RETRAIN )	// MODIFIED
				{

					// Print the correct and predicted class
					printf("lable_class_i.c1: %d, data_ds_label_vec[0]: %d, pred_class_o.c1:%d\n", lable_class_i.c1,data_ds_label_vec[0],pred_class_o.c1); 
					lable_class_i.c1 = data_ds_label_vec[0];				
					std::cout << static_cast<int>( data_ds_label_vec[0] ) << ":" << static_cast<int>( pred_class_o.c1 ) << std::endl;

					//------------------------------------------------------------------------------------------
					// RETRAIN PHASE 1: subtract the encoded HV from the wrong class vector
					op_mode_i.phase = PHASES_RETRAIN_SUBTRACTION;
					frame_in.id = (frame_id == 0) ? frame_id : frame_id/DI_PARALLEL_W_BITS;			// ADDED
					#if ( CV_MODE == CV_M_INT_MEM )
					{
						for ( int i = 0; i < DI_PARALLEL_W_BITS; i++ )
						{
							chv_i.el[0].cvh1[i] = chv_mem[static_cast<int>( pred_class_o.c1 )].cvh1[frame_id + i];
						}
					}
					#endif

					// Iteration-dependent Learning rate
					#if LR_DECAY==LR_ITER
					{
						error_rate += (corrected_data*100*1000)/DS_VALIDATION_SIZE;
						printf("error_rate: %d", error_rate);
						if ( beta++ == BETA_LR-1 )
						{

							lr_in = error_rate/BETA_LR;
							beta=0;
							error_rate=0;
							if ( lr_in > MAX_LEARNING_RATE ){
								lr_in=MAX_LEARNING_RATE;
							}
						}
					}
					#endif
					
					// Call the run_HdlProcessing function
					run_HdlProcessing();

					for ( int i = 0; i < CV_IN_DATA_W_BITS; i++ )
					{
						chv_mem[static_cast<int>( pred_class_o.c1 )].cvh1[frame_id+i] = chv_o.cvh1[i];
					}
					//------------------------------------------------------------------------------------------

					//------------------------------------------------------------------------------------------
					// RETRAIN PHASE 2: Add the encoded HV to correct class vector
					op_mode_i.phase = PHASES_RETRAIN_ADDIOTION;
					frame_in.id = (frame_id == 0) ? frame_id : frame_id/DI_PARALLEL_W_BITS;			// ADDED
					#if ( CV_MODE == CV_M_INT_MEM )
					{
						for ( int i = 0; i < DI_PARALLEL_W_BITS; i++ )
						{
							chv_i.el[0].cvh1[i] = chv_mem[static_cast<int>( data_ds_label_vec[0] )].cvh1[frame_id + i];
						}
					}
					#endif

					// Call the run_HdlProcessing function
					run_HdlProcessing();

					for ( int i = 0; i < CV_IN_DATA_W_BITS; i++ ){
						chv_mem[static_cast<int>( data_ds_label_vec[0])].cvh1[frame_id+i] = chv_o.cvh1[i];
					}

					op_mode_i.phase = PHASES_RETRAIN_NORMAL;		//ADDED
					//------------------------------------------------------------------------------------------

				}


				//////////////////////////////////////////////////////////////////////////////////
				#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM || N_GRAM == 1 )		//ADDED ->
					}
					if ( permutation_repeat )
					{
						break;
					}
				#endif
			}
			#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM || N_GRAM == 1 )
				if ( !permutation_repeat )
				{
					permutation_repeat=1;
#if VERBOS >= VERBOS_L2
					printf("Finished, repeating encoding of the first frame\n");
#endif
					goto ENCODING_LABEL;
				}
			#endif																// <-ADDED



			//// PERFORMANCE EVALUATION //////////////////////////////////////////////////////////////////
			#if ( PROBLEM_TYPE == PROBLEM_TYPE_CLASSIFICATION || PROBLEM_TYPE == PROBLEM_TYPE_CLUSTERING )
				confusionMatrix.updateMatrix( static_cast<int>( data_ds_label_vec[0] ), static_cast<int>( pred_class_o.c1 ) );
			#endif

			int progress_count = (test_idx * 20) / (n_of_data-1);
			if ( op_mode_i.mode==OP_MODE_TRAINING )		// MODIFIED
			{
				#if ( PROBLEM_TYPE == PROBLEM_TYPE_CLASSIFICATION )
					std::cout << "Running Training...Pattern index: " << test_idx << ", Pattern Label: "<< lable_class_i.c1<< ", Percentage: " << std::min((int)(((double)test_idx / (n_of_data-1)) * 100), 100) << "%" << std::endl;
					std::cout << "[" << std::string(progress_count, '#') << std::string(20 - progress_count, '-') << "]" << std::endl;
				#else
					std::cout << "Running Training...Pattern index: " << test_idx << ", Original Group in the Dataset: "<< data_ds_label_vec[0] << ", Assigned cluster*: "<< pred_class_o.c1 << ", Percentage: " << std::min((int)(((double)test_idx / (n_of_data-1)) * 100), 100) << "%" << std::endl;
					std::cout << "[" << std::string(progress_count, '#') << std::string(20 - progress_count, '-') << "]" << std::endl;
				#endif
			}
			else if ( op_mode_i.mode == OP_MODE_RETRAIN ) // ADDED
			{
				std::cout << "Running RETraining...Pattern index: " << test_idx << ", Percentage: " << std::min((int)(((double)test_idx / (n_of_data-1)) * 100), 100) << "%" << std::endl;
				std::cout << "[" << std::string(progress_count, '#') << std::string(20 - progress_count, '-') << "]";

				if ( static_cast<int>( data_ds_label_vec[0] ) != static_cast<int>( pred_class_o.c1 ) )
				{
					std::cout << " ---> Predicted class: " << pred_class_o.c1 << " Real class: " << data_ds_label_vec[0] <<"...correction of CHVs.."<<std::endl;
					std::cout << "Correction performed during RETRAIN: " << ++corrected_data << std::endl;
				}
				else
					std::cout << std::endl;
			}
			else
			{
				#if ( PROBLEM_TYPE == PROBLEM_TYPE_CLASSIFICATION )
					std::cout << "Test index: " << test_idx << ", Correct Label: "<< data_ds_label_vec[0] << ", Predicted: "<< pred_class_o.c1 << ", Percentage: " << std::min((int)(((double)test_idx / (n_of_data-1)) * 100), 100) << "%" << std::endl;
					std::cout << "[" << std::string(progress_count, '#') << std::string(20 - progress_count, '-') << "]" << std::endl;
				
					std::vector<float> metrics = confusionMatrix.calculateMetrics();
			
					// Print the metrics
					std::cout << "Accuracy: "  << metrics[0] << std::endl;
					std::cout << "Precision: " << metrics[1] << std::endl;

				#elif ( PROBLEM_TYPE == PROBLEM_TYPE_CLUSTERING )
					std::cout << "Test index: " << test_idx << ", Original Group in the Dataset: "<< data_ds_label_vec[0] << ", Assigned cluster*: "<< pred_class_o.c1 << ", Percentage: " << std::min((int)(((double)test_idx / (n_of_data-1)) * 100), 100) << "%" << std::endl;
					std::cout << "[" << std::string(progress_count, '#') << std::string(20 - progress_count, '-') << "]" << std::endl;

					std::vector<float> metrics = confusionMatrix.calculateMetrics();
					// Print the metrics
					std::cout << "Accuracy: "  << metrics[0] << std::endl;
					std::cout << "Precision: " << metrics[1] << std::endl;

				#elif ( PROBLEM_TYPE == PROBLEM_TYPE_REGRESSION)
					float error = data_ds_label_vec[0] - pred_value_o;
					mse+=error*error;
					
					std::cout << "Test index: " << test_idx << ", Real Value: "<< data_ds_label_vec[0] << ", Predicted Value: "<< pred_value_o << ", Error: "<<error<< "Percentage: " << std::min((int)(((double)test_idx / (n_of_data-1)) * 100), 100) << "%" << std::endl;
					std::cout << "[" << std::string(progress_count, '#') << std::string(20 - progress_count, '-') << "]" << std::endl;
					
				#endif
			}


		}


		#if PROBLEM_TYPE== PROBLEM_TYPE_REGRESSION
			mse=mse/DS_TEST_SIZE;
			std::cout << "MSE: "  << mse/100 << std::endl;
		#endif

		// Clipping class vector after train
		// MODIFIED-->
		if ( (op_mode_i.mode == OP_MODE_TRAINING && RETRAIN_ON_HW == 0 ) || (op_mode_i.mode == OP_MODE_RETRAIN) && CLIPPING_CLASS != CLIPPING_DISABLE )
		{

			int previous_phase = op_mode_i.phase;
			op_mode_i.phase = PHASES_TRAIN_CLIPPING_ON_TRAIN;

			for ( int frame_id = 0; frame_id < HD_DIM; frame_id+=DI_PARALLEL_W_BITS )
			{
				frame_in.id = (frame_id == 0) ? frame_id : frame_id/DI_PARALLEL_W_BITS;

				for ( int class_id = 0; class_id < DS_CLASSES_SIZE; class_id+=PARALLELISM_CLASS )
				{
					lable_class_i.c1 = class_id;
					#if ( CV_MODE == CV_M_INT_MEM )
					{
						for ( int i = 0; i < DI_PARALLEL_W_BITS; i++ )
						{
							chv_i.el[0].cvh1[i] = chv_mem[class_id].cvh1[frame_id + i];
						}
					}
					#endif

					// Call the run_HdlProcessing function
					run_HdlProcessing();

					 //update the class vector
					for ( int j = 0; j < CV_IN_DATA_W_BITS; j++ ){
						chv_mem[static_cast<int>(class_id)].cvh1[frame_id+j] = chv_o.cvh1[j];
					}

				}
			}
			op_mode_i.phase = previous_phase;
		}
		// <- MODIFIED



		#if (PROBLEM_TYPE == PROBLEM_TYPE_CLASSIFICATION)
			// Save the class vector to a CSV file.
			if ( op_mode_i.mode == OP_MODE_TRAINING || op_mode_i.mode == OP_MODE_RETRAIN )
			{
				save_chv_mem_to_csv( TB_CLASSHVS_FILE, chv_mem, DS_CLASSES_SIZE );
			}
		#elif ( PROBLEM_TYPE == PROBLEM_TYPE_CLUSTERING )
			printf("*NOTE!! -> Cluster assignments need not match original labels, but should group same-label elements together.");
			if ( op_mode_i.mode == OP_MODE_TRAINING)
			{
				// Save the class vector to a CSV file.
				printf("Clustering complete: saving the class vector to a CSV file.\n");
				// print the initial memory and the new one
				printf("Initial memory:\n");
				for ( int i = 0; i < DS_CLASSES_SIZE; i++ ){
					printf("Class %d: [", i);
					for ( int j = 0; j < HD_DIM; j++ ){
						printf("%d ", chv_mem[i].cvh1[j]);
					}
					printf("]\n");
				}
				printf("New memory:\n");			
				for ( int i = 0; i < DS_CLASSES_SIZE; i++ ){
					printf("Class %d: [", i);
					for ( int j = 0; j < HD_DIM; j++ ){
						printf("%d ", chv_mem2[i].cvh1[j]);
					}
					printf("]\n");
				}
				save_chv_mem_to_csv( TB_CLASSHVS_FILE, chv_mem2, DS_CLASSES_SIZE );
			}
		#endif

    }



	#ifndef COSIM

		// Save results.
		#if ( PROBLEM_TYPE==PROBLEM_TYPE_CLASSIFICATION || PROBLEM_TYPE==PROBLEM_TYPE_CLUSTERING )
			file_res_out.writeMetrics(confusionMatrix.calculateMetrics());
			file_res_out.writeConfusionMatrix(confusionMatrix);
			file_res_out.closeFile();
		#elif (PROBLEM_TYPE==PROBLEM_TYPE_REGRESSION)
			file_res_out.writeMSE(mse);
			file_res_out.closeFile();
		#endif

	#endif
	
	// Close files.
	file_ds_test.closeFile();
	file_ds_test_label.closeFile();
	file_ds_train.closeFile();
	file_ds_train_label.closeFile();

	return 0;
}




