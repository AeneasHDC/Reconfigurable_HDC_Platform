# This script segment is generated automatically by AutoPilot

# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 8 \
    name bunded_train_chv_0 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_bunded_train_chv_0 \
    op interface \
    ports { bunded_train_chv_0 { O 32 vector } bunded_train_chv_0_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 9 \
    name hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2 \
    op interface \
    ports { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2 { O 32 vector } hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 10 \
    name bunded_train_chv_1 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_bunded_train_chv_1 \
    op interface \
    ports { bunded_train_chv_1 { O 32 vector } bunded_train_chv_1_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 11 \
    name hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1 \
    op interface \
    ports { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1 { O 32 vector } hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 12 \
    name bunded_train_chv_2 \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_bunded_train_chv_2 \
    op interface \
    ports { bunded_train_chv_2 { O 32 vector } bunded_train_chv_2_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 13 \
    name hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t \
    op interface \
    ports { hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t { O 32 vector } hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id -1 \
    name ap_ctrl \
    type ap_ctrl \
    reset_level 1 \
    sync_rst true \
    corename ap_ctrl \
    op interface \
    ports { ap_start { I 1 bit } ap_ready { O 1 bit } ap_done { O 1 bit } ap_idle { O 1 bit } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -2 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -3 \
    name ${PortName} \
    reset_level 1 \
    sync_rst true \
    corename apif_ap_rst \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


# flow_control definition:
set InstName hdv_engine_flow_control_loop_pipe_sequential_init_U
set CompName hdv_engine_flow_control_loop_pipe_sequential_init
set name flow_control_loop_pipe_sequential_init
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control] == "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control"} {
eval "::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control { \
    name ${name} \
    prefix hdv_engine_ \
}"
} else {
puts "@W \[IMPL-107\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_UPC_flow_control, check your platform lib"
}
}


if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $CompName BINDTYPE interface TYPE internal_upc_flow_control INSTNAME $InstName
}


