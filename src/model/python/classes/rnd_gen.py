"""
/**
 * @file LFSR.py
 * @brief This module provides an implementation of a Linear Feedback Shift Register (LFSR)
 *        which can be used as a pseudo-random number generator.
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
"""

class LFSR:
    """
    Linear Feedback Shift Register (LFSR) implementation for pseudo-random number generation.
    
    Attributes:
        OUT_BWIDTH (int): The output bit-width.
        N_OF_REM_FBITS (int): The number of remaining feedback bits.
        b1 (int): Feedback bit 1.
        b2 (int): Feedback bit 2.
        b3 (int): Feedback bit 3.
        b4 (int): Feedback bit 4.
        lfsr (int): The current state of the LFSR.
        rnd_o (int): The current random output value.
    """
    def __init__(self, OUT_BWIDTH, N_OF_REM_FBITS, b1, b2, b3, b4, seed):
        self.OUT_BWIDTH = OUT_BWIDTH
        self.N_OF_REM_FBITS = N_OF_REM_FBITS
        self.b1 = b1
        self.b2 = b2
        self.b3 = b3
        self.b4 = b4
        self.lfsr = seed
        self.rnd_o = 0

    def set_seed(self, _seed):
        """
        Set the initial seed value for the LFSR.
        
        Parameters:
            seed (int): The seed value.
        """
        self.lfsr = _seed

    def randomize(self):
        """
        Generate a new pseudo-random number using the LFSR.
        
        Returns:
            bool: True if the operation was successful.
        """
        self.lfsr >>= 1
        new_bit = ((self.lfsr >> self.b1) & 1) ^ ((self.lfsr >> self.b2) & 1) ^ ((self.lfsr >> (self.OUT_BWIDTH+self.N_OF_REM_FBITS-1-self.b3)) & 1) ^ ((self.lfsr >> (self.OUT_BWIDTH+self.N_OF_REM_FBITS-1-self.b4)) & 1)
        self.lfsr |= (new_bit << (self.OUT_BWIDTH+self.N_OF_REM_FBITS-1))
        self.rnd_o = (self.lfsr >> self.N_OF_REM_FBITS) & ((1 << self.OUT_BWIDTH) - 1)

        self.apply_constrain()
        return True

    def apply_constrain(self):
        """
        
        """
        # apply your constraints here
        pass
