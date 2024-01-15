// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Sat Jan 13 21:18:12 2024
// Host        : IC_EDA running 64-bit CentOS Linux release 7.9.2009 (Core)
// Command     : write_verilog -force -mode synth_stub
//               /home/ICer/my_ic/project/wild_fire/src/ipcore/eth_sync_fifo_2048x32b/eth_sync_fifo_2048x32b_stub.v
// Design      : eth_sync_fifo_2048x32b
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_4,Vivado 2019.1" *)
module eth_sync_fifo_2048x32b(clk, srst, din, wr_en, rd_en, dout, full, almost_full, 
  empty, almost_empty)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[31:0],wr_en,rd_en,dout[31:0],full,almost_full,empty,almost_empty" */;
  input clk;
  input srst;
  input [31:0]din;
  input wr_en;
  input rd_en;
  output [31:0]dout;
  output full;
  output almost_full;
  output empty;
  output almost_empty;
endmodule
