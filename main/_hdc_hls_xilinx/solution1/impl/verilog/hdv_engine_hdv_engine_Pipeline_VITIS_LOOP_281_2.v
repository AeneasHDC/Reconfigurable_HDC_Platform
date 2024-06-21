// ==============================================================
// Generated by Vitis HLS v2023.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_281_2 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        bunded_train_chv_0,
        bunded_train_chv_0_ap_vld,
        hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2,
        hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2_ap_vld,
        bunded_train_chv_1,
        bunded_train_chv_1_ap_vld,
        hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1,
        hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1_ap_vld,
        bunded_train_chv_2,
        bunded_train_chv_2_ap_vld,
        hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t,
        hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_ap_vld
);

parameter    ap_ST_fsm_state1 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [31:0] bunded_train_chv_0;
output   bunded_train_chv_0_ap_vld;
output  [31:0] hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2;
output   hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2_ap_vld;
output  [31:0] bunded_train_chv_1;
output   bunded_train_chv_1_ap_vld;
output  [31:0] hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1;
output   hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1_ap_vld;
output  [31:0] bunded_train_chv_2;
output   bunded_train_chv_2_ap_vld;
output  [31:0] hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t;
output   hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_ap_vld;

reg ap_idle;
reg bunded_train_chv_0_ap_vld;
reg hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2_ap_vld;
reg bunded_train_chv_1_ap_vld;
reg hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1_ap_vld;
reg bunded_train_chv_2_ap_vld;
reg hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_ap_vld;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ap_block_state1_pp0_stage0_iter0;
wire   [0:0] icmp_ln281_fu_48_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
wire   [1:0] i_4_load_fu_45_p1;
reg   [1:0] i_fu_36;
wire   [1:0] add_ln281_fu_54_p2;
wire    ap_loop_init;
reg   [1:0] ap_sig_allocacmp_i_4;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg   [0:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_done_reg = 1'b0;
end

hdv_engine_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((ap_start_int == 1'b1) & (ap_loop_exit_ready == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((ap_start_int == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        if ((icmp_ln281_fu_48_p2 == 1'd0)) begin
            i_fu_36 <= add_ln281_fu_54_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            i_fu_36 <= 2'd0;
        end
    end
end

always @ (*) begin
    if ((ap_start_int == 1'b0)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b1) & (icmp_ln281_fu_48_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b1) & (ap_loop_exit_ready == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_sig_allocacmp_i_4 = 2'd0;
    end else begin
        ap_sig_allocacmp_i_4 = i_fu_36;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b1) & (i_4_load_fu_45_p1 == 2'd0) & (icmp_ln281_fu_48_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1))) begin
        bunded_train_chv_0_ap_vld = 1'b1;
    end else begin
        bunded_train_chv_0_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b1) & (i_4_load_fu_45_p1 == 2'd1) & (icmp_ln281_fu_48_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1))) begin
        bunded_train_chv_1_ap_vld = 1'b1;
    end else begin
        bunded_train_chv_1_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if ((~(i_4_load_fu_45_p1 == 2'd1) & ~(i_4_load_fu_45_p1 == 2'd0) & (ap_start_int == 1'b1) & (icmp_ln281_fu_48_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1))) begin
        bunded_train_chv_2_ap_vld = 1'b1;
    end else begin
        bunded_train_chv_2_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b1) & (i_4_load_fu_45_p1 == 2'd1) & (icmp_ln281_fu_48_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1))) begin
        hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1_ap_vld = 1'b1;
    end else begin
        hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b1) & (i_4_load_fu_45_p1 == 2'd0) & (icmp_ln281_fu_48_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1))) begin
        hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2_ap_vld = 1'b1;
    end else begin
        hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if ((~(i_4_load_fu_45_p1 == 2'd1) & ~(i_4_load_fu_45_p1 == 2'd0) & (ap_start_int == 1'b1) & (icmp_ln281_fu_48_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1))) begin
        hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_ap_vld = 1'b1;
    end else begin
        hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_ap_vld = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln281_fu_54_p2 = (ap_sig_allocacmp_i_4 + 2'd1);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (ap_start_int == 1'b0);
end

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign bunded_train_chv_0 = 32'd0;

assign bunded_train_chv_1 = 32'd0;

assign bunded_train_chv_2 = 32'd0;

assign hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_1 = 32'd0;

assign hdv_engine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t_2 = 32'd0;

assign hdv_mulengine_bool_op_mode_t_frame_in_t_stream_chv_p_t_chv_t_bhv_p_t_lhv_p_t = 32'd0;

assign i_4_load_fu_45_p1 = ap_sig_allocacmp_i_4;

assign icmp_ln281_fu_48_p2 = ((ap_sig_allocacmp_i_4 == 2'd3) ? 1'b1 : 1'b0);

endmodule //hdv_engine_hdv_engine_Pipeline_VITIS_LOOP_281_2