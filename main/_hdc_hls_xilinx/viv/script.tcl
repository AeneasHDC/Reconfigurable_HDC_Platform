create_project viv ./ -part xczu9eg-ffvb1156-2-e
add_files .//..//..//..//out//hls//ip//hdv_engine.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_flow_control_loop_pipe_sequential_init.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_273_1.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_281_2.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_494_4.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_912_8.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_mux_3_2_32_1_1.vhd
add_files .//..//..//..//out//hls//ip//hdv_engine_regslice_both.vhd
add_files -fileset constrs_1 ./const.xdc
set_property top hdv_engine [current_fileset]
launch_runs synth_1 -jobs 24
wait_on_run synth_1
open_run synth_1
report_utilization -file ./../../../out/hls/resource_util.xml -format xml
report_power -file ./../../../out/hls/power_estimation.xml -format xml
close_project
