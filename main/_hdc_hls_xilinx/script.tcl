open_project _hdc_hls_xilinx
add_files ./../src/hw/hls_xilinx/main.cpp
add_files -tb ./../src/hw/hls_xilinx/tb/tb.cpp
open_solution "solution1" -flow_target vivado
set_top hdv_engine
set_part xczu9eg-ffvb1156-2-e
create_clock -period 5.0 -name default
set fileId [open "../src/config/hls_configs.hpp" w]
close $fileId
csim_design
csynth_design
set fileId [open "../src/config/hls_configs.hpp" a]
puts $fileId "#ifndef COSIM"
puts $fileId "#define COSIM"
puts $fileId "#endif"
close $fileId
cosim_design -rtl verilog -trace_level all
close_project
exit
