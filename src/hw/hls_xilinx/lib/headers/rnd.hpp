
/**
 * @file rnd.cpp
* @brief Defines the rnd class for generating random numbers.
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


#ifndef _RND_H
#define _RND_H

#include <stdio.h>
#include <stdlib.h>
#include "ap_int.h"
#include "stdint.h"



template < size_t OUT_BWIDTH, size_t N_OF_REM_FBITS, size_t b1, size_t b2, size_t b3, size_t b4, size_t seed >
class RndGenerator {

private:


	bool  out_inv;
	ap_uint<OUT_BWIDTH+N_OF_REM_FBITS> lfsr;

public:
	ap_uint<OUT_BWIDTH> rnd_o;

	RndGenerator(){
		reset();
	}

	void set_seed( ap_uint<OUT_BWIDTH+N_OF_REM_FBITS> _seed ){
		lfsr = static_cast<ap_uint<OUT_BWIDTH+N_OF_REM_FBITS>> (_seed);
	}

	bool randomize(){
			lfsr = lfsr >> 1;
			lfsr.set_bit( OUT_BWIDTH+N_OF_REM_FBITS-1, (lfsr.get_bit(b1) ^ lfsr.get_bit(b2)
						^ lfsr.get_bit(-b3+OUT_BWIDTH+N_OF_REM_FBITS-1) ^
						  lfsr.get_bit(-b4+OUT_BWIDTH+N_OF_REM_FBITS-1)) );

			this->rnd_o = lfsr.range( OUT_BWIDTH+N_OF_REM_FBITS-1, N_OF_REM_FBITS );

			apply_constrain();

		return 0;
	}

	void reset(){
		lfsr = static_cast<ap_uint<OUT_BWIDTH+N_OF_REM_FBITS>> (seed);
	}

	void apply_constrain(){

	}

	ap_uint<OUT_BWIDTH> get_rnd(){
		return this->rnd_o;
	}
};


#endif

