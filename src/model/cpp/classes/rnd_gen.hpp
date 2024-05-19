#ifndef RND_GEN_HPP
#define RND_GEN_HPP
#include "auxiliary_functions.hpp"

template <size_t OUT_BWIDTH, size_t N_OF_REM_FBITS, size_t b1, size_t b2, size_t b3, size_t b4, size_t seed>
class LFSR {
private:
    std::bitset<OUT_BWIDTH + N_OF_REM_FBITS> lfsr;

public:
    RndGenerator() {
        reset();
    }

        void set_seed(unsigned long long _seed) {
        lfsr = std::bitset<OUT_BWIDTH + N_OF_REM_FBITS>(_seed);
    }

    bool randomize() {
        bool new_bit = lfsr[b1] ^ lfsr[b2] ^ lfsr[OUT_BWIDTH + N_OF_REM_FBITS - 1 - b3] ^ lfsr[OUT_BWIDTH + N_OF_REM_FBITS - 1 - b4];
        lfsr >>= 1;
        lfsr.set(OUT_BWIDTH + N_OF_REM_FBITS - 1, new_bit);

        rnd_o = (lfsr.to_ullong() >> N_OF_REM_FBITS) & ((1ULL << OUT_BWIDTH) - 1);

        apply_constrain();

        return false;
    }

    void reset() {
        lfsr = std::bitset<OUT_BWIDTH + N_OF_REM_FBITS>(seed);
        randomize();  // Populate initial rnd_o value
    }

    void apply_constrain() {
        // Implement any constraints here.
    }

    unsigned long long get_rnd() {
        return rnd_o;
    }
};


#endif