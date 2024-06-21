set SynModuleInfo {
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_273_1 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_273_1 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_273_1
    SUBMODULES {
      {MODELNAME hdv_engine_flow_control_loop_pipe_sequential_init RTLNAME hdv_engine_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME hdv_engine_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_281_2 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_281_2 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_281_2}
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_912_9 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_912_9 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_912_9
    SUBMODULES {
      {MODELNAME hdv_engine_mux_3_2_32_1_1 RTLNAME hdv_engine_mux_3_2_32_1_1 BINDTYPE op TYPE mux IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_494_4 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_494_4 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_494_4}
  {SRCNAME hdv_engine_Pipeline_VITIS_LOOP_766_6 MODELNAME hdv_engine_Pipeline_VITIS_LOOP_766_6 RTLNAME hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_766_6
    SUBMODULES {
      {MODELNAME hdv_engine_mux_64_6_32_1_1 RTLNAME hdv_engine_mux_64_6_32_1_1 BINDTYPE op TYPE mux IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME hdv_engine_mux_64_6_1_1_1 RTLNAME hdv_engine_mux_64_6_1_1_1 BINDTYPE op TYPE mux IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME hdv_engine MODELNAME hdv_engine RTLNAME hdv_engine IS_TOP 1
    SUBMODULES {
      {MODELNAME hdv_engine_regslice_both RTLNAME hdv_engine_regslice_both BINDTYPE interface TYPE interface_regslice INSTNAME hdv_engine_regslice_both_U}
    }
  }
}
