-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
-- Date        : Sat Jan 13 21:18:12 2024
-- Host        : IC_EDA running 64-bit CentOS Linux release 7.9.2009 (Core)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/ICer/my_ic/project/wild_fire/src/ipcore/eth_sync_fifo_2048x32b/eth_sync_fifo_2048x32b_stub.vhdl
-- Design      : eth_sync_fifo_2048x32b
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eth_sync_fifo_2048x32b is
  Port ( 
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    full : out STD_LOGIC;
    almost_full : out STD_LOGIC;
    empty : out STD_LOGIC;
    almost_empty : out STD_LOGIC
  );

end eth_sync_fifo_2048x32b;

architecture stub of eth_sync_fifo_2048x32b is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,srst,din[31:0],wr_en,rd_en,dout[31:0],full,almost_full,empty,almost_empty";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_2_4,Vivado 2019.1";
begin
end;
