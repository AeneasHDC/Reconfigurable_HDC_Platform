set moduleName hdv_engine_Pipeline_VITIS_LOOP_916_7
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set C_modelName {hdv_engine_Pipeline_VITIS_LOOP_916_7}
set C_modelType { void 0 }
set C_modelArgList {
	{ denom_b_classes_0_load_1 int 32 regular  }
	{ denom_b_classes_1_load_1 int 32 regular  }
	{ denom_b_classes_2_load_1 int 32 regular  }
	{ denom_a_classes_0_load_1 int 32 regular  }
	{ denom_a_classes_1_load_1 int 32 regular  }
	{ denom_a_classes_2_load_1 int 32 regular  }
	{ mux_case_2701_phi_out int 32 regular {pointer 1}  }
	{ mux_case_1700_phi_out int 32 regular {pointer 1}  }
	{ mux_case_0699_phi_out int 32 regular {pointer 1}  }
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2 int 32 regular {pointer 2} {global 2}  }
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1 int 32 regular {pointer 2} {global 2}  }
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl int 32 regular {pointer 2} {global 2}  }
}
set hasAXIMCache 0
set C_modelArgMapList {[ 
	{ "Name" : "denom_b_classes_0_load_1", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "denom_b_classes_1_load_1", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "denom_b_classes_2_load_1", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "denom_a_classes_0_load_1", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "denom_a_classes_1_load_1", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "denom_a_classes_2_load_1", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "mux_case_2701_phi_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mux_case_1700_phi_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mux_case_0699_phi_out", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY"} , 
 	{ "Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE", "extern" : 0} , 
 	{ "Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl", "interface" : "wire", "bitwidth" : 32, "direction" : "READWRITE", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 27
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ denom_b_classes_0_load_1 sc_in sc_lv 32 signal 0 } 
	{ denom_b_classes_1_load_1 sc_in sc_lv 32 signal 1 } 
	{ denom_b_classes_2_load_1 sc_in sc_lv 32 signal 2 } 
	{ denom_a_classes_0_load_1 sc_in sc_lv 32 signal 3 } 
	{ denom_a_classes_1_load_1 sc_in sc_lv 32 signal 4 } 
	{ denom_a_classes_2_load_1 sc_in sc_lv 32 signal 5 } 
	{ mux_case_2701_phi_out sc_out sc_lv 32 signal 6 } 
	{ mux_case_2701_phi_out_ap_vld sc_out sc_logic 1 outvld 6 } 
	{ mux_case_1700_phi_out sc_out sc_lv 32 signal 7 } 
	{ mux_case_1700_phi_out_ap_vld sc_out sc_logic 1 outvld 7 } 
	{ mux_case_0699_phi_out sc_out sc_lv 32 signal 8 } 
	{ mux_case_0699_phi_out_ap_vld sc_out sc_logic 1 outvld 8 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_i sc_in sc_lv 32 signal 9 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_o sc_out sc_lv 32 signal 9 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_o_ap_vld sc_out sc_logic 1 outvld 9 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_i sc_in sc_lv 32 signal 10 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_o sc_out sc_lv 32 signal 10 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_o_ap_vld sc_out sc_logic 1 outvld 10 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_i sc_in sc_lv 32 signal 11 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_o sc_out sc_lv 32 signal 11 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_o_ap_vld sc_out sc_logic 1 outvld 11 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "denom_b_classes_0_load_1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "denom_b_classes_0_load_1", "role": "default" }} , 
 	{ "name": "denom_b_classes_1_load_1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "denom_b_classes_1_load_1", "role": "default" }} , 
 	{ "name": "denom_b_classes_2_load_1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "denom_b_classes_2_load_1", "role": "default" }} , 
 	{ "name": "denom_a_classes_0_load_1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "denom_a_classes_0_load_1", "role": "default" }} , 
 	{ "name": "denom_a_classes_1_load_1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "denom_a_classes_1_load_1", "role": "default" }} , 
 	{ "name": "denom_a_classes_2_load_1", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "denom_a_classes_2_load_1", "role": "default" }} , 
 	{ "name": "mux_case_2701_phi_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mux_case_2701_phi_out", "role": "default" }} , 
 	{ "name": "mux_case_2701_phi_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mux_case_2701_phi_out", "role": "ap_vld" }} , 
 	{ "name": "mux_case_1700_phi_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mux_case_1700_phi_out", "role": "default" }} , 
 	{ "name": "mux_case_1700_phi_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mux_case_1700_phi_out", "role": "ap_vld" }} , 
 	{ "name": "mux_case_0699_phi_out", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "mux_case_0699_phi_out", "role": "default" }} , 
 	{ "name": "mux_case_0699_phi_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "mux_case_0699_phi_out", "role": "ap_vld" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2", "role": "i" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2", "role": "o" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2", "role": "o_ap_vld" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1", "role": "i" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1", "role": "o" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1", "role": "o_ap_vld" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_i", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl", "role": "i" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_o", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl", "role": "o" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl", "role": "o_ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5", "6", "7"],
		"CDFG" : "hdv_engine_Pipeline_VITIS_LOOP_916_7",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "87", "EstimateLatencyMax" : "87",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "denom_b_classes_0_load_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "denom_b_classes_1_load_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "denom_b_classes_2_load_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "denom_a_classes_0_load_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "denom_a_classes_1_load_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "denom_a_classes_2_load_1", "Type" : "None", "Direction" : "I"},
			{"Name" : "mux_case_2701_phi_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "mux_case_1700_phi_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "mux_case_0699_phi_out", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl", "Type" : "OVld", "Direction" : "IO"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_916_7", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "5", "FirstState" : "ap_ST_fsm_pp0_stage1", "FirstStateIter" : "ap_enable_reg_pp0_iter0", "FirstStateBlock" : "ap_block_pp0_stage1_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter15", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter15", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_15ns_47_1_1_U17", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_3_2_32_1_1_U18", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_3_2_32_1_1_U19", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_3_2_32_1_1_U20", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_17ns_17ns_34_1_1_U21", "Parent" : "0"},
	{"ID" : "6", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.udiv_64s_34ns_32_68_1_U22", "Parent" : "0"},
	{"ID" : "7", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	hdv_engine_Pipeline_VITIS_LOOP_916_7 {
		denom_b_classes_0_load_1 {Type I LastRead 0 FirstWrite -1}
		denom_b_classes_1_load_1 {Type I LastRead 0 FirstWrite -1}
		denom_b_classes_2_load_1 {Type I LastRead 0 FirstWrite -1}
		denom_a_classes_0_load_1 {Type I LastRead 0 FirstWrite -1}
		denom_a_classes_1_load_1 {Type I LastRead 0 FirstWrite -1}
		denom_a_classes_2_load_1 {Type I LastRead 0 FirstWrite -1}
		mux_case_2701_phi_out {Type O LastRead -1 FirstWrite 70}
		mux_case_1700_phi_out {Type O LastRead -1 FirstWrite 70}
		mux_case_0699_phi_out {Type O LastRead -1 FirstWrite 70}
		hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2 {Type IO LastRead 5 FirstWrite 75}
		hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1 {Type IO LastRead 5 FirstWrite 75}
		hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl {Type IO LastRead 5 FirstWrite 75}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "87", "Max" : "87"}
	, {"Name" : "Interval", "Min" : "87", "Max" : "87"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	denom_b_classes_0_load_1 { ap_none {  { denom_b_classes_0_load_1 in_data 0 32 } } }
	denom_b_classes_1_load_1 { ap_none {  { denom_b_classes_1_load_1 in_data 0 32 } } }
	denom_b_classes_2_load_1 { ap_none {  { denom_b_classes_2_load_1 in_data 0 32 } } }
	denom_a_classes_0_load_1 { ap_none {  { denom_a_classes_0_load_1 in_data 0 32 } } }
	denom_a_classes_1_load_1 { ap_none {  { denom_a_classes_1_load_1 in_data 0 32 } } }
	denom_a_classes_2_load_1 { ap_none {  { denom_a_classes_2_load_1 in_data 0 32 } } }
	mux_case_2701_phi_out { ap_vld {  { mux_case_2701_phi_out out_data 1 32 }  { mux_case_2701_phi_out_ap_vld out_vld 1 1 } } }
	mux_case_1700_phi_out { ap_vld {  { mux_case_1700_phi_out out_data 1 32 }  { mux_case_1700_phi_out_ap_vld out_vld 1 1 } } }
	mux_case_0699_phi_out { ap_vld {  { mux_case_0699_phi_out out_data 1 32 }  { mux_case_0699_phi_out_ap_vld out_vld 1 1 } } }
	hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2 { ap_ovld {  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_i in_data 0 32 }  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_o out_data 1 32 }  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_o_ap_vld out_vld 1 1 } } }
	hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1 { ap_ovld {  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_i in_data 0 32 }  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_o out_data 1 32 }  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_o_ap_vld out_vld 1 1 } } }
	hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl { ap_ovld {  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_i in_data 0 32 }  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_o out_data 1 32 }  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_o_ap_vld out_vld 1 1 } } }
}
