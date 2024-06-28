create_project viv ./ -part xczu9eg-ffvb1156-2-e
add_files -fileset constrs_1 ./const.xdc
set_property top hdv_engine [current_fileset]
launch_runs synth_1 -jobs 24
wait_on_run synth_1
open_run synth_1
report_utilization -file ./../../../out/hls/resource_util.xml -format xml
report_power -file ./../../../out/hls/power_estimation.xml -format xml
close_project
