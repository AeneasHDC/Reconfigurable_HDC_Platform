// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.1 (64-bit)
// Tool Version Limit: 2023.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================

`timescale 1 ns / 1 ps

`define TV_IN_sdata_i_TDATA "../tv/cdatafile/c.hdv_engine.autotvin_sdata_i_V_data_V.dat"
`define INGRESS_STATUS_sdata_i_TDATA "../tv/stream_size/stream_ingress_status_sdata_i_V_data_V.dat"
`define TV_IN_sdata_i_TKEEP "../tv/cdatafile/c.hdv_engine.autotvin_sdata_i_V_keep_V.dat"
`define INGRESS_STATUS_sdata_i_TKEEP "../tv/stream_size/stream_ingress_status_sdata_i_V_keep_V.dat"
`define TV_IN_sdata_i_TSTRB "../tv/cdatafile/c.hdv_engine.autotvin_sdata_i_V_strb_V.dat"
`define INGRESS_STATUS_sdata_i_TSTRB "../tv/stream_size/stream_ingress_status_sdata_i_V_strb_V.dat"
`define TV_IN_sdata_i_TUSER "../tv/cdatafile/c.hdv_engine.autotvin_sdata_i_V_user_V.dat"
`define INGRESS_STATUS_sdata_i_TUSER "../tv/stream_size/stream_ingress_status_sdata_i_V_user_V.dat"
`define TV_IN_sdata_i_TLAST "../tv/cdatafile/c.hdv_engine.autotvin_sdata_i_V_last_V.dat"
`define INGRESS_STATUS_sdata_i_TLAST "../tv/stream_size/stream_ingress_status_sdata_i_V_last_V.dat"
`define TV_IN_sdata_i_TID "../tv/cdatafile/c.hdv_engine.autotvin_sdata_i_V_id_V.dat"
`define INGRESS_STATUS_sdata_i_TID "../tv/stream_size/stream_ingress_status_sdata_i_V_id_V.dat"
`define TV_IN_sdata_i_TDEST "../tv/cdatafile/c.hdv_engine.autotvin_sdata_i_V_dest_V.dat"
`define INGRESS_STATUS_sdata_i_TDEST "../tv/stream_size/stream_ingress_status_sdata_i_V_dest_V.dat"

`define AUTOTB_TRANSACTION_NUM 578

