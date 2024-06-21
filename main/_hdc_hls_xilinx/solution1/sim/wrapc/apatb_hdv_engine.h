// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.1 (64-bit)
// Tool Version Limit: 2023.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================

extern "C" void AESL_WRAP_hdv_engine (
volatile void* nrst_i,
short op_mode_i,
long long frame_in,
hls::stream<struct ap_axis<32, 0, 0, 0 > > (&sdata_i),
volatile void* chv_i,
volatile void* bhv_i,
volatile void* lhv_i,
volatile void* pred_class_o,
volatile void* status_o);
