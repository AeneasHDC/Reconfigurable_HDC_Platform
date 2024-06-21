; ModuleID = 'C:/Reconfigurable_HDC_Platform-1/main/_hdc_hls_xilinx/solution1/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%struct.op_mode_t = type { %"struct.ap_uint<2>", %"struct.ap_uint<3>" }
%"struct.ap_uint<2>" = type { %"struct.ap_int_base<2, false>" }
%"struct.ap_int_base<2, false>" = type { %"struct.ssdm_int<2, false>" }
%"struct.ssdm_int<2, false>" = type { i2 }
%"struct.ap_uint<3>" = type { %"struct.ap_int_base<3, false>" }
%"struct.ap_int_base<3, false>" = type { %"struct.ssdm_int<3, false>" }
%"struct.ssdm_int<3, false>" = type { i3 }
%struct.frame_in_t = type { %"struct.ap_uint<2>", %"struct.ap_uint<10>", %"struct.ap_uint<10>" }
%"struct.ap_uint<10>" = type { %"struct.ap_int_base<10, false>" }
%"struct.ap_int_base<10, false>" = type { %"struct.ssdm_int<10, false>" }
%"struct.ssdm_int<10, false>" = type { i10 }
%"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>" = type { %"struct.hls::axis<ap_uint<8>, 1, 1, 1>" }
%"struct.hls::axis<ap_uint<8>, 1, 1, 1>" = type { %"struct.ap_uint<8>", %"struct.ap_uint<1>", %"struct.ap_uint<1>", %"struct.ap_uint<1>", %"struct.ap_uint<1>", %"struct.ap_uint<1>", %"struct.ap_uint<1>" }
%"struct.ap_uint<8>" = type { %"struct.ap_int_base<8, false>" }
%"struct.ap_int_base<8, false>" = type { %"class.std::ios_base::Init" }
%"class.std::ios_base::Init" = type { i8 }
%"struct.ap_uint<1>" = type { %"struct.ap_int_base<1, false>" }
%"struct.ap_int_base<1, false>" = type { %"struct.ssdm_int<1, false>" }
%"struct.ssdm_int<1, false>" = type { i1 }
%struct.chv_p_t = type { [1 x %struct.chv_t] }
%struct.chv_t = type { [64 x %"struct.ap_uint<32>"] }
%"struct.ap_uint<32>" = type { %"struct.ap_int_base<32, false>" }
%"struct.ap_int_base<32, false>" = type { %"struct.ssdm_int<32, false>" }
%"struct.ssdm_int<32, false>" = type { i32 }
%struct.bhv_p_t = type { [1 x %struct.bhv_t] }
%struct.bhv_t = type { [64 x %"struct.ap_uint<1>"] }
%struct.pred_class_t = type { %"struct.ap_uint<6>" }
%"struct.ap_uint<6>" = type { %"struct.ap_int_base<6, false>" }
%"struct.ap_int_base<6, false>" = type { %"struct.ssdm_int<6, false>" }
%"struct.ssdm_int<6, false>" = type { i6 }
%struct.sys_status_t = type { %"struct.ap_uint<5>" }
%"struct.ap_uint<5>" = type { %"struct.ap_int_base<5, false>" }
%"struct.ap_int_base<5, false>" = type { %"struct.ssdm_int<5, false>" }
%"struct.ssdm_int<5, false>" = type { i5 }