module AESL_axi_s_sdata_i (
    input clk,
    input reset,
    output [8 - 1:0] TRAN_sdata_i_TDATA,
    output TRAN_sdata_i_TKEEP,
    output TRAN_sdata_i_TSTRB,
    output TRAN_sdata_i_TUSER,
    output TRAN_sdata_i_TLAST,
    output TRAN_sdata_i_TID,
    output TRAN_sdata_i_TDEST,
    output TRAN_sdata_i_TVALID,
    input TRAN_sdata_i_TREADY,
    input ready,
    input done,
    output [31:0] transaction);

    wire TRAN_sdata_i_TVALID_temp;
    wire sdata_i_TDATA_full;
    wire sdata_i_TDATA_empty;
    reg sdata_i_TDATA_write_en;
    reg [8 - 1:0] sdata_i_TDATA_write_data;
    reg sdata_i_TDATA_read_en;
    wire [8 - 1:0] sdata_i_TDATA_read_data;
    
    fifo #(0, 8) fifo_sdata_i_TDATA (
        .reset(1'b0),
        .write_clock(clk),
        .write_en(sdata_i_TDATA_write_en),
        .write_data(sdata_i_TDATA_write_data),
        .read_clock(clk),
        .read_en(sdata_i_TDATA_read_en),
        .read_data(sdata_i_TDATA_read_data),
        .full(sdata_i_TDATA_full),
        .empty(sdata_i_TDATA_empty));
    
    always @ (*) begin
        sdata_i_TDATA_write_en <= 0;
        sdata_i_TDATA_read_en <= TRAN_sdata_i_TREADY & TRAN_sdata_i_TVALID;
    end
    
    assign TRAN_sdata_i_TDATA = sdata_i_TDATA_read_data;
    wire sdata_i_TKEEP_full;
    wire sdata_i_TKEEP_empty;
    reg sdata_i_TKEEP_write_en;
    reg [1 - 1:0] sdata_i_TKEEP_write_data;
    reg sdata_i_TKEEP_read_en;
    wire [1 - 1:0] sdata_i_TKEEP_read_data;
    
    fifo #(0, 1) fifo_sdata_i_TKEEP (
        .reset(1'b0),
        .write_clock(clk),
        .write_en(sdata_i_TKEEP_write_en),
        .write_data(sdata_i_TKEEP_write_data),
        .read_clock(clk),
        .read_en(sdata_i_TKEEP_read_en),
        .read_data(sdata_i_TKEEP_read_data),
        .full(sdata_i_TKEEP_full),
        .empty(sdata_i_TKEEP_empty));
    
    always @ (*) begin
        sdata_i_TKEEP_write_en <= 0;
        sdata_i_TKEEP_read_en <= TRAN_sdata_i_TREADY & TRAN_sdata_i_TVALID;
    end
    
    assign TRAN_sdata_i_TKEEP = sdata_i_TKEEP_read_data;
    wire sdata_i_TSTRB_full;
    wire sdata_i_TSTRB_empty;
    reg sdata_i_TSTRB_write_en;
    reg [1 - 1:0] sdata_i_TSTRB_write_data;
    reg sdata_i_TSTRB_read_en;
    wire [1 - 1:0] sdata_i_TSTRB_read_data;
    
    fifo #(0, 1) fifo_sdata_i_TSTRB (
        .reset(1'b0),
        .write_clock(clk),
        .write_en(sdata_i_TSTRB_write_en),
        .write_data(sdata_i_TSTRB_write_data),
        .read_clock(clk),
        .read_en(sdata_i_TSTRB_read_en),
        .read_data(sdata_i_TSTRB_read_data),
        .full(sdata_i_TSTRB_full),
        .empty(sdata_i_TSTRB_empty));
    
    always @ (*) begin
        sdata_i_TSTRB_write_en <= 0;
        sdata_i_TSTRB_read_en <= TRAN_sdata_i_TREADY & TRAN_sdata_i_TVALID;
    end
    
    assign TRAN_sdata_i_TSTRB = sdata_i_TSTRB_read_data;
    wire sdata_i_TUSER_full;
    wire sdata_i_TUSER_empty;
    reg sdata_i_TUSER_write_en;
    reg [1 - 1:0] sdata_i_TUSER_write_data;
    reg sdata_i_TUSER_read_en;
    wire [1 - 1:0] sdata_i_TUSER_read_data;
    
    fifo #(0, 1) fifo_sdata_i_TUSER (
        .reset(1'b0),
        .write_clock(clk),
        .write_en(sdata_i_TUSER_write_en),
        .write_data(sdata_i_TUSER_write_data),
        .read_clock(clk),
        .read_en(sdata_i_TUSER_read_en),
        .read_data(sdata_i_TUSER_read_data),
        .full(sdata_i_TUSER_full),
        .empty(sdata_i_TUSER_empty));
    
    always @ (*) begin
        sdata_i_TUSER_write_en <= 0;
        sdata_i_TUSER_read_en <= TRAN_sdata_i_TREADY & TRAN_sdata_i_TVALID;
    end
    
    assign TRAN_sdata_i_TUSER = sdata_i_TUSER_read_data;
    wire sdata_i_TLAST_full;
    wire sdata_i_TLAST_empty;
    reg sdata_i_TLAST_write_en;
    reg [1 - 1:0] sdata_i_TLAST_write_data;
    reg sdata_i_TLAST_read_en;
    wire [1 - 1:0] sdata_i_TLAST_read_data;
    
    fifo #(0, 1) fifo_sdata_i_TLAST (
        .reset(1'b0),
        .write_clock(clk),
        .write_en(sdata_i_TLAST_write_en),
        .write_data(sdata_i_TLAST_write_data),
        .read_clock(clk),
        .read_en(sdata_i_TLAST_read_en),
        .read_data(sdata_i_TLAST_read_data),
        .full(sdata_i_TLAST_full),
        .empty(sdata_i_TLAST_empty));
    
    always @ (*) begin
        sdata_i_TLAST_write_en <= 0;
        sdata_i_TLAST_read_en <= TRAN_sdata_i_TREADY & TRAN_sdata_i_TVALID;
    end
    
    assign TRAN_sdata_i_TLAST = sdata_i_TLAST_read_data;
    wire sdata_i_TID_full;
    wire sdata_i_TID_empty;
    reg sdata_i_TID_write_en;
    reg [1 - 1:0] sdata_i_TID_write_data;
    reg sdata_i_TID_read_en;
    wire [1 - 1:0] sdata_i_TID_read_data;
    
    fifo #(0, 1) fifo_sdata_i_TID (
        .reset(1'b0),
        .write_clock(clk),
        .write_en(sdata_i_TID_write_en),
        .write_data(sdata_i_TID_write_data),
        .read_clock(clk),
        .read_en(sdata_i_TID_read_en),
        .read_data(sdata_i_TID_read_data),
        .full(sdata_i_TID_full),
        .empty(sdata_i_TID_empty));
    
    always @ (*) begin
        sdata_i_TID_write_en <= 0;
        sdata_i_TID_read_en <= TRAN_sdata_i_TREADY & TRAN_sdata_i_TVALID;
    end
    
    assign TRAN_sdata_i_TID = sdata_i_TID_read_data;
    wire sdata_i_TDEST_full;
    wire sdata_i_TDEST_empty;
    reg sdata_i_TDEST_write_en;
    reg [1 - 1:0] sdata_i_TDEST_write_data;
    reg sdata_i_TDEST_read_en;
    wire [1 - 1:0] sdata_i_TDEST_read_data;
    
    fifo #(0, 1) fifo_sdata_i_TDEST (
        .reset(1'b0),
        .write_clock(clk),
        .write_en(sdata_i_TDEST_write_en),
        .write_data(sdata_i_TDEST_write_data),
        .read_clock(clk),
        .read_en(sdata_i_TDEST_read_en),
        .read_data(sdata_i_TDEST_read_data),
        .full(sdata_i_TDEST_full),
        .empty(sdata_i_TDEST_empty));
    
    always @ (*) begin
        sdata_i_TDEST_write_en <= 0;
        sdata_i_TDEST_read_en <= TRAN_sdata_i_TREADY & TRAN_sdata_i_TVALID;
    end
    
    assign TRAN_sdata_i_TDEST = sdata_i_TDEST_read_data;
    assign TRAN_sdata_i_TVALID = TRAN_sdata_i_TVALID_temp;

    
    assign TRAN_sdata_i_TVALID_temp = 0;
    
    function is_blank_char(input [7:0] in_char);
        if (in_char == " " || in_char == "\011" || in_char == "\012" || in_char == "\015") begin
            is_blank_char = 1;
        end else begin
            is_blank_char = 0;
        end
    endfunction
    
    function [1431:0] read_token(input integer fp);
        integer ret;
        begin
            read_token = "";
                    ret = 0;
                    ret = $fscanf(fp,"%s",read_token);
        end
    endfunction
    
    function [1431:0] rm_0x(input [1431:0] token);
        reg [1431:0] token_tmp;
        integer i;
        begin
            token_tmp = "";
            for (i = 0; token[15:0] != "0x"; token = token >> 8) begin
                token_tmp = (token[7:0] << (8 * i)) | token_tmp;
                i = i + 1;
            end
            rm_0x = token_tmp;
        end
    endfunction

endmodule
