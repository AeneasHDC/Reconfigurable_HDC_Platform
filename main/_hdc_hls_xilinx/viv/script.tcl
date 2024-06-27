create_project viv ./ -part xczu9eg-ffvb1156-2-e
add_files .//..//..//..//out//hls//ip//hdv_engine.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_flow_control_loop_pipe_sequential_init.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_286_1.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_294_2.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_511_4.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_916_7.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_929_8.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_mac_muladd_11ns_11ns_22ns_23_4_1.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_mul_11ns_11ns_22_1_1.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_mul_17ns_17ns_34_1_1.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_mul_32s_15ns_47_1_1.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_mux_3_2_32_1_1.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_regslice_both.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_udiv_64s_34ns_32_68_1.vhd
add_files -fileset constrs_1 ./const.xdc
set_property top hdv_engine [current_fileset]
launch_runs synth_1 -jobs 24
wait_on_run synth_1
open_run synth_1
report_utilization -file ./../../../out/hls/resource_util.xml -format xml
report_power -file ./../../../out/hls/power_estimation.xml -format xml
close_project
