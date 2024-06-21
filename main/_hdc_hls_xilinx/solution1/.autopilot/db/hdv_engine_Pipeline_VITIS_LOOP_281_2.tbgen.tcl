set moduleName hdv_engine_Pipeline_VITIS_LOOP_281_2
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
set C_modelName {hdv_engine_Pipeline_VITIS_LOOP_281_2}
set C_modelType { void 0 }
set C_modelArgList {
	{ bunded_train_chv_0 int 32 regular {pointer 1} {global 1}  }
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2 int 32 regular {pointer 1} {global 1}  }
	{ bunded_train_chv_1 int 32 regular {pointer 1} {global 1}  }
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1 int 32 regular {pointer 1} {global 1}  }
	{ bunded_train_chv_2 int 32 regular {pointer 1} {global 1}  }
	{ hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t int 32 regular {pointer 1} {global 1}  }
}
set hasAXIMCache 0
set C_modelArgMapList {[ 
	{ "Name" : "bunded_train_chv_0", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "bunded_train_chv_1", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "bunded_train_chv_2", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} , 
 	{ "Name" : "hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "extern" : 0} ]}
# RTL Port declarations: 
set portNum 18
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ bunded_train_chv_0 sc_out sc_lv 32 signal 0 } 
	{ bunded_train_chv_0_ap_vld sc_out sc_logic 1 outvld 0 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2 sc_out sc_lv 32 signal 1 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2_ap_vld sc_out sc_logic 1 outvld 1 } 
	{ bunded_train_chv_1 sc_out sc_lv 32 signal 2 } 
	{ bunded_train_chv_1_ap_vld sc_out sc_logic 1 outvld 2 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1 sc_out sc_lv 32 signal 3 } 
	{ hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ bunded_train_chv_2 sc_out sc_lv 32 signal 4 } 
	{ bunded_train_chv_2_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t sc_out sc_lv 32 signal 5 } 
	{ hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_ap_vld sc_out sc_logic 1 outvld 5 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "bunded_train_chv_0", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bunded_train_chv_0", "role": "default" }} , 
 	{ "name": "bunded_train_chv_0_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "bunded_train_chv_0", "role": "ap_vld" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2", "role": "default" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2", "role": "ap_vld" }} , 
 	{ "name": "bunded_train_chv_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bunded_train_chv_1", "role": "default" }} , 
 	{ "name": "bunded_train_chv_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "bunded_train_chv_1", "role": "ap_vld" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1", "role": "default" }} , 
 	{ "name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1", "role": "ap_vld" }} , 
 	{ "name": "bunded_train_chv_2", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "bunded_train_chv_2", "role": "default" }} , 
 	{ "name": "bunded_train_chv_2_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "bunded_train_chv_2", "role": "ap_vld" }} , 
 	{ "name": "hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t", "role": "default" }} , 
 	{ "name": "hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "hdv_engine_Pipeline_VITIS_LOOP_281_2",
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
			{"Name" : "bunded_train_chv_0", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "bunded_train_chv_1", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "bunded_train_chv_2", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t", "Type" : "Vld", "Direction" : "O"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_281_2", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	hdv_engine_Pipeline_VITIS_LOOP_281_2 {
		bunded_train_chv_0 {Type O LastRead -1 FirstWrite 0}
		hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2 {Type O LastRead -1 FirstWrite 0}
		bunded_train_chv_1 {Type O LastRead -1 FirstWrite 0}
		hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1 {Type O LastRead -1 FirstWrite 0}
		bunded_train_chv_2 {Type O LastRead -1 FirstWrite 0}
		hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t {Type O LastRead -1 FirstWrite 0}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "5", "Max" : "5"}
	, {"Name" : "Interval", "Min" : "5", "Max" : "5"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	bunded_train_chv_0 { ap_vld {  { bunded_train_chv_0 out_data 1 32 }  { bunded_train_chv_0_ap_vld out_vld 1 1 } } }
	hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2 { ap_vld {  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2 out_data 1 32 }  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2_ap_vld out_vld 1 1 } } }
	bunded_train_chv_1 { ap_vld {  { bunded_train_chv_1 out_data 1 32 }  { bunded_train_chv_1_ap_vld out_vld 1 1 } } }
	hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1 { ap_vld {  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1 out_data 1 32 }  { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1_ap_vld out_vld 1 1 } } }
	bunded_train_chv_2 { ap_vld {  { bunded_train_chv_2 out_data 1 32 }  { bunded_train_chv_2_ap_vld out_vld 1 1 } } }
	hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t { ap_vld {  { hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t out_data 1 32 }  { hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_ap_vld out_vld 1 1 } } }
}
