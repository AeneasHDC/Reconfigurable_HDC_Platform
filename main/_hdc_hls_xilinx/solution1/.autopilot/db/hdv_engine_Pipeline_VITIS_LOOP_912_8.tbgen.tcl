set moduleName hdv_engine_Pipeline_VITIS_LOOP_912_8
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
set C_modelName {hdv_engine_Pipeline_VITIS_LOOP_912_8}
set C_modelType { void 0 }
set C_modelArgList {
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_68 int 32 regular  }
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_69 int 32 regular  }
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_70 int 32 regular  }
	{ p_pred_class_o int 2 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set C_modelArgMapList {[ 
	{ "Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_68", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_69", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_70", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY"} , 
 	{ "Name" : "p_pred_class_o", "interface" : "wire", "bitwidth" : 2, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 11
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_68 sc_in sc_lv 32 signal 0 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_69 sc_in sc_lv 32 signal 1 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_70 sc_in sc_lv 32 signal 2 } 
	{ p_pred_class_o sc_out sc_lv 2 signal 3 } 
	{ p_pred_class_o_ap_vld sc_out sc_logic 1 outvld 3 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_68", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_68", "role": "default" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_69", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_69", "role": "default" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_70", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_70", "role": "default" }} , 
 	{ "name": "p_pred_class_o", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "p_pred_class_o", "role": "default" }} , 
 	{ "name": "p_pred_class_o_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "p_pred_class_o", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2"],
		"CDFG" : "hdv_engine_Pipeline_VITIS_LOOP_912_8",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "5", "EstimateLatencyMax" : "5",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_68", "Type" : "None", "Direction" : "I"},
			{"Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_69", "Type" : "None", "Direction" : "I"},
			{"Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_70", "Type" : "None", "Direction" : "I"},
			{"Name" : "p_pred_class_o", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_912_8", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_pp0_stage0", "FirstStateIter" : "ap_enable_reg_pp0_iter1", "FirstStateBlock" : "ap_block_pp0_stage0_subdone", "LastState" : "ap_ST_fsm_pp0_stage0", "LastStateIter" : "ap_enable_reg_pp0_iter1", "LastStateBlock" : "ap_block_pp0_stage0_subdone", "QuitState" : "ap_ST_fsm_pp0_stage0", "QuitStateIter" : "ap_enable_reg_pp0_iter1", "QuitStateBlock" : "ap_block_pp0_stage0_subdone", "OneDepthLoop" : "0", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mux_3_2_32_1_1_U11", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	hdv_engine_Pipeline_VITIS_LOOP_912_8 {
		hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_68 {Type I LastRead 0 FirstWrite -1}
		hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_69 {Type I LastRead 0 FirstWrite -1}
		hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_70 {Type I LastRead 0 FirstWrite -1}
		p_pred_class_o {Type O LastRead -1 FirstWrite 1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "5", "Max" : "5"}
	, {"Name" : "Interval", "Min" : "5", "Max" : "5"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_68 { ap_none {  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_68 in_data 0 32 } } }
	hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_69 { ap_none {  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_69 in_data 0 32 } } }
	hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_70 { ap_none {  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_70 in_data 0 32 } } }
	p_pred_class_o { ap_vld {  { p_pred_class_o out_data 1 2 }  { p_pred_class_o_ap_vld out_vld 1 1 } } }
}
