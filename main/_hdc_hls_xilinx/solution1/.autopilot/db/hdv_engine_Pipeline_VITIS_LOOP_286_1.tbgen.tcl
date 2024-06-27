set moduleName hdv_engine_Pipeline_VITIS_LOOP_286_1
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
set C_modelName {hdv_engine_Pipeline_VITIS_LOOP_286_1}
set C_modelType { void 0 }
set C_modelArgList {
	{ sdata_i_V_data_V int 8 regular {axi_s 0 volatile  { sdata_i Data } }  }
	{ sdata_i_V_keep_V int 1 regular {axi_s 0 volatile  { sdata_i Keep } }  }
	{ sdata_i_V_strb_V int 1 regular {axi_s 0 volatile  { sdata_i Strb } }  }
	{ sdata_i_V_user_V int 1 regular {axi_s 0 volatile  { sdata_i User } }  }
	{ sdata_i_V_last_V int 1 regular {axi_s 0 volatile  { sdata_i Last } }  }
	{ sdata_i_V_id_V int 1 regular {axi_s 0 volatile  { sdata_i ID } }  }
	{ sdata_i_V_dest_V int 1 regular {axi_s 0 volatile  { sdata_i Dest } }  }
}
set hasAXIMCache 0
set C_modelArgMapList {[ 
	{ "Name" : "sdata_i_V_data_V", "interface" : "axis", "bitwidth" : 8, "direction" : "READONLY"} , 
 	{ "Name" : "sdata_i_V_keep_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "sdata_i_V_strb_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "sdata_i_V_user_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "sdata_i_V_last_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "sdata_i_V_id_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} , 
 	{ "Name" : "sdata_i_V_dest_V", "interface" : "axis", "bitwidth" : 1, "direction" : "READONLY"} ]}
# RTL Port declarations: 
set portNum 15
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ sdata_i_TVALID sc_in sc_logic 1 invld 0 } 
	{ sdata_i_TDATA sc_in sc_lv 8 signal 0 } 
	{ sdata_i_TREADY sc_out sc_logic 1 inacc 6 } 
	{ sdata_i_TKEEP sc_in sc_lv 1 signal 1 } 
	{ sdata_i_TSTRB sc_in sc_lv 1 signal 2 } 
	{ sdata_i_TUSER sc_in sc_lv 1 signal 3 } 
	{ sdata_i_TLAST sc_in sc_lv 1 signal 4 } 
	{ sdata_i_TID sc_in sc_lv 1 signal 5 } 
	{ sdata_i_TDEST sc_in sc_lv 1 signal 6 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "sdata_i_TVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "invld", "bundle":{"name": "sdata_i_V_data_V", "role": "default" }} , 
 	{ "name": "sdata_i_TDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":8, "type": "signal", "bundle":{"name": "sdata_i_V_data_V", "role": "default" }} , 
 	{ "name": "sdata_i_TREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "inacc", "bundle":{"name": "sdata_i_V_dest_V", "role": "default" }} , 
 	{ "name": "sdata_i_TKEEP", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "sdata_i_V_keep_V", "role": "default" }} , 
 	{ "name": "sdata_i_TSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "sdata_i_V_strb_V", "role": "default" }} , 
 	{ "name": "sdata_i_TUSER", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "sdata_i_V_user_V", "role": "default" }} , 
 	{ "name": "sdata_i_TLAST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "sdata_i_V_last_V", "role": "default" }} , 
 	{ "name": "sdata_i_TID", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "sdata_i_V_id_V", "role": "default" }} , 
 	{ "name": "sdata_i_TDEST", "direction": "in", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "sdata_i_V_dest_V", "role": "default" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1"],
		"CDFG" : "hdv_engine_Pipeline_VITIS_LOOP_286_1",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "-1", "EstimateLatencyMax" : "-1",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "1",
		"IsBlackBox" : "0",
		"Port" : [
			{"Name" : "sdata_i_V_data_V", "Type" : "Axis", "Direction" : "I", "BaseName" : "sdata_i",
				"BlockSignal" : [
					{"Name" : "sdata_i_TDATA_blk_n", "Type" : "RtlSignal"}]},
			{"Name" : "sdata_i_V_keep_V", "Type" : "Axis", "Direction" : "I", "BaseName" : "sdata_i"},
			{"Name" : "sdata_i_V_strb_V", "Type" : "Axis", "Direction" : "I", "BaseName" : "sdata_i"},
			{"Name" : "sdata_i_V_user_V", "Type" : "Axis", "Direction" : "I", "BaseName" : "sdata_i"},
			{"Name" : "sdata_i_V_last_V", "Type" : "Axis", "Direction" : "I", "BaseName" : "sdata_i"},
			{"Name" : "sdata_i_V_id_V", "Type" : "Axis", "Direction" : "I", "BaseName" : "sdata_i"},
			{"Name" : "sdata_i_V_dest_V", "Type" : "Axis", "Direction" : "I", "BaseName" : "sdata_i"}],
		"Loop" : [
			{"Name" : "VITIS_LOOP_286_1", "PipelineType" : "UPC",
				"LoopDec" : {"FSMBitwidth" : "1", "FirstState" : "ap_ST_fsm_state1", "FirstStateIter" : "", "FirstStateBlock" : "ap_ST_fsm_state1_blk", "LastState" : "ap_ST_fsm_state1", "LastStateIter" : "", "LastStateBlock" : "ap_ST_fsm_state1_blk", "QuitState" : "ap_ST_fsm_state1", "QuitStateIter" : "", "QuitStateBlock" : "ap_ST_fsm_state1_blk", "OneDepthLoop" : "1", "has_ap_ctrl" : "1", "has_continue" : "0"}}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.flow_control_loop_pipe_sequential_init_U", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	hdv_engine_Pipeline_VITIS_LOOP_286_1 {
		sdata_i_V_data_V {Type I LastRead 0 FirstWrite -1}
		sdata_i_V_keep_V {Type I LastRead 0 FirstWrite -1}
		sdata_i_V_strb_V {Type I LastRead 0 FirstWrite -1}
		sdata_i_V_user_V {Type I LastRead 0 FirstWrite -1}
		sdata_i_V_last_V {Type I LastRead 0 FirstWrite -1}
		sdata_i_V_id_V {Type I LastRead 0 FirstWrite -1}
		sdata_i_V_dest_V {Type I LastRead 0 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "-1", "Max" : "-1"}
	, {"Name" : "Interval", "Min" : "-1", "Max" : "-1"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	sdata_i_V_data_V { axis {  { sdata_i_TVALID in_vld 0 1 }  { sdata_i_TDATA in_data 0 8 } } }
	sdata_i_V_keep_V { axis {  { sdata_i_TKEEP in_data 0 1 } } }
	sdata_i_V_strb_V { axis {  { sdata_i_TSTRB in_data 0 1 } } }
	sdata_i_V_user_V { axis {  { sdata_i_TUSER in_data 0 1 } } }
	sdata_i_V_last_V { axis {  { sdata_i_TLAST in_data 0 1 } } }
	sdata_i_V_id_V { axis {  { sdata_i_TID in_data 0 1 } } }
	sdata_i_V_dest_V { axis {  { sdata_i_TREADY in_acc 1 1 }  { sdata_i_TDEST in_data 0 1 } } }
}
