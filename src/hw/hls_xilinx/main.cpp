/**
 * @file main.cpp
 * @brief Main driver for the HDV (Hyperdimensional Vector) Engine.
 * @details The primary task of this module is to manage and execute the processing of hyperdimensional vectors
 * (HVs) based on the HDC (Hyperdimensional Computing) methodology. It interacts with the HDC library to handle
 * various operations and ensures efficient and accurate processing of the HDVs.
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

// Standard library includes
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

// Project-specific includes
#include "headers/main.hpp"
#include "lib/headers/rnd.hpp"
#include "lib/hdc_lib/HDC_class.hpp"
#include "headers/data.hpp"
#include "headers/datatypes.hpp"
#include "headers/definitions.hpp"
#include "./../../config/config_cpp.hpp"
#include "./../../config/ex_config.hpp"

// Third-party libraries
#include <hls_stream.h>
#include "ap_axi_sdata.h"


/**
 * @brief Main HDV (Hyperdimensional Vector) Engine function.
 *
 * This function processes input data in the form of hyperdimensional vectors (HVs) and performs operations
 * on them according to the HDC (Hyperdimensional Computing) approach. The function takes in various inputs
 * such as reset, data frame, base vector, and level vector. It processes the inputs and produces outputs
 * such as the predicted class and system status.
 *
 * @param nrst_i Reset input signal. A boolean reference indicating whether to reset the system.
 * @param frame_in Data frame input, holding the type, and identifier of the frame being processed.
 * @param df_i Data frame input. An AXI stream or data frame reference, depending on IN_DATA_MODE.
 * @param cv_i Codebook vector input (only if CV_MODE is internal memory).
 * @param bv_i Base vector input (only if BV_MODE is internal memory).
 * @param lv_i Level vector input (only if LV_MODE is internal memory).
 * @param pred_class_o Pointer to output for predicted class. A pointer to a data structure holding the result of the classification.
 * @param status_o Pointer to output for system status. A pointer to a data structure holding the status of the system.
 *
 * @return void
 *
 * @details The function performs several operations on HVs, including binding, bundling, and encoding. It uses the
 * HDC_op class to handle arithmetic operations in the hyperspace. The function calculates the similarity between
 * HVs and determines the predicted class based on maximum similarity. It also handles system reset and status
 * updates.
 */
