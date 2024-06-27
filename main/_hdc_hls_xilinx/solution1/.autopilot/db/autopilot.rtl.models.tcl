set SynModuleInfo {
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_286_1 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_286_1 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_286_1
    SUBMODULES {
      {MODELNAME hdv_engine_flow_control_loop_pipe_sequential_init RTLNAME hdv_engine_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME hdv_engine_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_294_2 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_294_2 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_294_2}
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_916_7 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_916_7 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_916_7
    SUBMODULES {
      {MODELNAME hdv_engine_mul_32s_15ns_47_1_1 RTLNAME hdv_engine_mul_32s_15ns_47_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hdv_engine_mux_3_2_32_1_1 RTLNAME hdv_engine_mux_3_2_32_1_1 BINDTYPE op TYPE mux IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hdv_engine_mul_17ns_17ns_34_1_1 RTLNAME hdv_engine_mul_17ns_17ns_34_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hdv_engine_udiv_64s_34ns_32_68_1 RTLNAME hdv_engine_udiv_64s_34ns_32_68_1 BINDTYPE op TYPE udiv IMPL auto LATENCY 67 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_929_8 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_929_8 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_929_8}
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_511_4 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_511_4 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_511_4}
  {SRCNAME hdv_engine MODELNAME hdv_engine RTLNAME hdv_engine IS_TOP 1
    SUBMODULES {
      {MODELNAME hdv_engine_mul_11ns_11ns_22_1_1 RTLNAME hdv_engine_mul_11ns_11ns_22_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hdv_engine_mac_muladd_11ns_11ns_22ns_23_4_1 RTLNAME hdv_engine_mac_muladd_11ns_11ns_22ns_23_4_1 BINDTYPE op TYPE all IMPL dsp48 LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME hdv_engine_regslice_both RTLNAME hdv_engine_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME hdv_engine_regslice_both_U}
    }
  }
}
