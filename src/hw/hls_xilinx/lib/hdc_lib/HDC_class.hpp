/**
 * @file hdc.hpp
 * @brief Reconfigurable Hyperdimensional Computing (HDC) library.
 * @details This library focuses on providing a comprehensive interface and
 * implementation for HDC operations in a reconfigurable setting. It encompasses
 * various algorithms and utilities that are beneficial for researchers and
 * developers working in the domain of hyperdimensional computing.
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

#ifndef _HDC_CLASS_HPP__
#define _HDC_CLASS_HPP__

// Standard Library Includes
#include <string>
#include <iostream>
#include <stdlib.h>
#include <stdint.h>
#include <fstream>
#include <random>
#include <ctime>

// Third-Party Library Includes
#include "ap_int.h"
#include <hls_math.h>

// Project-Specific Standard Includes
#include "./../../headers/datatypes.hpp"
#include "./../../headers/definitions.hpp"
#include "../../../../config/config_cpp.hpp"

// Project-Specific Library Includes
#include "./../../lib/hdc_lib/operations.hpp"
#include "../headers/rnd.hpp"
#include "../headers/sqrt_approx.hpp"

// Conditional Includes for HDL Generation Modes
#if LV_MODE == LV_M_HDL_GEN
    #include "./../../../../../out/mem_data/hdl_functions/level_hvec_gen_hdl.hpp"
#elif CV_MODE == CV_M_HDL_GEN
    #include "./../../../../../out/mem_data/hdl_functions/class_hvec_gen_hdl.hpp"
#endif


using namespace std;



template < size_t IN_DATA_WIDTH, size_t OUT_DATA_WIDTH, size_t LEN >
class HDC_op
{
	private:


		rnd_gen_bhv_t rnd_gen_bhv;


    public:
		// typedef struct{
		// 	HV_HD_DIM element;
		// }lv_approx_t;

		// lv_approx_t lv_approx[2];


		HDC_op()
		{
			// #if ( LV_MODE == LV_M_LOGIC &&  HD_LV_TYPE == APPROX )
			// {
			// 	init_approx_level_vector_generator();
			// }
			// #endif
		}


		//--------------------------------------------------------------------------------------
		// Similarity calculation functions.
		//--------------------------------------------------------------------------------------

		/**
		 * @brief Compute the similarity between two hypervectors (HVs).
		 *
		 * @details [Detailed description, if necessary]
		 *
		 * @param HV1 Reference to the first hypervector involved in the similarity computation.
		 * @param HV2 Reference to the second hypervector involved in the similarity computation.
		 * @param sim Reference to the variable where the computed similarity value will be stored.
		 * @param denom_a Reference to the variable where the denominator for the first hypervector will be stored.
		 * @param denom_b Reference to the variable where the denominator for the second hypervector will be stored.
		 * @return void
		 */
		template < typename HV1Type, typename HV2Type, typename SimType, typename DenomType >
		void similarity_phase1(const HV1Type &HV1, const HV2Type &HV2, SimType &sim,
		                             DenomType &denom_a, DenomType &denom_b, uint8_t mode ) {



			similarity:{
				#pragma HLS INLINE
				//#pragma HLS LATENCY min=1 max=2


				for ( auto i = 0; i < LEN; i += FRAME_SIZE_MIN )
				{
					//#pragma HLS pipeline II=10
					#pragma HLS unroll
					for ( auto j = 0; j < FRAME_SIZE_MIN; j++ )
					{
						#pragma HLS unroll
						
						#if ( RETRAIN_ON_HW == 1 )
							if ( mode == OP_MODE_RETRAIN )
							{
								sim += HV1[i+j] * HV2[i+j];
								#if ( HD_SIMI_METHOD == SIMI_COS )
								{
									denom_a = denom_a + (HV1[i+j]*HV1[i+j]);
									denom_b = denom_b + (HV2[i+j]*HV2[i+j]); // here we remove the square, since the second HV is bipolar
								}
								#endif
							}
							else
							{
						#endif
						#if ( HD_SIMI_METHOD == SIMI_HAM )
						{
							// Compute similarity using Hamming distance

							if ( HV1[i+j] == HV2[i+j] )
							{
								sim += 1;
							}
						}
						#elif ( HD_SIMI_METHOD == SIMI_COS || HD_SIMI_METHOD == SIMI_DPROD )
						{
							#if ( HD_DATA_TYPE == BINARY )
							{
								#if ( CLIPPING_CLASS == CLIPPING_BINARY )
								{
									if ( HV1[i+j] == HV2[i+j] )
									{
										sim += 1;
									}
									#if ( HD_SIMI_METHOD == SIMI_COS )
									{
										if ( HV1[i+j] == 1 )
										{
											denom_a = denom_a + 1;
										}
										if ( HV2[i+j] == 1 )
										{
											denom_b = denom_b + 1;
										}
									}
									#endif
								}
								/////
								//ADDED
								#elif ( CLIPPING_CLASS == CLIPPING_POWERTWO || CLIPPING_CLASS == CLIPPING_QUANTIZED_POWERTWO)
								{
									// In CLIPPING_POWERTWO mode, all the elements of the hypervector are powers of two.
									// Therefore, the multiplication is replace by a shift operation.
									sim += ((SimType)1 << (HV1[i+j] + HV2[i+j])); // Corrected to sum the exponents

									#if ( HD_SIMI_METHOD == SIMI_COS )
									{
										//denom_a=1;
										if ( HV1[i+j] != 0 ) // ADDED
										{
											denom_a = denom_a + (1 << (HV1[i+j]<<1)); //denom_a = denom_a + (HV1[i+j] << HV1[i+j]);  CHANGED
										}
										denom_b = denom_b + (1 << (HV2[i+j]<<1));    // denom_b = denom_b + (HV2[i+j] << HV2[i+j]); CHANGED
									}
									#endif

									//printf( "sim0:%d,denom_b:%d, denom_a:%d, HV1[i+j]:%d, HV2[i+j]:%d \n", sim, denom_b, denom_a, HV1[i+j], HV2[i+j] );
								/////
								}
								#else
								{
									sim += HV1[i+j] * HV2[i+j];
									//printf("HV1*HV2= %d * %d = %d\n",HV1[i+j], HV2[i+j],HV1[i+j]* HV2[i+j]);
									#if ( HD_SIMI_METHOD == SIMI_COS )
									{
										denom_a = denom_a + (HV1[i+j]*HV1[i+j]);
										denom_b = denom_b + (HV2[i+j]*HV2[i+j]); // here we can remove the square, since the second HV is binary
									}
									#endif
								}
								#endif
							}
							#elif ( HD_DATA_TYPE == BIPOLAR )   ///  CHECK --TODO--
							{
								#if ( CLIPPING_CLASS == CLIPPING_BINARY )
								{
									// Compute similarity for bipolar HVs
									for ( auto i = 0; i < LEN; i++ )
									{
										#pragma HLS unroll
										if ( HV1[i+j] ^ HV2[i+j] == 1 )
										{
											sim -= 1;
										}else
										{
											sim += 1;
										}
									}
								}
								#else	// CHANGED
								{
									// Compute similarity with integer ClassHVs
									sim += HV1[i+j] * HV2[i+j];
									#if ( HD_SIMI_METHOD == SIMI_COS )
									{
										denom_a = denom_a + (HV1[i+j]*HV1[i+j]);
										denom_b = denom_b + (HV2[i+j]*HV2[i+j]); // here we remove the square, since the second HV is bipolar
									}
									#endif
								}
								#endif
							}
							#endif
						}
						#endif
						#if ( RETRAIN_ON_HW == 1 )
						}
						#endif
					}
				}
			}
		}

					





		/**
		 * @brief Compute the second phase of similarity between two hypervectors (HVs).
		 *
		 * @details This function computes the second phase of similarity between two HVs based on the results from the first phase.
		 * It calculates either cosine similarity or Hamming distance, depending on the specified similarity method and data type.
		 *
		 * @param sim Reference to the variable where the computed similarity value from the first phase is stored.
		 * @param denom_a Reference to the variable where the denominator for the first hypervector is stored.
		 * @param denom_b Reference to the variable where the denominator for the second hypervector is stored.
		 * @return void
		 */
		template < typename SimType, typename DenomType >
		void similarity_phase2(SimType &sim, const DenomType &denom_a, const DenomType &denom_b, uint8_t mode)
		{
			#pragma HLS INLINE
			#if ( RETRAIN_ON_HW == 1 )
				
				if ( mode == OP_MODE_RETRAIN )
				{
					#if ( APPROX_SQRT_ON_HW == 0 )
					{

						sim = ( sim * SIMILARITY_SCALING_FACTOR )/( hls::sqrt(denom_b) * hls::sqrt(denom_a) );
					}
					#else
					{
						sim = ( sim * SIMILARITY_SCALING_FACTOR )/(  approx_sqrt(denom_b) * approx_sqrt(denom_a) );
					}
					#endif
				}
				else
				{
			#endif			
		    #if ( HD_SIMI_METHOD == SIMI_COS )
		    {

		        #if ( CLIPPING_CLASS == CLIPPING_BINARY )
				{
					#if (HD_DATA_TYPE == BINARY)
					{
						#if ( APPROX_SQRT_ON_HW == 0 )
						{
									
							sim = ( sim * SIMILARITY_SCALING_FACTOR )/( hls::sqrt(denom_b) * hls::sqrt(denom_a) );
							
						}
						#else
						{
							sim = ( sim * SIMILARITY_SCALING_FACTOR )/(  approx_sqrt(denom_b) * approx_sqrt(denom_a) );
						}
						#endif
					}
					#endif
				}
				#else
				{
					#if ( APPROX_SQRT_ON_HW == 0 )
					{
						#if VERBOS>=VERBOS_L2
							printf( "sim1:%d,denom_b:%llu, denom_a:%llu \n", sim, denom_b, denom_a );
						#endif
						sim = ( sim * SIMILARITY_SCALING_FACTOR )/( hls::sqrt(denom_b) * hls::sqrt(denom_a) );
						#if VERBOS>=VERBOS_L2
							printf( "sim:%d \n", sim );
						#endif
					}
					#else
					{
						sim = ( sim * SIMILARITY_SCALING_FACTOR )/(  approx_sqrt(denom_b) * approx_sqrt(denom_a) );
					}
					#endif
				}
				#endif
		    }
			#if ( RETRAIN_ON_HW == 1 )
			}
			#endif
		    #endif
		}


		//--------------------------------------------------------------------------------------
		// Binding functions.
		//--------------------------------------------------------------------------------------

		/**
		 * @brief Executes the binding operation between two hypervectors (HVs).
		 *
		 * @details The binding operation combines information from two HVs. This function supports two data types: binary and bipolar.
		 * - For binary HVs, the binding operation is performed as a bitwise XOR operation between corresponding bits of the HVs.
		 * - For bipolar HVs, the binding operation is performed as a vector element-wise XNOR operation between corresponding elements of the HVs.
		 *
		 * @note
		 *
		 * @param HV1 The first HV involved in the binding operation.
		 * @param HV2 The second HV involved in the binding operation.
		 * @param Binded_HV Reference to the output HV which stores the result of the binding operation.
		 */
		template < typename HVType >
		void bind( const HVType& HV1, const HVType& HV2, HVType& Binded_HV )
		{

			#pragma HLS ARRAY_PARTITION variable=Binded_HV complete
			bind:{
				#pragma HLS INLINE
				for ( auto i = 0; i < LEN; i++ )
				{
					#pragma HLS UNROLL
					#if ( HD_DATA_TYPE == BINARY )
					{
						Binded_HV[i] = HV1[i] ^ HV2[i];
					}
					#elif ( HD_DATA_TYPE == BIPOLAR )
					{
						if ( HV1[i] ^ HV2[i] == 1 )
						{
							Binded_HV[i] = 0;
						}else
						{
							Binded_HV[i] = 1;
						}
					}
					#endif
				}
			}
		}

		template <typename HVType>
		void permute(const HVType& HV, const ap_uint<DI_FEATUREID_W_BITS> positions, PermuteArray& shifted_bits, HVType& Permuted_HV)
		{
			//#pragma HLS ARRAY_PARTITION variable=Binded_HV complete
			permute: {
				#pragma HLS INLINE

				PermuteArray temp_shifted_bits; // Temporary array to store new shifted bits

				
				for (int i = 0; i < LEN; i++) {
					// printf("\ni: %d, positions: %d, then: ", i, positions);
					if (i < positions) {
						// Save the bits that will be "shifted out" of the current chunk
						temp_shifted_bits[i] = HV[LEN - positions + i];
					}

					if (i >= positions) {
						// Normal shift: take the value from the left
						Permuted_HV[i] = HV[i - positions];
						// printf("assigning from HV\n");
						// printf("Permuted_HV[%d]:%d, cause: HV[i - positions] = HV[%d]: %d\n", i, Permuted_HV[i], i-positions, HV[i - positions]);
					} else {
						// Right shift: take the value from the end of the previous chunk
						Permuted_HV[i] = shifted_bits[i];
						// printf("assigning from shifted_bits\n");
						// printf("Permuted_HV[%d]:%d, cause: shifted_bits[%d]: %d\n", i, Permuted_HV[i], i, shifted_bits[i]);
					}
					// printf("While HV[%d]: %d\n", i, HV[i]);
					
				}

				// Update shifted_bits for the next chunk
				for (auto i = 0; i < positions; i++) {
					shifted_bits[i] = temp_shifted_bits[i];
				}
			}
		}

		//--------------------------------------------------------------------------------------
		// Bundling functions.
		//--------------------------------------------------------------------------------------

		/**
		 * @brief Performs the bundle operation between two hypervectors.
		 *
		 * @details The bundle operation is a crucial component of hyperdimensional computing (HDC),
		 * which combines information from two hypervectors. In this function, the bundling is done
		 * only for bipolar hypervectors. For each element of the input hypervector `HV1`, if the
		 * element is `0`, it decrements the corresponding element of `HV2` by `1`. Otherwise, it
		 * increments the corresponding element of `HV2` by `1`.
		 *
		 * @note
		 *
		 * @param HV1 The input hypervector.
		 * @param HV2 Reference to the hypervector that will be updated by the bundling operation.
		 */
		template < typename HVType, typename HVClassType >
		void bundle( const HVType &HV1, HVClassType &HV2 )
		{
			#pragma HLS ARRAY_PARTITION variable=HV2 complete
			bundle:{
				#pragma HLS INLINE
				//#pragma HLS LATENCY max=1

				// Split the popcount function, using a fixed FRAME_SIZE_MIN popcount
				for ( auto i = 0; i < LEN; i += FRAME_SIZE_MIN )
				{
					//#pragma HLS pipeline II=10
					#pragma HLS unroll
					for ( auto j = 0; j < FRAME_SIZE_MIN; j++ )
					{
						#pragma HLS unroll
						#if ( HD_DATA_TYPE == BINARY )
						{
							#if ( HD_DATA_W_BITS == 1 )
							{
								if ( HV1[i+j]==1 )
								{
									HV2[i+j] = HV2[i+j] + 1;
								}
							}
							#else
							{
								HV2[i+j] = HV2[i+j] + HV1[i+j];
							}
							#endif
						}
						#elif ( HD_DATA_TYPE == BIPOLAR )
						{
							if ( HV1[i+j] == 0 )
							{
								HV2[i+j] -= 1;
							}else
							{
								HV2[i+j] += 1;
							}
						}
						#endif
					}
				}


				
			}



		}


		//--------------------------------------------------------------------------------------
		// Clipping functions.
		//--------------------------------------------------------------------------------------

		/**
		 * @brief Clips a hypervector according to the designated clipping mode.
		 *
		 * @details This function clips the elements of a hypervector based on the mode specified by the `CLIPPING_ENCODING` macro.
		 *          The clipping modes available are binary, ternary, and quantized. In hyperdimensional computing (HDC),
		 *          this operation is essential to normalize the values of bundled hypervectors.
		 *
		 * @tparam HV_i_Type Data type of the input hypervector.
		 * @tparam HV_o_Type Data type of the output hypervector. Allows flexibility in the resultant data type post-clipping.
		 *
		 * @param HV1 The input hypervector subjected to clipping.
		 * @param clipped_HV The hypervector storing the results after clipping.
		 * @param quan_min The minimum permissible value when using quantized clipping mode.
		 * @param quan_max The maximum permissible value when using quantized clipping mode.
		 * @param lfsr_instance An instance of a random number generator, employed in binary clipping.
		 *
		 * @note
		 */
		template < typename HV_i_Type, typename HV_o_Type >
		void clip( const HV_i_Type &HV1, HV_o_Type &clipped_HV, const int16_t& quan_min,
				   const int16_t& quan_max, bunded_clip_t bund, uint8_t clip_mode )
		{
			#pragma HLS ARRAY_PARTITION variable=clipped_HV complete
			clip:{
				
				//printf("Clipping Threshold: %d\n",bund);
				#pragma HLS INLINE
				////#pragma HLS LATENCY max=10

				if ( clip_mode == CLIPPING_DISABLE )
				{
					// printf("\n---Clipping disable ....\n");
					for ( auto i = 0; i < LEN; i++ )
					{
						clipped_HV[i] = HV1[i];
					}
				}
				else if ( clip_mode == CLIPPING_BINARY )
				{
					// printf("\n---Clipping binary....\n");
					for ( auto i = 0; i < LEN; i++ )
					{
						#pragma HLS unroll

						if ( HD_DATA_TYPE == BINARY )
						{
							//printf("Binary....\n");
							if ( HV1[i] == bund  )
							{
								#if ( CLIPPING_BINARY_METHOD_FOR_VALUE_EQ_HALF_HD_DIM == CLIPPING_BINARY_FOR_VALUE_EQ_HALF_HD_DIM_SET_ZERO )
								{
									clipped_HV[i] = 0;
								}
								#elif ( CLIPPING_BINARY_METHOD_FOR_VALUE_EQ_HALF_HD_DIM == CLIPPING_BINARY_FOR_VALUE_EQ_HALF_HD_DIM_USE_RND_GEN )
								{
									lfsr_instance.randomize();
									//bool random_number = lfsr_instance.get_rnd();
									clipped_HV[i] = lfsr_instance.rnd_o & 0x01;
								}
								#elif ( CLIPPING_BINARY_METHOD_FOR_VALUE_EQ_HALF_HD_DIM == CLIPPING_BINARY_FOR_VALUE_EQ_HALF_HD_DIM_USE_TOGGLING )
								{
									static bool tog_val = false;
									clipped_HV[i] = tog_val;
									tog_val = !tog_val;
								}
								#endif
							}
							else
							{

								if (( HV1[i] < bund ))
								{
									clipped_HV[i] = 0;
								}else
								{
									clipped_HV[i] = 1;
								}
							}
						}
						else if ( HD_DATA_TYPE == BIPOLAR ) // CHANGED
						{
							//printf("Bipolar....\n");
							//clipped_HV[i] = ( HV1[i] <= 0 ) ? 0 : 1;
							//printf("HV[%d]: %d ",i,HV1[i]);
							if ( HV1[i] < 0 )
							{
								clipped_HV[i] = -1; 
							}else
							{
								clipped_HV[i] = 1;
							}
							//printf("--> %d\n", clipped_HV[i]);
						}
						// #endif
					}
				}
				else if ( clip_mode == CLIPPING_TERNARY )
				{
					for ( HDVIndex_t i = 0; i < LEN; i++ )
					{
						#pragma HLS unroll
						//clipped_HV[i] = ( HV1[i] < 0 ) ? -1 : (( HV1[i] > 0 ) ? 1 : 0);
						if ( HV1[i] < 0 )
						{
							clipped_HV[i] = -1;
						}else
						{
							if ( HV1[i] > 0 )
							{
								clipped_HV[i] = 1;
							}else{
								clipped_HV[i] = 0;
							}
						}
					}
				}
				else if ( clip_mode == CLIPPING_QUANTIZED )
				{
					for ( HDVIndex_t i = 0; i < LEN; i++ )
					{
						#pragma HLS unroll
						if ( HV1[i] > quan_max )
						{
							clipped_HV[i] = quan_max;
						}else if ( HV1[i] < quan_min ){
							clipped_HV[i] = quan_min;
						}
						//clipped_HV[i] = std::min(std::max(HV1[i], quan_min), quan_max);
					}
				}
				
				
			}
		}



		//--------------------------------------------------------------------------------------
		// Base Vector Generator Functions
		// Utilizes the NOVEL method to generate high-dimensional base vectors using a random generator,
		// as detailed in our publication:
		// "Title of Paper", available at https://doi.org/10.xxxx/yyyyy
		//--------------------------------------------------------------------------------------

		/**
		 * @brief Populates a hypervector with random base values.
		 *
		 * @details This function fills the given hypervector `baseVector` with random values generated
		 *          based on the provided width configurations. It is optimized for synthesis using Vitis HLS.
		 *
		 * @tparam HV_Type Type of the input hypervector.
		 *
		 * @param[out] baseVector The hypervector to be populated with random base values.
		 */
		template < typename HV_Type >
		void generate_BaseHVs( HV_Type& baseVector )
		{
			#pragma HLS ARRAY_PARTITION variable=baseVector complete
			#if ( BV_MODE == BV_M_RND_GEN )
			{
				for ( auto i = 0; i < BV_IN_DATA_W_BITS; i += CONFIG_BASEHVS_GEN_OUT_BWIDTH )
				{
					#pragma HLS unroll
					rnd_gen_bhv.randomize(); // Generate a random number
					for ( auto j = 0; j < CONFIG_BASEHVS_GEN_OUT_BWIDTH; j++ )
					{
						#pragma HLS unroll
						auto index = i + ( CONFIG_BASEHVS_GEN_OUT_BWIDTH - 1 - j );
						baseVector[index] = rnd_gen_bhv.rnd_o[j];
					}
				}
			}
			#endif
		}

		void rnd_gen_bhv_reset(){
			rnd_gen_bhv.reset();
		}


		//--------------------------------------------------------------------------------------
		// Level Vector Generator Functions
		// Implements the NOVEL method for generating high-dimensional level vectors via hardware functions,
		// as detailed in our publication:
		// "Title of Paper", available at https://doi.org/10.xxxx/yyyyy
		//--------------------------------------------------------------------------------------

		/**
		 * @brief Generates high-dimensional level vectors.
		 *
		 * @details When `LV_MODE` is set to `LV_M_HDL_GEN`, this function employs the NOVEL method
		 *          to generate high-dimensional level vectors using hardware functions.
		 *		For Thermometer encoding:
		 *  	the first level vector has all zero elements,
		 *  	in the others intermediate levels, the first int((level + 1) * HD_DIM / (2 * HD_LV_LEN)) elements are set to 1
		 *  	the formula for do the process frame by frame or partially parallelism defined by
		 *  	( (frame_index + 1) * DI_PARALLEL_W_BITS) / ( 2 * HD_LV_LEN ); that number of elements are set to 1 for each frame
		 *  	the last level vector has HD_DIM/2 elements set to 1;
		 *  	** note that total number change in a vector/number of frames should be bigger than one.
		 * @param levelVector Output vector representing the generated level.
		 * @param frame_id Frame ID indicate the partial index of the level vector and used for LV_M_HDL_GEN mode.
		 * @param frame_index Frame indicate the index of level vector and used for LV_M_HDL_GEN mode.
		 *
		 * @note For a deeper understanding of the implementation details, refer to our publication: "Title of Paper".
		 */
		template < typename HV_Type >
		void generate_LevelHVs( HV_Type& levelVector, const ap_uint<DI_FRAMEID_W_BITS>& frame_id,
								const ap_uint<DI_FRAMEID_W_BITS>& frame_index, HV_Type& lv_approx_0, HV_Type& lv_approx_1 )
		{
			#pragma HLS ARRAY_PARTITION variable=levelVector complete
		    #if ( LV_MODE == LV_M_HDL_GEN )
		    {
		    	ap_uint<DI_PARALLEL_W_BITS> level_vec_out;
		        level_vec_gen( level_vec_out, frame_id, frame_index );
		        for ( auto i = 0; i < DI_PARALLEL_W_BITS; i++ )
		        {
		            #pragma HLS unroll
		        	levelVector[DI_PARALLEL_W_BITS-1-i] = level_vec_out[i];
		        }
		    }
		    #elif ( LV_MODE == LV_M_LOGIC &&  HD_LV_TYPE == LINEAR )
		    {
		        // Not supported, generate it by software and save it in the memory
		    }
		    #elif ( LV_MODE == LV_M_LOGIC &&  HD_LV_TYPE == APPROX )
		    {
		    	auto inx_st = ( DI_PARALLEL_W_BITS * frame_id );
		    	auto limit = ( HD_DIM - ( ( frame_index * HD_DIM ) / ( HD_LV_LEN ) )) - inx_st;

		    	if( limit < 0 )
		    	{
		    		limit = 0;
		    	}
				for (  auto i = 0; i < DI_PARALLEL_W_BITS; i++ )
				{
					#pragma HLS unroll
					if ( (i < limit ) && frame_index != HD_LV_LEN-1 )
					{
						levelVector[i] = lv_approx_0[i]; // fill level vector by using first level vector
					}
					else
					{
						levelVector[i] = lv_approx_1[i]; // fill level vector by using last level vector
					}
				}
		    }
		    #elif ( LV_MODE == LV_M_LOGIC &&  HD_LV_TYPE == THERMOMETER  )
		    {
				auto inx_st = ( DI_PARALLEL_W_BITS * frame_id );
		    	auto limit = ( ( (frame_index + 1) * HD_DIM ) / ( 2 * HD_LV_LEN ) ) - inx_st;

		    	if( limit < 0 ){
					limit = 0;
				}

				for ( auto i = 0; i < DI_PARALLEL_W_BITS; i++ )
				{
					if ( i < limit && frame_index > 0 )
					{
						levelVector[i] = 1;
					}
					else
					{
					#if ( HD_DATA_TYPE == BINARY || HD_DATA_TYPE == BIPOLAR )
						levelVector[i] = 0;
					#endif
					}
				}
		    }
		    #endif
		}

		/**
		 * @brief Initializes the generation of the first and last level vectors for approximate method of generating level vector.
		 *
		 * It specifically initializes the first and last vectors of the level using a random generator.
		 *
		 */
		/*void init_approx_level_vector_generator()
		{
			rnd_lv_approx_gen_t rnd_gen;
			rnd_gen.reset();
			for ( auto lv_i = 0; lv_i < 2; lv_i++ )
			{
				random_HV( lv_approx[lv_i].element, rnd_gen, HD_DIM, LV_M_APPROX_RND_GEN_W_BITS );
			}
		}
		*/

		//--------------------------------------------------------------------------------------
		// Class Vector Generator Functions
		// Implements the NOVEL method for generating high-dimensional class vectors via hardware functions,
		// as detailed in our publication:
		// "Title of Paper", available at https://doi.org/10.xxxx/yyyyy
		//--------------------------------------------------------------------------------------

		/**
		 * @brief Generates high-dimensional class vectors.
		 *
		 * @details When `CV_MODE` is set to `CV_M_HDL_GEN`, this function leverages the NOVEL method
		 *          to produce high-dimensional class vectors using hardware functions.
		 *
		 * @param classVector Output vector representing the generated class.
		 * @param frame_id Frame ID indicating the partial index of the class vector, specifically utilized in the `CV_M_HDL_GEN` mode.
		 * @param frame_index Frame index which denotes the index of the class vector and is instrumental for the `CV_M_HDL_GEN` mode.
		 *
		 * @note For comprehensive insights into the underpinnings of this implementation, refer to our publication: "Title of Paper".
		 */
		template < typename HV_Type >
		void generate_ClassHVs( HV_Type& classVector, const ap_uint<DI_FRAMEID_W_BITS>& frame_id,
								const ap_uint<DI_FRAMEID_W_BITS>& frame_index )
		{
			#if ( CV_MODE == CV_M_HDL_GEN )
			{
				ap_uint<DI_PARALLEL_W_BITS> class_vec_out;
				class_vec_gen( class_vec_out, frame_id, frame_index );
				for ( auto j = 0; j < DI_PARALLEL_W_BITS; j++ )
				{
					#pragma HLS unroll
					classVector[DI_PARALLEL_W_BITS-1-j] = class_vec_out[j]; // Fill the bvh1 array with the random number
				}
			}
			#endif
		}

		//--------------------------------------------------------------------------------------
		// Functions to generate random vectors
		//--------------------------------------------------------------------------------------

		/**
		 * @brief Generates a random hypervector using a linear feedback shift register (LFSR).
		 *
		 * This function uses the provided LFSR instance to generate a random number with a length of LEN bits.
		 * It then assigns each bit of the random number to the corresponding element of the input hypervector.
		 *
		 * @param in_HV Reference to the hypervector that will receive the random values.
		 * @param lfsr_instance Reference to the LFSR instance used to generate random numbers.
		 */
		template < typename HVType, typename RndGenType >
		void random_HV( HVType &in_HV, RndGenType &lfsr_instance, const int in_HV_LEN, const int RND_GEN_LEN )
		{
		    for ( auto i = 0; i < in_HV_LEN; i += RND_GEN_LEN )
		    {
		    	lfsr_instance.randomize();
				for ( auto j = 0; j < RND_GEN_LEN; j++ )
				{
					#pragma HLS unroll
					auto index = i + ( RND_GEN_LEN - 1 - j );
					in_HV[index] = lfsr_instance.rnd_o[j];
				}
		    }
		}


        //--------------------------------------------------------------------------------------
		// Print function.
		//--------------------------------------------------------------------------------------

		/**
		 * @brief Print elements of a hypervector.
		 *
		 * This member function template prints the elements of a hypervector.
		 *
		 * @tparam HypervectorType Type of the hypervector.
		 * @param hv Hypervector to print.
		 */
		template < typename HypervectorType >
		void print_HV( const HypervectorType& hv )
		{
			for ( const auto& element : hv )
			{
				cout << element << " ";
			}
			cout << endl;
		}

};

#endif