; Function Attrs: noinline
define void @apatb_hdv_engine_ir(i1* noalias nocapture nonnull readonly dereferenceable(1) %nrst_i, %struct.op_mode_t* nocapture readonly %op_mode_i, %struct.frame_in_t* nocapture readonly %frame_in, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* noalias nonnull dereferenceable(7) %sdata_i, %struct.chv_p_t* noalias nocapture nonnull readonly dereferenceable(256) %chv_i, %struct.chv_t* noalias nocapture nonnull %chv_o, %struct.bhv_p_t* noalias nocapture nonnull readonly dereferenceable(64) %bhv_i, %struct.bhv_p_t* noalias nocapture nonnull readonly dereferenceable(64) %lhv_i, %struct.pred_class_t* noalias nocapture nonnull readonly dereferenceable(1) %lable_class_i, %struct.pred_class_t* noalias nocapture nonnull %pred_class_o, %struct.sys_status_t* noalias nocapture nonnull %status_o) local_unnamed_addr #0 {
entry:
  %nrst_i_copy = alloca i1, align 512
  %sdata_i_copy.data = alloca i8
  %sdata_i_copy.keep = alloca i1
  %sdata_i_copy.strb = alloca i1
  %sdata_i_copy.user = alloca i1
  %sdata_i_copy.last = alloca i1
  %sdata_i_copy.id = alloca i1
  %sdata_i_copy.dest = alloca i1
  %chv_i_copy = alloca i2048, align 512
  %chv_o_copy = alloca i2048, align 512
  %bhv_i_copy = alloca i64, align 512
  %lhv_i_copy = alloca i64, align 512
  %lable_class_i_copy = alloca i6, align 512
  %pred_class_o_copy = alloca i6, align 512
  %status_o_copy = alloca i5, align 512
  call fastcc void @copy_in(i1* nonnull %nrst_i, i1* nonnull align 512 %nrst_i_copy, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* nonnull %sdata_i, i8* %sdata_i_copy.data, i1* %sdata_i_copy.keep, i1* %sdata_i_copy.strb, i1* %sdata_i_copy.user, i1* %sdata_i_copy.last, i1* %sdata_i_copy.id, i1* %sdata_i_copy.dest, %struct.chv_p_t* nonnull %chv_i, i2048* nonnull align 512 %chv_i_copy, %struct.chv_t* nonnull %chv_o, i2048* nonnull align 512 %chv_o_copy, %struct.bhv_p_t* nonnull %bhv_i, i64* nonnull align 512 %bhv_i_copy, %struct.bhv_p_t* nonnull %lhv_i, i64* nonnull align 512 %lhv_i_copy, %struct.pred_class_t* nonnull %lable_class_i, i6* nonnull align 512 %lable_class_i_copy, %struct.pred_class_t* nonnull %pred_class_o, i6* nonnull align 512 %pred_class_o_copy, %struct.sys_status_t* nonnull %status_o, i5* nonnull align 512 %status_o_copy)
  call void @apatb_hdv_engine_hw(i1* %nrst_i_copy, %struct.op_mode_t* %op_mode_i, %struct.frame_in_t* %frame_in, i8* %sdata_i_copy.data, i1* %sdata_i_copy.keep, i1* %sdata_i_copy.strb, i1* %sdata_i_copy.user, i1* %sdata_i_copy.last, i1* %sdata_i_copy.id, i1* %sdata_i_copy.dest, i2048* %chv_i_copy, i2048* %chv_o_copy, i64* %bhv_i_copy, i64* %lhv_i_copy, i6* %lable_class_i_copy, i6* %pred_class_o_copy, i5* %status_o_copy)
  call void @copy_back(i1* %nrst_i, i1* %nrst_i_copy, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %sdata_i, i8* %sdata_i_copy.data, i1* %sdata_i_copy.keep, i1* %sdata_i_copy.strb, i1* %sdata_i_copy.user, i1* %sdata_i_copy.last, i1* %sdata_i_copy.id, i1* %sdata_i_copy.dest, %struct.chv_p_t* %chv_i, i2048* %chv_i_copy, %struct.chv_t* %chv_o, i2048* %chv_o_copy, %struct.bhv_p_t* %bhv_i, i64* %bhv_i_copy, %struct.bhv_p_t* %lhv_i, i64* %lhv_i_copy, %struct.pred_class_t* %lable_class_i, i6* %lable_class_i_copy, %struct.pred_class_t* %pred_class_o, i6* %pred_class_o_copy, %struct.sys_status_t* %status_o, i5* %status_o_copy)
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @copy_in(i1* noalias readonly "unpacked"="0", i1* noalias align 512 "unpacked"="1", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* noalias "unpacked"="2", i8* noalias "unpacked"="3.0" %_V_data_V, i1* noalias "unpacked"="3.1" %_V_keep_V, i1* noalias "unpacked"="3.2" %_V_strb_V, i1* noalias "unpacked"="3.3" %_V_user_V, i1* noalias "unpacked"="3.4" %_V_last_V, i1* noalias "unpacked"="3.5" %_V_id_V, i1* noalias "unpacked"="3.6" %_V_dest_V, %struct.chv_p_t* noalias readonly "unpacked"="4", i2048* noalias align 512 "unpacked"="5", %struct.chv_t* noalias readonly "unpacked"="6", i2048* noalias align 512 "unpacked"="7", %struct.bhv_p_t* noalias readonly "unpacked"="8", i64* noalias align 512 "unpacked"="9", %struct.bhv_p_t* noalias readonly "unpacked"="10", i64* noalias align 512 "unpacked"="11", %struct.pred_class_t* noalias readonly "unpacked"="12", i6* noalias nocapture align 512 "unpacked"="13.0", %struct.pred_class_t* noalias readonly "unpacked"="14", i6* noalias nocapture align 512 "unpacked"="15.0", %struct.sys_status_t* noalias readonly "unpacked"="16", i5* noalias nocapture align 512 "unpacked"="17.0") unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>.80"(i8* %_V_data_V, i1* %_V_keep_V, i1* %_V_strb_V, i1* %_V_user_V, i1* %_V_last_V, i1* %_V_id_V, i1* %_V_dest_V, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %2)
  call fastcc void @onebyonecpy_hls.p0struct.chv_p_t(i2048* align 512 %4, %struct.chv_p_t* %3)
  call fastcc void @onebyonecpy_hls.p0struct.chv_t.55(i2048* align 512 %6, %struct.chv_t* %5)
  call fastcc void @onebyonecpy_hls.p0struct.bhv_p_t(i64* align 512 %8, %struct.bhv_p_t* %7)
  call fastcc void @onebyonecpy_hls.p0struct.bhv_p_t(i64* align 512 %10, %struct.bhv_p_t* %9)
  call fastcc void @onebyonecpy_hls.p0struct.pred_class_t(i6* align 512 %12, %struct.pred_class_t* %11)
  call fastcc void @onebyonecpy_hls.p0struct.pred_class_t(i6* align 512 %14, %struct.pred_class_t* %13)
  call fastcc void @onebyonecpy_hls.p0struct.sys_status_t(i5* align 512 %16, %struct.sys_status_t* %15)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0i1(i1* noalias align 512 %dst, i1* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i1* %dst, null
  %1 = icmp eq i1* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = bitcast i1* %src to i8*
  %4 = load i8, i8* %3
  %5 = trunc i8 %4 to i1
  store i1 %5, i1* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"(%"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* noalias align 512 %dst, i8* noalias "unpacked"="1.0" %src_V_data_V, i1* noalias "unpacked"="1.1" %src_V_keep_V, i1* noalias "unpacked"="1.2" %src_V_strb_V, i1* noalias "unpacked"="1.3" %src_V_user_V, i1* noalias "unpacked"="1.4" %src_V_last_V, i1* noalias "unpacked"="1.5" %src_V_id_V, i1* noalias "unpacked"="1.6" %src_V_dest_V) unnamed_addr #3 {