void hdv_engine(

    bool &nrst_i,
	op_mode_t op_mode_i,
	frame_in_t frame_in,

    #if IN_DATA_MODE == DI_M_STREAM
        AXI_STREAM& sdata_i,
    #elif ( IN_DATA_MODE == DI_M_PARTIAL_PARALLEL || IN_DATA_MODE == DI_M_PARALLEL )
		dataf_in_p_t &df_i,
    #endif

	#if ( CV_MODE  == CV_M_INT_MEM )
		chv_p_t &chv_i,
		#if ( TRAIN_ON_HW )
			chv_t *chv_o,
		#endif
	#endif

    #if ( BV_MODE  == BV_M_INT_MEM )
        bhv_p_t &bhv_i,
    #endif

    #if ( LV_MODE == LV_M_INT_MEM )
        lhv_p_t &lhv_i,
    #endif

	#if ( AXI_CNTR_PORT_EN )
		if_axi_cmd_t &axi_if_cmd,
		if_axi_data_t *axi_if_data,
	#endif

	#if ( TRAIN_ON_HW )
		pred_class_t &lable_class_i,
	#endif

	#if ( LR_DECAY == LR_ITER )
		uint16_t &lr_in,
	#endif

	#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM || N_GRAM == 1 )
		bool &permutation_repeat,
	#endif

	#if ( N_GRAM == 1 )
		uint8_t &n_gram_idx,
	#endif

	#if ( PROBLEM_TYPE != PROBLEM_TYPE_REGRESSION)
    	pred_class_t *pred_class_o,
	#else
		int32_t *pred_value_o,
	#endif
	sys_status_t *status_o


)
{

    #pragma HLS INTERFACE ap_none port = nrst_i

	#if ( IN_DATA_MODE == DI_M_STREAM )
		#pragma HLS INTERFACE axis port = sdata_i depth = PARALLELISM_FEATURES
	#else
		#pragma HLS INTERFACE ap_none port = df_i
		#pragma HLS AGGREGATE compact = bit variable = df_i
	#endif

	#if ( CV_MODE  == CV_M_INT_MEM )
		#pragma HLS INTERFACE ap_none port = chv_i
	#endif
    #if ( BV_MODE  == BV_M_INT_MEM )
		#pragma HLS INTERFACE ap_none port = bhv_i
    #endif
    #if ( LV_MODE == LV_M_INT_MEM )
		#pragma HLS INTERFACE ap_none port = lhv_i
    #endif

	#if ( AXI_CNTR_PORT_EN )
		#pragma HLS INTERFACE mode=s_axilite port  = axi_if_cmd
		#pragma HLS AGGREGATE compact=bit variable = axi_if_cmd
		#pragma HLS INTERFACE mode=s_axilite port  = axi_if_data
		#pragma HLS AGGREGATE compact=bit variable = axi_if_data
	#endif

	#if ( PROBLEM_TYPE != PROBLEM_TYPE_REGRESSION)
		#pragma HLS INTERFACE ap_none port         = pred_class_o
		#pragma HLS AGGREGATE compact=bit variable = pred_class_o
	#else
		#pragma HLS INTERFACE ap_none port         = pred_value_o
		#pragma HLS AGGREGATE compact=bit variable = pred_value_o
	#endif

	#if ( LR_DECAY == LR_ITER )
		#pragma HLS INTERFACE ap_none port     = lr_in
	#endif

	#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM || N_GRAM == 1 )
		#pragma HLS INTERFACE ap_none port         = permutation_repeat
		#pragma HLS AGGREGATE compact=bit variable = permutation_repeat
	#endif

	#if ( N_GRAM == 1 )
		#pragma HLS INTERFACE ap_none port         = n_gram_idx
		#pragma HLS AGGREGATE compact=bit variable = n_gram_idx
	#endif

	#pragma HLS INTERFACE ap_none port         = status_o
	#pragma HLS AGGREGATE compact=bit variable = status_o

	AXI_VALUE _aValue[PARALLELISM_FEATURES];

    bhv_t _bhv;
    lhv_t _lhv;
    chv_t _chv;
    chv_t _chv_o;

    bhv_p_t _bhv_i;
    lhv_p_t _lhv_i;
    chv_p_t _chv_i;
    uint8_t _n_gram_idx;
    static pred_class_t _pred_class_o;
	static int32_t _pred_value_o;
    static sys_status_t _status;
	int64_t lr;


	// Instantiate HDC_op class, to support arithmetic operations in the hyperspace
	static HDC_op<HD_DATA_W_BITS,HD_DATA_W_BITS,DI_PARALLEL_W_BITS> HDC;

    static HV_CLASS BundledHV;
	static HV_CLASS Clipped_BundledHV;									// ADDED 
    static HV Encoded_HV;
    static ap_int<HD_SIMI_W_BITS> similarity_classes[DS_CLASSES_SIZE];

	#if ( HD_SIMI_METHOD == SIMI_COS ) // ADDED 
		static ap_uint<HD_SIMI_W_BITS> denom_a_classes[DS_CLASSES_SIZE];
		static ap_uint<HD_SIMI_W_BITS> denom_b_classes[DS_CLASSES_SIZE];
	#endif

    static HV Binded_Features;
	static HV Permuted_HV;

    int64_t similarity_max = 0;
	

#if ( AXI_CNTR_PORT_EN )
    static ap_uint<IF_CMD_ID_BWIDTH>  _axi_if_cmd_id = 0;
    static if_axi_data_t _axi_if_data;
#endif
    ///  added for training
    static bunded_clip_t bunded_train_chv[DS_CLASSES_SIZE];

	// ADDED for performing HVs permutations (rotations), both for N_gram encoding and temporal sequences
	#if ENCODING_TECHNIQUE==ENCODING_NGRAM  
		static PermuteArray shifted_bits[DS_FEATURE_SIZE] = {{0}};
	#endif

	#if N_GRAM==1
		static PermuteArray shifted_bits[N_GRAM_SIZE] = {{0}};
	#endif




	#pragma HLS ARRAY_PARTITION variable = _bhv_i complete
	#pragma HLS ARRAY_PARTITION variable = _lhv_i complete
	#pragma HLS ARRAY_PARTITION variable = _chv_i complete
	#pragma HLS ARRAY_PARTITION variable = _bhv complete
	#pragma HLS ARRAY_PARTITION variable = _lhv complete
	#pragma HLS ARRAY_PARTITION variable = _chv complete
	#pragma HLS ARRAY_PARTITION variable = _n_gram_idx complete
	#pragma HLS ARRAY_PARTITION variable = BundledHV complete
	#pragma HLS ARRAY_PARTITION variable = Clipped_BundledHV complete		
	#pragma HLS ARRAY_PARTITION variable = Encoded_HV complete
	#pragma HLS ARRAY_PARTITION variable = similarity_classes complete
	#pragma HLS ARRAY_PARTITION variable = Binded_Features complete
	#pragma HLS dependence variable      = BundledHV type=inter distance=1 true		
	#pragma HLS dependence variable      = Clipped_BundledHV type=inter distance=1 true			// ADDED
	#pragma HLS dependence variable      = similarity_classes type=inter distance=16 true
	#pragma HLS dependence variable      = similarity_max type=inter distance=16 true


	#pragma HLS INLINE

    ____reset:
	{
		#pragma HLS INLINE recursive
		if ( nrst_i == RESET_ENABLED )
		{
			#if IN_DATA_MODE == DI_M_STREAM
				while ( sdata_i.empty() == 0 )
				{
					sdata_i.read( _aValue[0] );
				}
			#endif

			_pred_class_o.c1 = 0;

			for(auto i = 0; i < DS_CLASSES_SIZE; i++)
			{
				bunded_train_chv[i]   = 0;
				#if ( HD_SIMI_METHOD == SIMI_COS ) // ADDED 
					denom_a_classes[i]    = 0;
					denom_b_classes[i]    = 0;
				#endif
				similarity_classes[i]     = 0;     // ADDED 
			}

			goto exit;
		}
	}


	____read_inputs:
	{
		#pragma HLS INLINE
		#if ( CV_MODE  == CV_M_INT_MEM )
			_chv_i = chv_i;
		#endif
		#if ( BV_MODE  == BV_M_INT_MEM )
			_bhv_i = bhv_i;
		#endif
		#if ( LV_MODE == LV_M_INT_MEM )
			_lhv_i = lhv_i;
		#endif
		#if ( N_GRAM == 1 )
			_n_gram_idx = n_gram_idx;
		#endif

		_chv = _chv_i.el[0]; // With enabling train on hardware we can not use parallelism on associate search


		#if IN_DATA_MODE == DI_M_STREAM && LV_MODE != LV_M_INT_MEM
		{
			for ( auto feature_p_id = 0; feature_p_id < PARALLELISM_FEATURES; feature_p_id+=1 )
			{
				#pragma HLS PIPELINE
				if ( sdata_i.empty() == 0 )
				{
					sdata_i.read( _aValue[feature_p_id] );
				}
			}
		}
		#elif IN_DATA_MODE != DI_M_STREAM && LV_MODE != LV_M_INT_MEM
		{
			_aValue[feature_p_id].value = df_i.d1[feature_p_id];
		}
		#endif
	}


	check_cmd:{
	#if ( AXI_CNTR_PORT_EN )
			if ( axi_if_cmd.id != _axi_if_cmd_id ){
				_axi_if_cmd_id = axi_if_cmd.id;

				if ( axi_if_cmd.req == 1 ){
					_axi_if_data = 10;
				}
			}
	#endif
	}


    main:
	{
		#pragma HLS INLINE recursive

		#if (TRAIN_ON_HW || RETRAIN_ON_HW)

		// Clipping of the trained CVs
		if ( op_mode_i.phase == PHASES_TRAIN_CLIPPING_ON_TRAIN ) // CHANGED
		{
				int32_t threshold = bunded_train_chv[lable_class_i.c1]/2;							// ADDED
				HDC.clip( _chv.cvh1, _chv_o.cvh1, QUANT_MIN, QUANT_MAX, threshold, CLIPPING_CLASS);	// CHANGED 
				goto exit;
		}
		#endif

		#if ( RETRAIN_ON_HW )
		{
			//--------- Retrain Mode ---------
			if ( op_mode_i.mode == OP_MODE_RETRAIN )
			{
				// Retrain phase 1: Subtraction correction
				if ( op_mode_i.phase == PHASES_RETRAIN_SUBTRACTION )
				{
					// Learning rate Control - ADDED
					#if ( LR_DECAY==LR_DATA )
						lr = (similarity_classes[_pred_class_o.c1] - similarity_classes[lable_class_i.c1])/LR_SCALING_FACTOR;
					#elif ( LR_DECAY == LR_ITER )
						lr = lr_in;
					#endif

					#if ( LR_DECAY == LR_DATA || LR_DECAY == LR_ITER )
						if ( lr > MAX_LEARNING_RATE ){
							lr = MAX_LEARNING_RATE;
						}
						else if ( lr == 0 ){
							lr = 1;
						}
					#endif

					// Clipping control - ADDED
					if ( frame_in.id == 0 )
					{
						#if ( LR_DECAY == LR_DATA || LR_DECAY == LR_ITER )
							bunded_train_chv[_pred_class_o.c1]-=lr;
						#else
							bunded_train_chv[_pred_class_o.c1]-=1;
						#endif
					}

					for ( auto i = 0; i < DI_PARALLEL_W_BITS; i++ )
					{
						#if ( LR_DECAY == LR_DATA || LR_DECAY == LR_ITER )
							_chv_o.cvh1[i] = _chv.cvh1[i] - lr*Clipped_BundledHV[i];
						#else
							_chv_o.cvh1[i] = _chv.cvh1[i] - Clipped_BundledHV[i];
						#endif
					}					
					goto exit;
				}
				else if ( op_mode_i.phase == PHASES_RETRAIN_ADDIOTION )
				{
					
					// Learning rate Control
					#if ( LR_DECAY==LR_DATA )
						lr = (similarity_classes[_pred_class_o.c1] - similarity_classes[lable_class_i.c1])/LR_SCALING_FACTOR;
					#elif ( LR_DECAY == LR_ITER )
						lr = lr_in;
					#endif

					#if ( LR_DECAY == LR_DATA || LR_DECAY == LR_ITER )
						if ( lr > MAX_LEARNING_RATE ){
							lr = MAX_LEARNING_RATE;
						}
						else if ( lr == 0 ){
							lr = 1;
						}
					#endif

					// Clipping control 
					if ( frame_in.id == 0 ) 
					{
						#if ( LR_DECAY == LR_DATA || LR_DECAY == LR_ITER )
							bunded_train_chv[lable_class_i.c1] += lr;
						#else
							bunded_train_chv[lable_class_i.c1]++;
						#endif
					}

					for ( auto i = 0; i < DI_PARALLEL_W_BITS; i++ )
					{
						#if ( LR_DECAY == LR_DATA || LR_DECAY == LR_ITER )				//ADDED
							_chv_o.cvh1[i] = _chv.cvh1[i] + lr*Clipped_BundledHV[i];	//ADDED
						#else
							_chv_o.cvh1[i] = _chv.cvh1[i] + Clipped_BundledHV[i];
						#endif										
					}				
					goto exit;
				}
			}
		}
		#endif

		// Train in Clustering problems: 
		// each encoded HV is added to the most similar classHV
		// The updated classHV memory is saved and replace the current one only at the next iteration epoch
		#if ( PROBLEM_TYPE == PROBLEM_TYPE_CLUSTERING )
		{		
			//--------- Retrain Mode ---------
			if ( op_mode_i.mode == OP_MODE_TRAINING )
			{			
				// Retrain phase 1: Subtraction correction
				if ( op_mode_i.phase == PHASES_CLUSTERING_UPDATE )
				{					
					for ( auto i = 0; i < DI_PARALLEL_W_BITS; i++ )
					{
						_chv_o.cvh1[i] = _chv.cvh1[i] + Clipped_BundledHV[i];
					}
										
					goto exit;
				}
			}
		}
		#endif

		auto _frame_index = frame_in.index;
		if ( frame_in.type == FRAME_IN_TYPE_FEATURES )
		{
			process_features:
			{
				#pragma HLS INLINE recursive
				auto paralled_feature_inx_end = PARALLELISM_FEATURES;
				#if (DS_FEATURE_SIZE % PARALLELISM_FEATURES != 0)
				{
					if ( frame_in.index + PARALLELISM_FEATURES > DS_FEATURE_SIZE ){
						paralled_feature_inx_end = DS_FEATURE_SIZE - frame_in.index - PARALLELISM_FEATURES;
					}else{
						paralled_feature_inx_end= PARALLELISM_FEATURES;
					}
				}
				#endif

				for ( auto feature_p_id = 0; feature_p_id < paralled_feature_inx_end; feature_p_id+=1 )
				{
					#pragma HLS UNROLL

					_frame_index = frame_in.index + feature_p_id;
					#pragma HLS INLINE recursive
					for ( auto state = 0; state < 2; state++)
					{
						#pragma HLS PIPELINE II = 5

						switch(state)
						{
						case 0:
							____phase_1_read_or_gen_HV_parameters:
							{
								#pragma HLS INLINE recursive
								#if ( ENCODING_TECHNIQUE==ENCODING_RECORD && BV_MODE  == BV_M_INT_MEM )
								{

									_bhv = _bhv_i.el[feature_p_id];

								}
								#else
									if ( _frame_index == 0 && frame_in.id == 0 )
									{
										HDC.rnd_gen_bhv_reset();
									}
									____SUB_generate_BV_by_rnd_gen:
									{
										HDC.generate_BaseHVs( _bhv.bvh );
									}
								#endif


								#if ( LV_MODE == LV_M_INT_MEM )
								{
									_lhv = _lhv_i.el[feature_p_id];

								}
								#else
								{
									HDC.generate_LevelHVs( _lhv.lvh, frame_in.id, _aValue[feature_p_id].data );
								}
								#endif
								//printf( "0frame_in.id: %d, frame_in.index: %d, _lhv:\n", frame_in.id, _aValue.data );
								//HDC.print_HV(_lhv.lvh );
							}
							____phase_2_process_input_features:
							{
								#pragma HLS INLINE recursive
								#if ( ENCODING_TECHNIQUE == ENCODING_RECORD )
								{	
									// Spatial encoding through RECORD BASED encoding
									HDC.bind( _lhv.lvh, _bhv.bvh, Binded_Features );
									
									// Temporal encoding after Record based
									#if ( N_GRAM == 1 )
										#if VERBOS>=VERBOS_L2
											printf("Permuting the binded HV by %d positions --> Feature: %d, Frame: %d, n_gram_idx: %d, permutation_repeat:%d, \n", _n_gram_idx, _frame_index, frame_in.id, _n_gram_idx, permutation_repeat);
											printf("\nInitial LHV : [");
											for (int i=0;i<DI_PARALLEL_W_BITS;i++)
												printf("%d, ", Binded_Features[i]);

											printf("]\nInitial shifted_bits: [");
											for (int i=0;i<N_GRAM_SIZE;i++)
												printf("%d, ", shifted_bits[_frame_index][i]);
										#endif
										HDC.permute(Binded_Features, _n_gram_idx, shifted_bits[_frame_index], Permuted_HV);
										
										#if VERBOS>=VERBOS_L2
										printf("]\nFinal shifted_bits: [");
										for (int i=0;i<N_GRAM_SIZE;i++)
											printf("%d, ", shifted_bits[_frame_index][i]);

											printf("]\nPermuted LHV: [");
											for (int i=0;i<DI_PARALLEL_W_BITS;i++)
												printf("%d, ", Permuted_HV[i]);
											printf("]\n--------------\n");

											
										#endif
										for (int i=0;i<DI_PARALLEL_W_BITS;i++)
											Binded_Features[i] = Permuted_HV[i];
																
									#endif
								}
								#else 
								{
									// N-GRAM BASED encoding
									#if VERBOS >= VERBOS_L2
										printf("positions: %d", _frame_index);
										printf("\nInitial LHV : [");
										for (int i=0;i<DI_PARALLEL_W_BITS;i++)
											printf("%d, ", _lhv.lvh[i]);
										printf("]\nInitial shifted_bits: [");
										for (int i=0;i<DS_FEATURE_SIZE;i++)
											printf("%d, ", shifted_bits[_frame_index][i]);
									#endif


									HDC.permute(_lhv.lvh, _frame_index, shifted_bits[_frame_index], Binded_Features);
									
									#if VERBOS >= VERBOS_L2
										printf("]\nFinal shifted_bits: [");
										for (int i=0;i<DS_FEATURE_SIZE;i++)
											printf("%d, ", shifted_bits[_frame_index][i]);

										
										printf("]\nPermuted LHV: [");
										for (int i=0;i<DI_PARALLEL_W_BITS;i++)
											printf("%d, ", Binded_Features[i]);
										printf("]\n--------------\n");
									#endif
								}
								#endif //<- ADDED
								

							}
						break;
						case 1:


							____phase_3_bundling:
							{
								#pragma HLS INLINE recursive
								// // N-gram index control
								// #if ( N_GRAM == 1 )
								// 	if ( n_gram_idx == N_GRAM_SIZE-1)										
								// 		n_gram_idx=0;
								// 	else
								// 		n_gram_idx = n_gram_idx + 1;									
								// #endif
								if ( _frame_index == 0 )
								{
									____sub_bunding:
									{
										#pragma HLS INLINE recursive

										for(auto i = 0; i < DI_PARALLEL_W_BITS; i++)
										{
											#pragma HLS UNROLL
											hv_class_t tmp_chv_val;

											// CHANGED
											#if ( HD_DATA_TYPE == BIPOLAR )
												if (Binded_Features[i] == 0)
												{
													BundledHV[i] = -1;
												}else{
													BundledHV[i] = 1;
												}
											#else
												if (Binded_Features[i] == 0)
												{
													BundledHV[i] = 0;
												}else{
													BundledHV[i] = 1;
												}
											#endif
										
										}
									}

								}else
								{
									____sub_bundling:
									{
										#pragma HLS INLINE recursive
										#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM  || N_GRAM == 1 )
										#if VERBOS >= VERBOS_L2
											//printf("sub_bundlign_phase. Pattern: %d, n_gram_idx: %d, permutation_repeat:%d, \n", frame_in.id, n_gram_idx, permutation_repeat);
										#endif
											if ( frame_in.id != 0 || permutation_repeat)
											{
										#endif

										HDC.bundle(Binded_Features, BundledHV);

										#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM || N_GRAM == 1 )	
												if (permutation_repeat)
												{
													// Cleaning the buffer used for permutations
													#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM )
														for(auto i = 0; i < DS_FEATURE_SIZE; i++)
															shifted_bits[frame_in.index][i]=0;												
													#endif

													#if ( N_GRAM == 1 )
														// Cleaning the buffer used for permutations
														for(auto i = 0; i < N_GRAM_SIZE; i++)
															shifted_bits[frame_in.index][i]=0;															
													#endif
												}
											}
											


										#endif
									}
								}
							}
							break;
						}
					}
				}

				#if ( TRAIN_ON_HW )
					if ( op_mode_i.mode == OP_MODE_TRAINING)
					{
						#if N_GRAM==1
							if ( _frame_index==(DS_FEATURE_SIZE*N_GRAM_SIZE - 1) && frame_in.id == 0 && !permutation_repeat )
						#elif (ENCODING_TECHNIQUE == ENCODING_NGRAM )
							if ( _frame_index==(DS_FEATURE_SIZE - 1) && frame_in.id == 0 && !permutation_repeat )
						#else
							if ( _frame_index==(DS_FEATURE_SIZE - 1) && frame_in.id == 0 )
						#endif
							{
								bunded_train_chv[lable_class_i.c1]++;
								#if VERBOS >= VERBOS_L2
								printf("train bunded_train_chv[%d]: %d\n", lable_class_i.c1,bunded_train_chv[lable_class_i.c1]);
								// printf("Bundled_train_CHV[%d]: %d", lable_class_i,bunded_train_chv[lable_class_i.c1] );
								#endif
							}

					}
				#endif
			}
			____phase_4_clipping:
			{
				#pragma HLS INLINE
				#if N_GRAM==1
				if ( _frame_index == (DS_FEATURE_SIZE*N_GRAM_SIZE) - 1 )

				#else
				if ( _frame_index == DS_FEATURE_SIZE - 1 )
				#endif
				{


					#if VERBOS >= VERBOS_L2
						// DEBUG: keep it for now
						printf("Bundled_HV: [");
						for(auto i = 0; i < DI_PARALLEL_W_BITS; i++)
						{
							printf("%d, ", BundledHV[i]);
						}
						printf("]\n");
					#endif

					#if N_GRAM==1
						HDC.clip( BundledHV, Clipped_BundledHV, QUANT_MIN, QUANT_MAX, DS_FEATURE_SIZE * N_GRAM_SIZE / 2 , CLIPPING_ENCODING );
					#else
						HDC.clip( BundledHV, Clipped_BundledHV, QUANT_MIN, QUANT_MAX, DS_FEATURE_SIZE / 2, CLIPPING_ENCODING );
					#endif

					#if VERBOS >= VERBOS_L2
						//DEBUG: keep it for now			
						printf("CLIPPED_HV: [");
						for(auto i = 0; i < DI_PARALLEL_W_BITS; i++)
						{
							printf("%d, ", Clipped_BundledHV[i]);
						}
						printf("]\n");
					#endif

					if ( op_mode_i.mode == OP_MODE_TRAINING )
					{
						#if VERBOS >= VERBOS_L2
							// DEBUG: keep it for now				
							printf("INITIAL_CLASSHV: [");
							for(auto i = 0; i < DI_PARALLEL_W_BITS; i++)
							{
								printf("%d, ", _chv.cvh1[i]);
							}
							printf("]\n");
						#endif

						#if ( TRAIN_ON_HW || RETRAIN_ON_HW )					// CHECK; why retrain is here?? we have dedicated addition phase
							for ( auto i = 0; i < DI_PARALLEL_W_BITS; i++ )
							{
								_chv_o.cvh1[i] = _chv.cvh1[i] + Clipped_BundledHV[i];
							}

							#if VERBOS >= VERBOS_L2
								printf("NEW_CLASSHV: [");
								for(auto i = 0; i < DI_PARALLEL_W_BITS; i++)
								{
									printf("%d, ", _chv_o.cvh1[i]);
								}
								printf("]\n");
							#endif
						#endif
					}
				}
			}
		}
		else if ( frame_in.type == FRAME_IN_TYPE_CLASS )
		{
			#if VERBOS >= VERBOS_L2
			 printf("Similarity...\n");
			#endif
			process_associate_search:
			{
				#pragma HLS INLINE recursive
				for ( auto class_p_id = 0; class_p_id < PARALLELISM_CLASS; class_p_id+=1 )
				{
					#pragma HLS UNROLL
					//#pragma HLS PIPELINE II=5
					_frame_index = frame_in.index + class_p_id;

					#pragma HLS INLINE recursive
					if ( _frame_index < DS_CLASSES_SIZE )
					{
						#if ( CV_MODE  == CV_M_INT_MEM )
						{
							_chv = _chv_i.el[class_p_id];
						}
						#endif

						#if ( CV_MODE  == CV_M_HDL_GEN )
						{
							HDC.generate_ClassHVs( _chv.cvh1, frame_in.id, frame_in.index );
						}
						#endif

						//printf( "frame_in.id: %d,\n", frame_in.id );
						//HDC.print_HV(_chv.cvh1 );

						____similarity_functions:
						{
							#pragma HLS PIPELINE II=5
							#if ( HD_DATA_TYPE == BIPOLAR || RETRAIN == 1 || PROBLEM_TYPE == PROBLEM_TYPE_REGRESSION)		//ADDED
								ap_int<HD_SIMI_W_BITS> similarity= 0;
							#else
								ap_uint<HD_SIMI_W_BITS> similarity= 0;
							#endif
							ap_uint<HD_SIMI_W_BITS> denom_a= 0; ap_uint<HD_SIMI_W_BITS> denom_b = 0;
							
							HDC.similarity_phase1( _chv.cvh1, Clipped_BundledHV, similarity, denom_a, denom_b, op_mode_i.mode );
							#if VERBOS>=VERBOS_L2
							 	printf("PHASE 1 --> similarity[%d]: %d, denom_a: %u, denom_b: %u\n",_frame_index, similarity, denom_a, denom_b );
							#endif

							#if ( HD_SIMI_METHOD == SIMI_COS ) // ADDED ---CHECK
							{
								#if ( ENCODING_TECHNIQUE==ENCODING_NGRAM|| N_GRAM==1 )
									if ( frame_in.id == 1 )
								#else
									if ( frame_in.id == 0 )
								#endif
								{
									#if VERBOS >= VERBOS_L2
										printf("resetting....\n");
									#endif
									similarity_classes[_frame_index]  = similarity;
									denom_a_classes[_frame_index]     = denom_a;
									denom_b_classes[_frame_index]     = denom_b;
								}
								else
								{
									similarity_classes[_frame_index] += similarity;
									denom_a_classes[_frame_index]    += denom_a;
									denom_b_classes[_frame_index]    += denom_b;
								}


							}
							#else
							{

								#if ( ENCODING_TECHNIQUE==ENCODING_NGRAM|| N_GRAM==1 )
									if ( frame_in.id == 1 )
								#else
									if ( frame_in.id == 0 )
								#endif
									{
										#if VERBOS>=VERBOS_L2
										printf("resetting....\n");
										#endif
										similarity_classes[_frame_index] = similarity;

									}else
									{
										similarity_classes[_frame_index] += similarity;
									}

							}
							#endif

						}

						
							#if ( ENCODING_TECHNIQUE == ENCODING_NGRAM || N_GRAM==1 )
								if (_frame_index == DS_CLASSES_SIZE - 1 && frame_in.id==0 && permutation_repeat==1 )
							#else
								if ( _frame_index == DS_CLASSES_SIZE - 1 && frame_in.id == ( HD_DIM/DI_PARALLEL_W_BITS )-1 )
							#endif
							
							{
								
							//printf("we are here with frame_index: %d, frame_in.id: %d, permutaiton_repeat:%d\n", _frame_index, frame_in.id, permutation_repeat);
							____decision:
							{
								#pragma HLS INLINE recursive
								#if (PROBLEM_TYPE==PROBLEM_TYPE_REGRESSION)
								{
									_pred_value_o = similarity_classes[0];
									//printf("internal prediction: %d\n", _pred_value_o);
								}
								#else
								{
									for ( auto i = 0; i < DS_CLASSES_SIZE; i++ )
									{
										#pragma HLS PIPELINE II=DS_CLASSES_SIZE

										#if ( HD_SIMI_METHOD == SIMI_COS ) // ADDED ---CHECK
											HDC.similarity_phase2( similarity_classes[i], denom_a_classes[i], denom_b_classes[i],op_mode_i.mode );
											#if VERBOS>=VERBOS_L2
												printf("PHASE 2--> similarity_classes[%d]: %lli, denom_a_classes: %lli, denom_b_classes: %lli \n",i, similarity_classes[i], denom_a_classes[i], denom_b_classes[i]);
											#endif
										#endif

									}

									for ( auto i = 0; i < DS_CLASSES_SIZE; i++ )
									{
										#pragma HLS PIPELINE II=1
										// printf("similarity_classes[%d]: %d vs similarity_max: %d\n", i, similarity_classes[i], similarity_max);
										if ( similarity_max < similarity_classes[i] )
										{
											#if VERBOS >= VERBOS_L2
												printf("Update similarity_max: %d\n", similarity_classes[i]);
											#endif
											similarity_max = similarity_classes[i];
											_pred_class_o.c1 = i;

										}
									}
								}
								#endif

							}
						
						#if VERBOS >= VERBOS_L2
							printf( "similarity_max:%d\n", similarity_max );
							printf( "_pred_class_o:%d\n", _pred_class_o.c1);
							for ( int i = 0; i < DS_CLASSES_SIZE; i++ ){
								printf( "similarity_classes[%d]:%d\n", i, similarity_classes[i] );
							}
						#endif

						}
					

					}
				}
			}
		}
	}

exit:

#if ( AXI_CNTR_PORT_EN )
	*axi_if_data = _axi_if_data;
#endif
    #if (PROBLEM_TYPE!=PROBLEM_TYPE_REGRESSION)
		*pred_class_o = _pred_class_o;
	#else
		*pred_value_o = _pred_value_o;
	#endif
    *status_o = _status;
	#if ( TRAIN_ON_HW || RETRAIN_ON_HW )
		*chv_o = _chv_o;
	#endif

}
