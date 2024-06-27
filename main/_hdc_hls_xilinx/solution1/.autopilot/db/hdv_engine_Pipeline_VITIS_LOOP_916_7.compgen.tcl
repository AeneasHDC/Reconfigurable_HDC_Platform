# This script segment is generated automatically by AutoPilot

set name hdv_engine_mul_32s_15ns_47_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set id 18
set name hdv_engine_mux_3_2_32_1_1
set corename simcore_mux
set op mux
set stage_num 1
set din0_width 32
set din0_signed 0
set din1_width 32
set din1_signed 0
set din2_width 32
set din2_signed 0
set din3_width 2
set din3_signed 0
set dout_width 32
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mux} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set op mux
set corename Multiplexer
if {${::AESL::PGuard_autocg_gen} && ${::AESL::PGuard_autocg_ipmgen}} {
if {[info proc ::AESL_LIB_VIRTEX::xil_gen_pipemux] == "::AESL_LIB_VIRTEX::xil_gen_pipemux"} {
eval "::AESL_LIB_VIRTEX::xil_gen_pipemux { \
    id ${id} \
    name ${name} \
    corename ${corename} \
    op ${op} \
    reset_level 1 \
    sync_rst true \
    stage_num ${stage_num} \
    din0_width ${din0_width} \
    din0_signed ${din0_signed} \
    din1_width ${din1_width} \
    din1_signed ${din1_signed} \
    din2_width ${din2_width} \
    din2_signed ${din2_signed} \
    din3_width ${din3_width} \
    din3_signed ${din3_signed} \
    dout_width ${dout_width} \
}"
} else {
puts "@W \[IMPL-101\] Cannot find ::AESL_LIB_VIRTEX::xil_gen_pipemux, check your platform lib"
}
}


set name hdv_engine_mul_17ns_17ns_34_1_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {mul} IMPL {auto} LATENCY 0 ALLOW_PRAGMA 1
}


set name hdv_engine_udiv_64s_34ns_32_68_1
if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler $name BINDTYPE {op} TYPE {udiv} IMPL {auto} LATENCY 67 ALLOW_PRAGMA 1
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 27 \
    name denom_b_classes_0_load_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_denom_b_classes_0_load_1 \
    op interface \
    ports { denom_b_classes_0_load_1 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 28 \
    name denom_b_classes_1_load_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_denom_b_classes_1_load_1 \
    op interface \
    ports { denom_b_classes_1_load_1 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 29 \
    name denom_b_classes_2_load_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_denom_b_classes_2_load_1 \
    op interface \
    ports { denom_b_classes_2_load_1 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 30 \
    name denom_a_classes_0_load_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_denom_a_classes_0_load_1 \
    op interface \
    ports { denom_a_classes_0_load_1 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 31 \
    name denom_a_classes_1_load_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_denom_a_classes_1_load_1 \
    op interface \
    ports { denom_a_classes_1_load_1 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 32 \
    name denom_a_classes_2_load_1 \
    type other \
    dir I \
    reset_level 1 \
    sync_rst true \
    corename dc_denom_a_classes_2_load_1 \
    op interface \
    ports { denom_a_classes_2_load_1 { I 32 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 33 \
    name mux_case_2701_phi_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mux_case_2701_phi_out \
    op interface \
    ports { mux_case_2701_phi_out { O 32 vector } mux_case_2701_phi_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 34 \
    name mux_case_1700_phi_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mux_case_1700_phi_out \
    op interface \
    ports { mux_case_1700_phi_out { O 32 vector } mux_case_1700_phi_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 35 \
    name mux_case_0699_phi_out \
    type other \
    dir O \
    reset_level 1 \
    sync_rst true \
    corename dc_mux_case_0699_phi_out \
    op interface \
    ports { mux_case_0699_phi_out { O 32 vector } mux_case_0699_phi_out_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 36 \
    name hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2 \
    op interface \
    ports { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_i { I 32 vector } hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_o { O 32 vector } hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_2_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 37 \
    name hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1 \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1 \
    op interface \
    ports { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_i { I 32 vector } hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_o { O 32 vector } hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_1_o_ap_vld { O 1 bit } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 38 \
    name hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl \
    type other \
    dir IO \
    reset_level 1 \
    sync_rst true \
    corename dc_hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl \
    op interface \
    ports { hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_i { I 32 vector } hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_o { O 32 vector } hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_bhv_p_t_lhv_p_t_pred_cl_o_ap_vld { O 1 bit } } \
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