entry:
  %0 = icmp eq %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %dst, null
  %1 = or i1 %0, false
  br i1 %1, label %ret, label %copy

copy:                                             ; preds = %entry
  call fastcc void @"streamcpy_hls.p0class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"(%"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* nonnull align 512 %dst, i8* %src_V_data_V, i1* %src_V_keep_V, i1* %src_V_strb_V, i1* %src_V_user_V, i1* %src_V_last_V, i1* %src_V_id_V, i1* %src_V_dest_V)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @"streamcpy_hls.p0class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"(%"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* noalias nocapture align 512, i8* noalias nocapture "unpacked"="1.0" %_V_data_V, i1* noalias nocapture "unpacked"="1.1" %_V_keep_V, i1* noalias nocapture "unpacked"="1.2" %_V_strb_V, i1* noalias nocapture "unpacked"="1.3" %_V_user_V, i1* noalias nocapture "unpacked"="1.4" %_V_last_V, i1* noalias nocapture "unpacked"="1.5" %_V_id_V, i1* noalias nocapture "unpacked"="1.6" %_V_dest_V) unnamed_addr #4 {
entry:
  %1 = alloca %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"
  %2 = alloca i8
  %3 = alloca i1
  %4 = alloca i1
  %5 = alloca i1
  %6 = alloca i1
  %7 = alloca i1
  %8 = alloca i1
  br label %empty

empty:                                            ; preds = %push, %entry
  %9 = call i1 @fpga_fifo_not_empty_1(i8* %_V_data_V)
  br i1 %9, label %push, label %ret

push:                                             ; preds = %empty
  call void @fpga_fifo_pop_1(i8* %2, i8* %_V_data_V)
  %10 = load volatile i8, i8* %2
  %11 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 0
  %12 = bitcast %"struct.ap_uint<8>"* %11 to i8*
  store i8 %10, i8* %12
  %13 = bitcast i1* %8 to i8*
  %14 = bitcast i1* %_V_keep_V to i8*
  call void @fpga_fifo_pop_1(i8* %13, i8* %14)
  %15 = bitcast i1* %8 to i8*
  %16 = load i8, i8* %15
  %17 = trunc i8 %16 to i1
  %18 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 1
  %19 = bitcast %"struct.ap_uint<1>"* %18 to i1*
  store i1 %17, i1* %19
  %20 = bitcast i1* %7 to i8*
  %21 = bitcast i1* %_V_strb_V to i8*
  call void @fpga_fifo_pop_1(i8* %20, i8* %21)
  %22 = bitcast i1* %7 to i8*
  %23 = load i8, i8* %22
  %24 = trunc i8 %23 to i1
  %25 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 2
  %26 = bitcast %"struct.ap_uint<1>"* %25 to i1*
  store i1 %24, i1* %26
  %27 = bitcast i1* %6 to i8*
  %28 = bitcast i1* %_V_user_V to i8*
  call void @fpga_fifo_pop_1(i8* %27, i8* %28)
  %29 = bitcast i1* %6 to i8*
  %30 = load i8, i8* %29
  %31 = trunc i8 %30 to i1
  %32 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 3
  %33 = bitcast %"struct.ap_uint<1>"* %32 to i1*
  store i1 %31, i1* %33
  %34 = bitcast i1* %5 to i8*
  %35 = bitcast i1* %_V_last_V to i8*
  call void @fpga_fifo_pop_1(i8* %34, i8* %35)
  %36 = bitcast i1* %5 to i8*
  %37 = load i8, i8* %36
  %38 = trunc i8 %37 to i1
  %39 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 4
  %40 = bitcast %"struct.ap_uint<1>"* %39 to i1*
  store i1 %38, i1* %40
  %41 = bitcast i1* %4 to i8*
  %42 = bitcast i1* %_V_id_V to i8*
  call void @fpga_fifo_pop_1(i8* %41, i8* %42)
  %43 = bitcast i1* %4 to i8*
  %44 = load i8, i8* %43
  %45 = trunc i8 %44 to i1
  %46 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 5
  %47 = bitcast %"struct.ap_uint<1>"* %46 to i1*
  store i1 %45, i1* %47
  %48 = bitcast i1* %3 to i8*
  %49 = bitcast i1* %_V_dest_V to i8*
  call void @fpga_fifo_pop_1(i8* %48, i8* %49)
  %50 = bitcast i1* %3 to i8*
  %51 = load i8, i8* %50
  %52 = trunc i8 %51 to i1
  %53 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 6
  %54 = bitcast %"struct.ap_uint<1>"* %53 to i1*
  store i1 %52, i1* %54
  %55 = bitcast %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1 to i8*
  %56 = bitcast %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %0 to i8*
  call void @fpga_fifo_push_7(i8* %55, i8* %56)
  br label %empty, !llvm.loop !5

