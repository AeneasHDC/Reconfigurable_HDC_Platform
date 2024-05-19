
/**
 * @file rnd.cpp
* @brief Defines the rnd class for generating random numbers.
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

