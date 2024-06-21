/**
 * @file datatypes.hpp
 * @brief
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

#ifndef __DATATYPES_H__
#define __DATATYPES_H__

#include <hls_stream.h>
#include "ap_axi_sdata.h"
#include "./../lib/headers/rnd.hpp"
#include "./../../../config/config_cpp.hpp"
#include "./../../../config/ex_config.hpp"

#if (HD_DATA_TYPE == BINARY && RETRAIN == 0 && PROBLEM_TYPE != PROBLEM_TYPE_REGRESSION)							// ADDED
	typedef ap_uint<HD_BUNDLE_W_BITS> hv_class_t;  //// '--TODO---
#else
	typedef ap_int<HD_BUNDLE_W_BITS> hv_class_t;  //// '--TODO---
#endif
typedef ap_int<32> bunded_clip_t;

// Define the HV type as an array of ap_uint
typedef ap_uint<HD_DATA_W_BITS> HV_HD_DIM[HD_DIM];
typedef ap_uint<HD_DATA_W_BITS> HV[DI_PARALLEL_W_BITS];
typedef ap_uint<HD_DATA_W_BITS+1> HV_OUT[DI_PARALLEL_W_BITS];
typedef hv_class_t HV_CLASS[DI_PARALLEL_W_BITS];
#if N_GRAM==1
typedef ap_uint<HD_DATA_W_BITS> PermuteArray[DS_FEATURE_SIZE*N_GRAM_SIZE]; // ADDED
#else
typedef ap_uint<HD_DATA_W_BITS> PermuteArray[DS_FEATURE_SIZE]; // ADDED
#endif

//int(log2(DS_FEATURE_SIZE)+1)

// Index type for HDV
typedef uint16_t HDVIndex_t;

typedef RndGenerator< CONFIG_BASEHVS_GEN_OUT_BWIDTH, CONFIG_BASEHVS_GEN_N_OF_REM_FBITS,
					  CONFIG_BASEHVS_GEN_B1, CONFIG_BASEHVS_GEN_B2,
					  CONFIG_BASEHVS_GEN_B3, CONFIG_BASEHVS_GEN_B4,
					  CONFIG_BASEHVS_GEN_SEED > rnd_gen_bhv_t;

typedef RndGenerator<CONFIG_LEVELHVS_GEN_OUT_BWIDTH,CONFIG_LEVELHVS_GEN_N_OF_REM_FBITS,
					 CONFIG_LEVELHVS_GEN_B1, CONFIG_LEVELHVS_GEN_B2, CONFIG_LEVELHVS_GEN_B3, CONFIG_LEVELHVS_GEN_B4
					 ,CONFIG_LEVELHVS_GEN_SEED> rnd_lv_approx_gen_t;


#define FRAME_IN_TYPE_FEATURES 0
#define FRAME_IN_TYPE_CLASS    1
typedef struct {
	ap_uint<2> type;
	ap_uint<DI_FEATUREID_W_BITS> index;
	ap_uint<DI_FRAMEID_W_BITS>   id;
} frame_in_t;


// AXI stream definitions
typedef ap_axiu<8,1,1,1> AXI_VALUE;
typedef hls::stream<AXI_VALUE> AXI_STREAM;

/**
 * @struct dataf_in_t
 * @brief  Struct for input data.
 */
typedef struct {
    ap_uint<8> d1[DI_PARALLEL_W_BITS];
} dataf_in_t;

typedef struct {
	dataf_in_t d1[PARALLELISM_FEATURES];
} dataf_in_p_t;

/**
 * @struct pred_class_t
 * @brief  Struct for predicted class.
 */
typedef struct {
    ap_uint<DO_CLASS_W_BITS> c1;
} pred_class_t;

/**
 * @struct sys_status_t
 * @brief  Struct for system status.
 */
typedef struct {
    ap_uint<DO_STATUS_W_BITS> st1;
} sys_status_t;

/**
 * @struct hbv_in_t
 * @brief  Struct for high-dimensional base vector input.
 */
typedef struct {
    ap_uint<BV_DATA_W_BITS> bvh[BV_IN_DATA_W_BITS];
} bhv_t;

typedef struct {
	bhv_t el[PARALLELISM_FEATURES];
} bhv_p_t;

/**
 * @struct hlv_in_t
 * @brief  Struct for high-dimensional level vector input.
 */
typedef struct {
    ap_uint<LV_DATA_W_BITS> lvh[LV_IN_DATA_W_BITS];
} lhv_t;

typedef struct {
	lhv_t el[PARALLELISM_FEATURES];
} lhv_p_t;

/**
 * @struct hcv_in_t
 * @brief  Struct for high-dimensional class vector input.
 */
typedef struct {
	#if ( TRAIN_ON_HW == 1 )
		#if ( HD_DATA_TYPE == BINARY && RETRAIN_ON_HW == 0 && PROBLEM_TYPE != PROBLEM_TYPE_REGRESSION)							// ADDED
    		ap_uint<HD_BUNDLE_W_BITS> cvh1[CV_IN_DATA_W_BITS];
		#else
			ap_int<HD_BUNDLE_W_BITS> cvh1[CV_IN_DATA_W_BITS];
		#endif
	#else
		#if ( HD_DATA_TYPE == BINARY && RETRAIN == 0 && PROBLEM_TYPE != PROBLEM_TYPE_REGRESSION)							// ADDED
    		ap_uint<CV_DATA_W_BITS> cvh1[CV_IN_DATA_W_BITS];
		#else
			ap_int<CV_DATA_W_BITS> cvh1[CV_IN_DATA_W_BITS];
		#endif
	#endif
} chv_t;

typedef struct {
	chv_t el[PARALLELISM_CLASS];
} chv_p_t;


#define IF_AXI_DATA_WIDTH 32

#define IF_CMD_GET_SET_BWIDTH 1
#define IF_CMD_ID_BWIDTH 2
#define IF_CMD_REQ_BWIDTH 13
#define IF_CMD_DATA 16
typedef struct {
	ap_uint<IF_CMD_GET_SET_BWIDTH> get_set;
	ap_uint<IF_CMD_ID_BWIDTH> id;
	ap_uint<IF_CMD_REQ_BWIDTH> req;
	ap_uint<IF_CMD_DATA> data;
}if_axi_cmd_t;
typedef ap_uint<IF_AXI_DATA_WIDTH> if_axi_data_t;



#define OP_MODE_TRAINING	0
#define OP_MODE_RETRAIN		1
#define OP_MODE_TESTING		2

/**
 * @brief Type definition for operation mode.
 *
 * This typedef defines the operation mode: training or testing
 * It is used to represent the current operation mode of the application.
 */

//phases of inference
#define PHASES_INFERENCE_NORMAL 0

//phases of training
#define PHASES_TRAIN_NORMAL 0
#define PHASES_TRAIN_CLIPPING_ON_TRAIN 3 // CHANGED
#define PHASES_CLUSTERING_UPDATE 4

//phases of retrain
#define PHASES_RETRAIN_NORMAL 0
#define PHASES_RETRAIN_SUBTRACTION 1
#define PHASES_RETRAIN_ADDIOTION   2

typedef struct {
	ap_uint<2> mode;
	ap_uint<3> phase;
}op_mode_t;



#endif