ret:                                              ; preds = %empty
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.chv_p_t(i2048* noalias align 512 %dst, %struct.chv_p_t* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i2048* %dst, null
  %1 = icmp eq %struct.chv_p_t* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0 = getelementptr %struct.chv_p_t, %struct.chv_p_t* %src, i64 0, i32 0
  call void @arraycpy_hls.p0a1struct.chv_t(i2048* nonnull %dst, i64 0, [1 x %struct.chv_t]* %src.0, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @arraycpy_hls.p0a1struct.chv_t(i2048* %dst, i64 %dst_idx, [1 x %struct.chv_t]* readonly %src, i64 %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [1 x %struct.chv_t]* %src, null
  %1 = icmp eq i2048* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond3 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond3, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx4 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [1 x %struct.chv_t], [1 x %struct.chv_t]* %src, i64 0, i64 %for.loop.idx4, i32 0
  %3 = mul i64 2048, %for.loop.idx4
  %4 = add i64 %dst_idx, %3
  call void @"arraycpy_hls.p0a64struct.ap_uint<32>"(i2048* %dst, i64 %4, [64 x %"struct.ap_uint<32>"]* %src.addr.01, i64 64)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx4, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.chv_t(%struct.chv_t* noalias %dst, i2048* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.chv_t* %dst, null
  %1 = icmp eq i2048* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0 = getelementptr %struct.chv_t, %struct.chv_t* %dst, i64 0, i32 0
  call void @"arraycpy_hls.p0a64struct.ap_uint<32>.64"([64 x %"struct.ap_uint<32>"]* %dst.0, i2048* nonnull %src, i64 0, i64 64)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.sys_status_t(i5* noalias nocapture align 512 "unpacked"="0.0" %dst, %struct.sys_status_t* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.sys_status_t* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.0.05 = getelementptr %struct.sys_status_t, %struct.sys_status_t* %src, i64 0, i32 0, i32 0, i32 0, i32 0
  %1 = bitcast i5* %src.0.0.0.05 to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i5
  store i5 %3, i5* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @copy_out(i1* noalias "unpacked"="0", i1* noalias readonly align 512 "unpacked"="1", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* noalias "unpacked"="2", i8* noalias "unpacked"="3.0" %_V_data_V, i1* noalias "unpacked"="3.1" %_V_keep_V, i1* noalias "unpacked"="3.2" %_V_strb_V, i1* noalias "unpacked"="3.3" %_V_user_V, i1* noalias "unpacked"="3.4" %_V_last_V, i1* noalias "unpacked"="3.5" %_V_id_V, i1* noalias "unpacked"="3.6" %_V_dest_V, %struct.chv_p_t* noalias "unpacked"="4", i2048* noalias readonly align 512 "unpacked"="5", %struct.chv_t* noalias "unpacked"="6", i2048* noalias readonly align 512 "unpacked"="7", %struct.bhv_p_t* noalias "unpacked"="8", i64* noalias readonly align 512 "unpacked"="9", %struct.bhv_p_t* noalias "unpacked"="10", i64* noalias readonly align 512 "unpacked"="11", %struct.pred_class_t* noalias "unpacked"="12", i6* noalias nocapture readonly align 512 "unpacked"="13.0", %struct.pred_class_t* noalias "unpacked"="14", i6* noalias nocapture readonly align 512 "unpacked"="15.0", %struct.sys_status_t* noalias "unpacked"="16", i5* noalias nocapture readonly align 512 "unpacked"="17.0") unnamed_addr #6 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"(%"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %2, i8* %_V_data_V, i1* %_V_keep_V, i1* %_V_strb_V, i1* %_V_user_V, i1* %_V_last_V, i1* %_V_id_V, i1* %_V_dest_V)
  call fastcc void @onebyonecpy_hls.p0struct.chv_p_t.68(%struct.chv_p_t* %3, i2048* align 512 %4)
  call fastcc void @onebyonecpy_hls.p0struct.chv_t(%struct.chv_t* %5, i2048* align 512 %6)
  call fastcc void @onebyonecpy_hls.p0struct.bhv_p_t.41(%struct.bhv_p_t* %7, i64* align 512 %8)
  call fastcc void @onebyonecpy_hls.p0struct.bhv_p_t.41(%struct.bhv_p_t* %9, i64* align 512 %10)
  call fastcc void @onebyonecpy_hls.p0struct.pred_class_t.22(%struct.pred_class_t* %11, i6* align 512 %12)
  call fastcc void @onebyonecpy_hls.p0struct.pred_class_t.22(%struct.pred_class_t* %13, i6* align 512 %14)
  call fastcc void @onebyonecpy_hls.p0struct.sys_status_t.10(%struct.sys_status_t* %15, i5* align 512 %16)
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.sys_status_t.10(%struct.sys_status_t* noalias "unpacked"="0" %dst, i5* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.sys_status_t* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.0.06 = getelementptr %struct.sys_status_t, %struct.sys_status_t* %dst, i64 0, i32 0, i32 0, i32 0, i32 0
  %1 = bitcast i5* %src to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i5
  store i5 %3, i5* %dst.0.0.0.06, align 1
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.pred_class_t(i6* noalias nocapture align 512 "unpacked"="0.0" %dst, %struct.pred_class_t* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.pred_class_t* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.0.05 = getelementptr %struct.pred_class_t, %struct.pred_class_t* %src, i64 0, i32 0, i32 0, i32 0, i32 0
  %1 = bitcast i6* %src.0.0.0.05 to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i6
  store i6 %3, i6* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.pred_class_t.22(%struct.pred_class_t* noalias "unpacked"="0" %dst, i6* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.pred_class_t* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.0.06 = getelementptr %struct.pred_class_t, %struct.pred_class_t* %dst, i64 0, i32 0, i32 0, i32 0, i32 0
  %1 = bitcast i6* %src to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i6
  store i6 %3, i6* %dst.0.0.0.06, align 1
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.bhv_p_t(i64* noalias align 512 %dst, %struct.bhv_p_t* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i64* %dst, null
  %1 = icmp eq %struct.bhv_p_t* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0 = getelementptr %struct.bhv_p_t, %struct.bhv_p_t* %src, i64 0, i32 0
  call void @arraycpy_hls.p0a1struct.bhv_t.33(i64* nonnull %dst, i64 0, [1 x %struct.bhv_t]* %src.0, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @arraycpy_hls.p0a1struct.bhv_t.33(i64* %dst, i64 %dst_idx, [1 x %struct.bhv_t]* readonly %src, i64 %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [1 x %struct.bhv_t]* %src, null
  %1 = icmp eq i64* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond3 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond3, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx4 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.01 = getelementptr [1 x %struct.bhv_t], [1 x %struct.bhv_t]* %src, i64 0, i64 %for.loop.idx4, i32 0
  %3 = mul i64 64, %for.loop.idx4
  %4 = add i64 %dst_idx, %3
  call void @"arraycpy_hls.p0a64struct.ap_uint<1>.36"(i64* %dst, i64 %4, [64 x %"struct.ap_uint<1>"]* %src.addr.01, i64 64)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx4, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @"arraycpy_hls.p0a64struct.ap_uint<1>.36"(i64* %dst, i64 %dst_idx, [64 x %"struct.ap_uint<1>"]* readonly %src, i64 %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [64 x %"struct.ap_uint<1>"]* %src, null
  %1 = icmp eq i64* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [64 x %"struct.ap_uint<1>"], [64 x %"struct.ap_uint<1>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = add i64 %dst_idx, %for.loop.idx8
  %4 = bitcast i1* %src.addr.0.0.05 to i8*
  %5 = load i8, i8* %4
  %6 = trunc i8 %5 to i1
  %7 = load i64, i64* %dst, align 1
  %8 = shl i64 1, %3
  %9 = zext i1 %6 to i64
  %10 = shl i64 %9, %3
  %thr.xor1 = xor i64 %8, -1
  %thr.and2 = and i64 %7, %thr.xor1
  %thr.or3 = or i64 %thr.and2, %10
  store i64 %thr.or3, i64* %dst, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.bhv_p_t.41(%struct.bhv_p_t* noalias %dst, i64* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.bhv_p_t* %dst, null
  %1 = icmp eq i64* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0 = getelementptr %struct.bhv_p_t, %struct.bhv_p_t* %dst, i64 0, i32 0
  call void @arraycpy_hls.p0a1struct.bhv_t.44([1 x %struct.bhv_t]* %dst.0, i64* nonnull %src, i64 0, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @arraycpy_hls.p0a1struct.bhv_t.44([1 x %struct.bhv_t]* %dst, i64* readonly %src, i64 %src_idx, i64 %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq i64* %src, null
  %1 = icmp eq [1 x %struct.bhv_t]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond3 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond3, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx4 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = mul i64 64, %for.loop.idx4
  %4 = add i64 %src_idx, %3
  %dst.addr.02 = getelementptr [1 x %struct.bhv_t], [1 x %struct.bhv_t]* %dst, i64 0, i64 %for.loop.idx4, i32 0
  call void @"arraycpy_hls.p0a64struct.ap_uint<1>.47"([64 x %"struct.ap_uint<1>"]* %dst.addr.02, i64* %src, i64 %4, i64 64)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx4, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @"arraycpy_hls.p0a64struct.ap_uint<1>.47"([64 x %"struct.ap_uint<1>"]* %dst, i64* readonly %src, i64 %src_idx, i64 %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq i64* %src, null
  %1 = icmp eq [64 x %"struct.ap_uint<1>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = add i64 %src_idx, %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [64 x %"struct.ap_uint<1>"], [64 x %"struct.ap_uint<1>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i64, i64* %src, align 1
  %5 = lshr i64 %4, %3
  %.partselect = trunc i64 %5 to i1
  store i1 %.partselect, i1* %dst.addr.0.0.06, align 1
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.chv_t.55(i2048* noalias align 512 %dst, %struct.chv_t* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i2048* %dst, null
  %1 = icmp eq %struct.chv_t* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0 = getelementptr %struct.chv_t, %struct.chv_t* %src, i64 0, i32 0
  call void @"arraycpy_hls.p0a64struct.ap_uint<32>"(i2048* nonnull %dst, i64 0, [64 x %"struct.ap_uint<32>"]* %src.0, i64 64)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @"arraycpy_hls.p0a64struct.ap_uint<32>"(i2048* %dst, i64 %dst_idx, [64 x %"struct.ap_uint<32>"]* readonly %src, i64 %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq [64 x %"struct.ap_uint<32>"]* %src, null
  %1 = icmp eq i2048* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [64 x %"struct.ap_uint<32>"], [64 x %"struct.ap_uint<32>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = mul i64 32, %for.loop.idx8
  %4 = add i64 %dst_idx, %3
  %5 = load i32, i32* %src.addr.0.0.05, align 4
  %6 = load i2048, i2048* %dst, align 4
  %7 = zext i64 %4 to i2048
  %8 = shl i2048 4294967295, %7
  %9 = zext i32 %5 to i2048
  %10 = shl i2048 %9, %7
  %thr.xor1 = xor i2048 %8, -1
  %thr.and2 = and i2048 %6, %thr.xor1
  %thr.or3 = or i2048 %thr.and2, %10
  store i2048 %thr.or3, i2048* %dst, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @"arraycpy_hls.p0a64struct.ap_uint<32>.64"([64 x %"struct.ap_uint<32>"]* %dst, i2048* readonly %src, i64 %src_idx, i64 %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq i2048* %src, null
  %1 = icmp eq [64 x %"struct.ap_uint<32>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = mul i64 32, %for.loop.idx8
  %4 = add i64 %src_idx, %3
  %dst.addr.0.0.06 = getelementptr [64 x %"struct.ap_uint<32>"], [64 x %"struct.ap_uint<32>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %5 = load i2048, i2048* %src, align 4
  %6 = zext i64 %4 to i2048
  %7 = lshr i2048 %5, %6
  %.partselect = trunc i2048 %7 to i32
  store i32 %.partselect, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define internal fastcc void @onebyonecpy_hls.p0struct.chv_p_t.68(%struct.chv_p_t* noalias %dst, i2048* noalias readonly align 512 %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %struct.chv_p_t* %dst, null
  %1 = icmp eq i2048* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0 = getelementptr %struct.chv_p_t, %struct.chv_p_t* %dst, i64 0, i32 0
  call void @arraycpy_hls.p0a1struct.chv_t.71([1 x %struct.chv_t]* %dst.0, i2048* nonnull %src, i64 0, i64 1)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse
define void @arraycpy_hls.p0a1struct.chv_t.71([1 x %struct.chv_t]* %dst, i2048* readonly %src, i64 %src_idx, i64 %num) local_unnamed_addr #5 {
entry:
  %0 = icmp eq i2048* %src, null
  %1 = icmp eq [1 x %struct.chv_t]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond3 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond3, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx4 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = mul i64 2048, %for.loop.idx4
  %4 = add i64 %src_idx, %3
  %dst.addr.02 = getelementptr [1 x %struct.chv_t], [1 x %struct.chv_t]* %dst, i64 0, i64 %for.loop.idx4, i32 0
  call void @"arraycpy_hls.p0a64struct.ap_uint<32>.64"([64 x %"struct.ap_uint<32>"]* %dst.addr.02, i2048* %src, i64 %4, i64 64)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx4, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>.80"(i8* noalias "unpacked"="0.0" %dst_V_data_V, i1* noalias "unpacked"="0.1" %dst_V_keep_V, i1* noalias "unpacked"="0.2" %dst_V_strb_V, i1* noalias "unpacked"="0.3" %dst_V_user_V, i1* noalias "unpacked"="0.4" %dst_V_last_V, i1* noalias "unpacked"="0.5" %dst_V_id_V, i1* noalias "unpacked"="0.6" %dst_V_dest_V, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* noalias %src) unnamed_addr #3 {
entry:
  %0 = icmp eq %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %src, null
  %1 = or i1 false, %0
  br i1 %1, label %ret, label %copy

copy:                                             ; preds = %entry
  call fastcc void @"streamcpy_hls.p0class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>.83"(i8* %dst_V_data_V, i1* %dst_V_keep_V, i1* %dst_V_strb_V, i1* %dst_V_user_V, i1* %dst_V_last_V, i1* %dst_V_id_V, i1* %dst_V_dest_V, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* nonnull %src)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline
define internal fastcc void @"streamcpy_hls.p0class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>.83"(i8* noalias nocapture "unpacked"="0.0" %_V_data_V, i1* noalias nocapture "unpacked"="0.1" %_V_keep_V, i1* noalias nocapture "unpacked"="0.2" %_V_strb_V, i1* noalias nocapture "unpacked"="0.3" %_V_user_V, i1* noalias nocapture "unpacked"="0.4" %_V_last_V, i1* noalias nocapture "unpacked"="0.5" %_V_id_V, i1* noalias nocapture "unpacked"="0.6" %_V_dest_V, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* noalias nocapture) unnamed_addr #4 {
entry:
  %1 = alloca %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"
  %2 = alloca %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"
  br label %empty

empty:                                            ; preds = %push, %entry
  %3 = bitcast %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %0 to i8*
  %4 = call i1 @fpga_fifo_not_empty_7(i8* %3)
  br i1 %4, label %push, label %ret

push:                                             ; preds = %empty
  %5 = bitcast %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %2 to i8*
  %6 = bitcast %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %0 to i8*
  call void @fpga_fifo_pop_7(i8* %5, i8* %6)
  %7 = load volatile %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %2
  store %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>" %7, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1
  %8 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 0
  %9 = bitcast %"struct.ap_uint<8>"* %8 to i8*
  call void @fpga_fifo_push_1(i8* %9, i8* %_V_data_V)
  %10 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 1
  %11 = bitcast %"struct.ap_uint<1>"* %10 to i1*
  %12 = bitcast i1* %11 to i8*
  %13 = bitcast i1* %_V_keep_V to i8*
  call void @fpga_fifo_push_1(i8* %12, i8* %13)
  %14 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 2
  %15 = bitcast %"struct.ap_uint<1>"* %14 to i1*
  %16 = bitcast i1* %15 to i8*
  %17 = bitcast i1* %_V_strb_V to i8*
  call void @fpga_fifo_push_1(i8* %16, i8* %17)
  %18 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 3
  %19 = bitcast %"struct.ap_uint<1>"* %18 to i1*
  %20 = bitcast i1* %19 to i8*
  %21 = bitcast i1* %_V_user_V to i8*
  call void @fpga_fifo_push_1(i8* %20, i8* %21)
  %22 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 4
  %23 = bitcast %"struct.ap_uint<1>"* %22 to i1*
  %24 = bitcast i1* %23 to i8*
  %25 = bitcast i1* %_V_last_V to i8*
  call void @fpga_fifo_push_1(i8* %24, i8* %25)
  %26 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 5
  %27 = bitcast %"struct.ap_uint<1>"* %26 to i1*
  %28 = bitcast i1* %27 to i8*
  %29 = bitcast i1* %_V_id_V to i8*
  call void @fpga_fifo_push_1(i8* %28, i8* %29)
  %30 = getelementptr inbounds %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %1, i32 0, i32 0, i32 6
  %31 = bitcast %"struct.ap_uint<1>"* %30 to i1*
  %32 = bitcast i1* %31 to i8*
  %33 = bitcast i1* %_V_dest_V to i8*
  call void @fpga_fifo_push_1(i8* %32, i8* %33)
  br label %empty, !llvm.loop !5

ret:                                              ; preds = %empty
  ret void
}

declare void @apatb_hdv_engine_hw(i1*, %struct.op_mode_t*, %struct.frame_in_t*, i8*, i1*, i1*, i1*, i1*, i1*, i1*, i2048*, i2048*, i64*, i64*, i6*, i6*, i5*)

; Function Attrs: argmemonly noinline
define internal fastcc void @copy_back(i1* noalias "unpacked"="0", i1* noalias readonly align 512 "unpacked"="1", %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* noalias "unpacked"="2", i8* noalias "unpacked"="3.0" %_V_data_V, i1* noalias "unpacked"="3.1" %_V_keep_V, i1* noalias "unpacked"="3.2" %_V_strb_V, i1* noalias "unpacked"="3.3" %_V_user_V, i1* noalias "unpacked"="3.4" %_V_last_V, i1* noalias "unpacked"="3.5" %_V_id_V, i1* noalias "unpacked"="3.6" %_V_dest_V, %struct.chv_p_t* noalias "unpacked"="4", i2048* noalias readonly align 512 "unpacked"="5", %struct.chv_t* noalias "unpacked"="6", i2048* noalias readonly align 512 "unpacked"="7", %struct.bhv_p_t* noalias "unpacked"="8", i64* noalias readonly align 512 "unpacked"="9", %struct.bhv_p_t* noalias "unpacked"="10", i64* noalias readonly align 512 "unpacked"="11", %struct.pred_class_t* noalias "unpacked"="12", i6* noalias nocapture readonly align 512 "unpacked"="13.0", %struct.pred_class_t* noalias "unpacked"="14", i6* noalias nocapture readonly align 512 "unpacked"="15.0", %struct.sys_status_t* noalias "unpacked"="16", i5* noalias nocapture readonly align 512 "unpacked"="17.0") unnamed_addr #6 {
entry:
  call fastcc void @"onebyonecpy_hls.p0class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"(%"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %2, i8* %_V_data_V, i1* %_V_keep_V, i1* %_V_strb_V, i1* %_V_user_V, i1* %_V_last_V, i1* %_V_id_V, i1* %_V_dest_V)
  call fastcc void @onebyonecpy_hls.p0struct.chv_t(%struct.chv_t* %5, i2048* align 512 %6)
  call fastcc void @onebyonecpy_hls.p0struct.pred_class_t.22(%struct.pred_class_t* %13, i6* align 512 %14)
  call fastcc void @onebyonecpy_hls.p0struct.sys_status_t.10(%struct.sys_status_t* %15, i5* align 512 %16)
  ret void
}

define void @hdv_engine_hw_stub_wrapper(i1*, %struct.op_mode_t*, %struct.frame_in_t*, i8*, i1*, i1*, i1*, i1*, i1*, i1*, i2048*, i2048*, i64*, i64*, i6*, i6*, i5*) #7 {
entry:
  %17 = alloca %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"
  %18 = alloca %struct.chv_p_t
  %19 = alloca %struct.chv_t
  %20 = alloca %struct.bhv_p_t
  %21 = alloca %struct.bhv_p_t
  %22 = alloca %struct.pred_class_t
  %23 = alloca %struct.pred_class_t
  %24 = alloca %struct.sys_status_t
  call void @copy_out(i1* null, i1* %0, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %17, i8* %3, i1* %4, i1* %5, i1* %6, i1* %7, i1* %8, i1* %9, %struct.chv_p_t* %18, i2048* %10, %struct.chv_t* %19, i2048* %11, %struct.bhv_p_t* %20, i64* %12, %struct.bhv_p_t* %21, i64* %13, %struct.pred_class_t* %22, i6* %14, %struct.pred_class_t* %23, i6* %15, %struct.sys_status_t* %24, i5* %16)
  call void @hdv_engine_hw_stub(i1* %0, %struct.op_mode_t* %1, %struct.frame_in_t* %2, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %17, %struct.chv_p_t* %18, %struct.chv_t* %19, %struct.bhv_p_t* %20, %struct.bhv_p_t* %21, %struct.pred_class_t* %22, %struct.pred_class_t* %23, %struct.sys_status_t* %24)
  call void @copy_in(i1* null, i1* %0, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"* %17, i8* %3, i1* %4, i1* %5, i1* %6, i1* %7, i1* %8, i1* %9, %struct.chv_p_t* %18, i2048* %10, %struct.chv_t* %19, i2048* %11, %struct.bhv_p_t* %20, i64* %12, %struct.bhv_p_t* %21, i64* %13, %struct.pred_class_t* %22, i6* %14, %struct.pred_class_t* %23, i6* %15, %struct.sys_status_t* %24, i5* %16)
  ret void
}

declare void @hdv_engine_hw_stub(i1*, %struct.op_mode_t*, %struct.frame_in_t*, %"class.hls::stream<hls::axis<ap_uint<8>, 1, 1, 1>, 0>"*, %struct.chv_p_t*, %struct.chv_t*, %struct.bhv_p_t*, %struct.bhv_p_t*, %struct.pred_class_t*, %struct.pred_class_t*, %struct.sys_status_t*)

declare i1 @fpga_fifo_not_empty_7(i8*)

declare i1 @fpga_fifo_not_empty_1(i8*)

declare void @fpga_fifo_pop_7(i8*, i8*)

declare void @fpga_fifo_pop_1(i8*, i8*)

declare void @fpga_fifo_push_7(i8*, i8*)

declare void @fpga_fifo_push_1(i8*, i8*)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #4 = { argmemonly noinline "fpga.wrapper.func"="streamcpy_hls" }
attributes #5 = { argmemonly noinline norecurse "fpga.wrapper.func"="arraycpy_hls" }
attributes #6 = { argmemonly noinline "fpga.wrapper.func"="copyout" }
attributes #7 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.rotate.disable"}
