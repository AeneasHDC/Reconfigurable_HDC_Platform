#include "hls_design_meta.h"
const Port_Property HLS_Design_Meta::port_props[]={
	Port_Property("ap_clk", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_rst_n", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_start", 1, hls_in, -1, "", "", 1),
	Port_Property("ap_done", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_idle", 1, hls_out, -1, "", "", 1),
	Port_Property("ap_ready", 1, hls_out, -1, "", "", 1),
	Port_Property("nrst_i", 1, hls_in, 0, "ap_none", "in_data", 1),
	Port_Property("op_mode_i", 16, hls_in, 1, "ap_none", "in_data", 1),
	Port_Property("frame_in", 48, hls_in, 2, "ap_none", "in_data", 1),
	Port_Property("sdata_i_TDATA", 8, hls_in, 3, "axis", "in_data", 1),
	Port_Property("sdata_i_TVALID", 1, hls_in, 9, "axis", "in_vld", 1),
	Port_Property("sdata_i_TREADY", 1, hls_out, 9, "axis", "in_acc", 1),
	Port_Property("sdata_i_TKEEP", 1, hls_in, 4, "axis", "in_data", 1),
	Port_Property("sdata_i_TSTRB", 1, hls_in, 5, "axis", "in_data", 1),
	Port_Property("sdata_i_TUSER", 1, hls_in, 6, "axis", "in_data", 1),
	Port_Property("sdata_i_TLAST", 1, hls_in, 7, "axis", "in_data", 1),
	Port_Property("sdata_i_TID", 1, hls_in, 8, "axis", "in_data", 1),
	Port_Property("sdata_i_TDEST", 1, hls_in, 9, "axis", "in_data", 1),
	Port_Property("chv_i", 2048, hls_in, 10, "ap_none", "in_data", 1),
	Port_Property("chv_o", 2048, hls_out, 11, "ap_vld", "out_data", 1),
	Port_Property("chv_o_ap_vld", 1, hls_out, 11, "ap_vld", "out_vld", 1),
	Port_Property("bhv_i", 64, hls_in, 12, "ap_none", "in_data", 1),
	Port_Property("lhv_i", 64, hls_in, 13, "ap_none", "in_data", 1),
	Port_Property("lable_class_i", 6, hls_in, 14, "ap_none", "in_data", 1),
	Port_Property("pred_class_o", 6, hls_out, 15, "ap_none", "out_data", 1),
	Port_Property("status_o", 5, hls_out, 16, "ap_none", "out_data", 1),
};
const char* HLS_Design_Meta::dut_name = "hdv_engine";