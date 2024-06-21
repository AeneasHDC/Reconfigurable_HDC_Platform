
log_wave -r /
set designtopgroup [add_wave_group "Design Top Signals"]
set coutputgroup [add_wave_group "C Outputs" -into $designtopgroup]
set return_group [add_wave_group return(wire) -into $coutputgroup]
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/status_o -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/pred_class_o -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/chv_o_ap_vld -into $return_group -color #ffff00 -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/chv_o -into $return_group -radix hex
set cinputgroup [add_wave_group "C Inputs" -into $designtopgroup]
set return_group [add_wave_group return(wire) -into $cinputgroup]
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/lable_class_i -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/lhv_i -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/bhv_i -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/chv_i -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/sdata_i_TDEST -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/sdata_i_TID -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/sdata_i_TLAST -into $return_group -color #ffff00 -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/sdata_i_TUSER -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/sdata_i_TSTRB -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/sdata_i_TKEEP -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/sdata_i_TREADY -into $return_group -color #ffff00 -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/sdata_i_TVALID -into $return_group -color #ffff00 -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/sdata_i_TDATA -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/frame_in -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/op_mode_i -into $return_group -radix hex
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/nrst_i -into $return_group -radix hex
set blocksiggroup [add_wave_group "Block-level IO Handshake" -into $designtopgroup]
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/ap_start -into $blocksiggroup
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/ap_done -into $blocksiggroup
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/ap_idle -into $blocksiggroup
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/ap_ready -into $blocksiggroup
set resetgroup [add_wave_group "Reset" -into $designtopgroup]
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/ap_rst_n -into $resetgroup
set clockgroup [add_wave_group "Clock" -into $designtopgroup]
add_wave /apatb_hdv_engine_top/AESL_inst_hdv_engine/ap_clk -into $clockgroup
set testbenchgroup [add_wave_group "Test Bench Signals"]
set tbinternalsiggroup [add_wave_group "Internal Signals" -into $testbenchgroup]
set tb_simstatus_group [add_wave_group "Simulation Status" -into $tbinternalsiggroup]
set tb_portdepth_group [add_wave_group "Port Depth" -into $tbinternalsiggroup]
add_wave /apatb_hdv_engine_top/AUTOTB_TRANSACTION_NUM -into $tb_simstatus_group -radix hex
add_wave /apatb_hdv_engine_top/ready_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_hdv_engine_top/done_cnt -into $tb_simstatus_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_bhv_i -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_chv_i -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_chv_o -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_frame_in -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_lable_class_i -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_lhv_i -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_nrst_i -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_op_mode_i -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_pred_class_o -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_sdata_i_V_data_V -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_sdata_i_V_dest_V -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_sdata_i_V_id_V -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_sdata_i_V_keep_V -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_sdata_i_V_last_V -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_sdata_i_V_strb_V -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_sdata_i_V_user_V -into $tb_portdepth_group -radix hex
add_wave /apatb_hdv_engine_top/LENGTH_status_o -into $tb_portdepth_group -radix hex
set tbcoutputgroup [add_wave_group "C Outputs" -into $testbenchgroup]
set tb_return_group [add_wave_group return(wire) -into $tbcoutputgroup]
add_wave /apatb_hdv_engine_top/status_o -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/pred_class_o -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/chv_o_ap_vld -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_hdv_engine_top/chv_o -into $tb_return_group -radix hex
set tbcinputgroup [add_wave_group "C Inputs" -into $testbenchgroup]
set tb_return_group [add_wave_group return(wire) -into $tbcinputgroup]
add_wave /apatb_hdv_engine_top/lable_class_i -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/lhv_i -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/bhv_i -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/chv_i -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/sdata_i_TDEST -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/sdata_i_TID -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/sdata_i_TLAST -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_hdv_engine_top/sdata_i_TUSER -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/sdata_i_TSTRB -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/sdata_i_TKEEP -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/sdata_i_TREADY -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_hdv_engine_top/sdata_i_TVALID -into $tb_return_group -color #ffff00 -radix hex
add_wave /apatb_hdv_engine_top/sdata_i_TDATA -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/frame_in -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/op_mode_i -into $tb_return_group -radix hex
add_wave /apatb_hdv_engine_top/nrst_i -into $tb_return_group -radix hex
save_wave_config hdv_engine.wcfg
run all
quit

