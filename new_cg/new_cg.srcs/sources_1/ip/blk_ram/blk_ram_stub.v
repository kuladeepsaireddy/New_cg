// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Wed Aug 23 03:04:15 2017
// Host        : Sai-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/mygit/new_CG_bkup/new_cg/new_cg.srcs/sources_1/ip/blk_ram/blk_ram_stub.v
// Design      : blk_ram
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z045ffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_1,Vivado 2015.4" *)
module blk_ram(clka, wea, addra, dina, clkb, rstb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[9:0],dina[31:0],clkb,rstb,addrb[9:0],doutb[31:0]" */;
  input clka;
  input [0:0]wea;
  input [9:0]addra;
  input [31:0]dina;
  input clkb;
  input rstb;
  input [9:0]addrb;
  output [31:0]doutb;
endmodule
