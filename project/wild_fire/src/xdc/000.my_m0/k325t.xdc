##################### 语法 ################################
# 分配管脚
## set_property PACKAGE_PIN E25 [get_ports     {count[7]}]
# 电气标准
# set_property IOSTANDARD LVCMOS33 [get_ports {count[1]}]
# 驱动能力
# set_property DRIVE<2 4 6 8 12 16 24>  [get_ports {count[1]}]
# 抖动
# set_property SLEW <SLOW|FAST>  [get_ports {count[1]}]
# 上拉
# set_property PULLUP [get_ports {count[1]}]
# 下拉
# set_property PULLDOWN  [get_ports {count[1]}]
# 差分
# set_property PULLDOWN  TMDS_33  [get_ports _p]
# set_property PULLDOWN  TMDS_33  [get_ports _n]
# 收发器MGTREFCLK
# set_property LOC G7 [get_ports Q2_CLK0_GTREFCLK_PAD_N_IN ]
# set_property LOC G8 [get_ports Q2_CLK0_GTREFCLK_PAD_P_IN ]
# 收发器通道位置约束： set_property LOC “ GTXE2_CHANNEL_X* Y * ” [get_cells “gtxe_2例化路径”]
# ##---------- Set placement for gt0_gtx_wrapper_i/GTXE2_CHANNEL ------
# set_property LOC GTXE2_CHANNEL_X0Y8 [get_cells gtx_support_i/gtx_init_i/inst/gtx_i/gt0_gtx_i/gtxe2_i]
# ##---------- Set placement for gt1_gtx_wrapper_i/GTXE2_CHANNEL ------
# set_property LOC GTXE2_CHANNEL_X0Y9 [get_cells gtx_support_i/gtx_init_i/inst/gtx_i/gt1_gtx_i/gtxe2_i]
# ##---------- Set placement for gt2_gtx_wrapper_i/GTXE2_CHANNEL ------
# set_property LOC GTXE2_CHANNEL_X0Y10 [get_cells gtx_support_i/gtx_init_i/inst/gtx_i/gt2_gtx_i/gtxe2_i]
# ##---------- Set placement for gt3_gtx_wrapper_i/GTXE2_CHANNEL ------
# set_property LOC GTXE2_CHANNEL_X0Y11 [get_cells gtx_support_i/gtx_init_i/inst/gtx_i/gt3_gtx_i/gtxe2_i]


##################### CLK ################################
create_clock -period 20.000 -name sys_clk [get_ports sys_clk]
set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS33} [get_ports sys_clk]

##################### RST ################################
set_property -dict {PACKAGE_PIN H26 IOSTANDARD LVCMOS33} [get_ports sys_rst_n]

##################### key ################################
set_property -dict {PACKAGE_PIN D26 IOSTANDARD LVCMOS33} [get_ports {key[0]}]
set_property -dict {PACKAGE_PIN J26 IOSTANDARD LVCMOS33} [get_ports {key[1]}]
set_property -dict {PACKAGE_PIN E26 IOSTANDARD LVCMOS33} [get_ports {key[2]}]
set_property -dict {PACKAGE_PIN G26 IOSTANDARD LVCMOS33} [get_ports {key[3]}]

##################### LED ################################
set_property -dict {PACKAGE_PIN A23 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN A24 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN D23 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN C24 IOSTANDARD LVCMOS33} [get_ports {led[3]}]
set_property -dict {PACKAGE_PIN C26 IOSTANDARD LVCMOS33} [get_ports {led[4]}]
set_property -dict {PACKAGE_PIN D24 IOSTANDARD LVCMOS33} [get_ports {led[5]}]
set_property -dict {PACKAGE_PIN D25 IOSTANDARD LVCMOS33} [get_ports {led[6]}]
set_property -dict {PACKAGE_PIN E25 IOSTANDARD LVCMOS33} [get_ports {led[7]}]

######################## uart ##############################
set_property -dict {PACKAGE_PIN B20 IOSTANDARD LVCMOS33} [get_ports rx]
set_property -dict {PACKAGE_PIN C22 IOSTANDARD LVCMOS33} [get_ports tx]


######################## eth1_mdio ##############################
set_property -dict {PACKAGE_PIN W1 IOSTANDARD LVCMOS18} [get_ports eth1_mdc]
set_property -dict {PACKAGE_PIN AF5 IOSTANDARD LVCMOS18} [get_ports eth1_mdio]
set_property -dict {PACKAGE_PIN Y2 IOSTANDARD LVCMOS18} [get_ports eth1_rst_n]

######################## eth1 ##############################
create_clock -period 8.000 -name eth1_rxc [get_ports eth1_rxc]

set_property -dict {PACKAGE_PIN AB2 IOSTANDARD LVCMOS18} [get_ports eth1_rxc]
set_property -dict {PACKAGE_PIN AF4 IOSTANDARD LVCMOS18} [get_ports eth1_rxc_ctl]
set_property -dict {PACKAGE_PIN AF3 IOSTANDARD LVCMOS18} [get_ports {eth1_rxd[0]}]
set_property -dict {PACKAGE_PIN AC3 IOSTANDARD LVCMOS18} [get_ports {eth1_rxd[1]}]
set_property -dict {PACKAGE_PIN AE2 IOSTANDARD LVCMOS18} [get_ports {eth1_rxd[2]}]
set_property -dict {PACKAGE_PIN AE1 IOSTANDARD LVCMOS18} [get_ports {eth1_rxd[3]}]

set_property -dict {PACKAGE_PIN AC2 IOSTANDARD LVCMOS18} [get_ports eth1_txc]
set_property -dict {PACKAGE_PIN Y1 IOSTANDARD LVCMOS18} [get_ports eth1_txc_ctl]
set_property -dict {PACKAGE_PIN AC1 IOSTANDARD LVCMOS18} [get_ports {eth1_txd[0]}]
set_property -dict {PACKAGE_PIN AB1 IOSTANDARD LVCMOS18} [get_ports {eth1_txd[1]}]
set_property -dict {PACKAGE_PIN AB4 IOSTANDARD LVCMOS18} [get_ports {eth1_txd[2]}]
set_property -dict {PACKAGE_PIN Y3 IOSTANDARD LVCMOS18} [get_ports {eth1_txd[3]}]

######################## eth2_mdio ##############################

######################## eth2 ##############################



###################### 扩展口 B ################################

###################### 扩展口 G ################################

###################### 扩展口 R ################################

###################### 扩展口lcd_ctl################################

###################### 扩展口lcd_touch################################

###################### # HDMI1 ################################

####################### HDMI 2###############################

######################## iic###############################


######################## SD ##############################

######################## OLED ##############################




set_property SLEW SLOW [get_ports {eth1_txd[3]}]
set_property SLEW SLOW [get_ports {eth1_txd[2]}]
set_property SLEW SLOW [get_ports {eth1_txd[1]}]
set_property SLEW FAST [get_ports {eth1_txd[0]}]
set_property SLEW FAST [get_ports eth1_mdc]
set_property SLEW FAST [get_ports eth1_mdio]
set_property SLEW FAST [get_ports eth1_rst_n]
set_property SLEW FAST [get_ports eth1_txc_ctl]
set_property DRIVE 12 [get_ports eth1_txc]


