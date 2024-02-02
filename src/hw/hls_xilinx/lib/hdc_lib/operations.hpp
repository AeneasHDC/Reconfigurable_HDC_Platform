#ifndef _OPERATIONS_HPP__
#define _OPERATIONS_HPP__

#include <ap_int.h>

template <size_t DATA_WIDTH, size_t LEN>
class Operations {
public:
    using HVector = ap_int<DATA_WIDTH>[LEN];  

    static void add(const HVector& vec1, const HVector& vec2, HVector& result) {
        #pragma HLS INLINE  
        for (size_t i = 0; i < LEN; ++i) {
            #pragma HLS UNROLL  
            result[i] = vec1[i] + vec2[i];
        }
    }

    static void multiply(const HVector& vec1, const HVector& vec2, HVector& result) {
        #pragma HLS INLINE
        for (size_t i = 0; i < LEN; ++i) {
            #pragma HLS UNROLL
            result[i] = vec1[i] * vec2[i];
        }
    }

    static void xor_op(const HVector& vec1, const HVector& vec2, HVector& result) {
        #pragma HLS INLINE
        for (size_t i = 0; i < LEN; ++i) {
            #pragma HLS UNROLL
            result[i] = vec1[i] ^ vec2[i];
        }
    }

    static void xnor_op(const HVector& vec1, const HVector& vec2, HVector& result) {
        #pragma HLS INLINE
        for (size_t i = 0; i < LEN; ++i) {
            #pragma HLS UNROLL
            result[i] = !(vec1[i] ^ vec2[i]);
        }
    }

    static void or_op(const HVector& vec1, const HVector& vec2, HVector& result) {
        #pragma HLS INLINE
        for (size_t i = 0; i < LEN; ++i) {
            #pragma HLS UNROLL
            result[i] = vec1[i] | vec2[i];
        }
    }

    static void nand_op(const HVector& vec1, const HVector& vec2, HVector& result) {
        #pragma HLS INLINE
        for (size_t i = 0; i < LEN; ++i) {
            #pragma HLS UNROLL
            result[i] = !(vec1[i] & vec2[i]);
        }
    }

};

#endif  
