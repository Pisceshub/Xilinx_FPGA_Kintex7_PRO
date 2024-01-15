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
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports sys_clk]

##################### RST ################################
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports sys_rst_n]

##################### key ################################
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports {key[0]}]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {key[1]}]

##################### LED ################################
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports {led[1]}]


######################## uart ##############################
set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports rx]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports tx]


# ###################### 扩展口 B ################################
# set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[16]}]
# set_property -dict {PACKAGE_PIN H12 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[17]}]
# set_property -dict {PACKAGE_PIN H11 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[18]}]
# set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[19]}]
# set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[20]}]
# set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[21]}]
# set_property -dict {PACKAGE_PIN G12 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[22]}]
# set_property -dict {PACKAGE_PIN F12 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[23]}]

# ###################### 扩展口 G ################################
# set_property -dict {PACKAGE_PIN G11 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[8]}]
# set_property -dict {PACKAGE_PIN F10 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[9]}]
# set_property -dict {PACKAGE_PIN F8  IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[10]}]
# set_property -dict {PACKAGE_PIN A8  IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[11]}]
# set_property -dict {PACKAGE_PIN F9  IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[12]}]
# set_property -dict {PACKAGE_PIN B9  IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[13]}]
# set_property -dict {PACKAGE_PIN D8  IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[14]}]
# set_property -dict {PACKAGE_PIN A9  IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[15]}]

# ###################### 扩展口 R ################################
# set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[0]}]
# set_property -dict {PACKAGE_PIN C9  IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[1]}]
# set_property -dict {PACKAGE_PIN E10 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[2]}]
# set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[3]}]
# set_property -dict {PACKAGE_PIN E11 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[4]}]
# set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[5]}]
# set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[6]}]
# set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS33} [get_ports {lcd_rgb[7]}]

# ###################### 扩展口lcd_ctl################################
# set_property -dict {PACKAGE_PIN D9  IOSTANDARD LVCMOS33} [get_ports {lcd_clk}]
# set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports {lcd_hs}]
# set_property -dict {PACKAGE_PIN D11 IOSTANDARD LVCMOS33} [get_ports {lcd_vs}]
# set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports {lcd_de}]
# set_property -dict {PACKAGE_PIN E12 IOSTANDARD LVCMOS33} [get_ports {lcd_bl}]
# set_property -dict {PACKAGE_PIN A23 IOSTANDARD LVCMOS33} [get_ports {lcd_rst}]

# ###################### 扩展口lcd_touch################################
# set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports {lcd_tcs}]
# set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports {lcd_tmo}]
# set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports {lcd_tmi}]
# set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS33} [get_ports {lcd_tclk}]
# set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS33} [get_ports {lcd_tpen}]

# ###################### # HDMI1 ################################
# set_property -dict {PACKAGE_PIN E22 IOSTANDARD LVCMOS33} [get_ports {hdmi1_out_en}]
# set_property -dict {PACKAGE_PIN E21 IOSTANDARD LVCMOS33} [get_ports {hdmi1_hpd}]
# set_property -dict {PACKAGE_PIN F17 IOSTANDARD TMDS_33} [get_ports {tmds_clk_p}]
# set_property -dict {PACKAGE_PIN E17 IOSTANDARD TMDS_33} [get_ports {tmds_clk_n}]
# set_property -dict {PACKAGE_PIN J15 IOSTANDARD TMDS_33} [get_ports {tmds_data_p[0]}]
# set_property -dict {PACKAGE_PIN J16 IOSTANDARD TMDS_33} [get_ports {tmds_data_n[0]}]
# set_property -dict {PACKAGE_PIN E15 IOSTANDARD TMDS_33} [get_ports {tmds_data_p[1]}]
# set_property -dict {PACKAGE_PIN E16 IOSTANDARD TMDS_33} [get_ports {tmds_data_n[1]}]
# set_property -dict {PACKAGE_PIN G17 IOSTANDARD TMDS_33} [get_ports {tmds_data_p[2]}]
# set_property -dict {PACKAGE_PIN F18 IOSTANDARD TMDS_33} [get_ports {tmds_data_n[2]}]

# ####################### HDMI 2###############################
# set_property -dict {PACKAGE_PIN E18 IOSTANDARD TMDS_33} [get_ports {tmds_clk_p2}]
# set_property -dict {PACKAGE_PIN D18 IOSTANDARD TMDS_33} [get_ports {tmds_clk_n2}]
# set_property -dict {PACKAGE_PIN D19 IOSTANDARD TMDS_33} [get_ports {tmds_data_p2[0]}]
# set_property -dict {PACKAGE_PIN D20 IOSTANDARD TMDS_33} [get_ports {tmds_data_n2[0]}]
# set_property -dict {PACKAGE_PIN H17 IOSTANDARD TMDS_33} [get_ports {tmds_data_p2[1]}]
# set_property -dict {PACKAGE_PIN H18 IOSTANDARD TMDS_33} [get_ports {tmds_data_n2[1]}]
# set_property -dict {PACKAGE_PIN G19 IOSTANDARD TMDS_33} [get_ports {tmds_data_p2[2]}]
# set_property -dict {PACKAGE_PIN F20 IOSTANDARD TMDS_33} [get_ports {tmds_data_n2[2]}]

# ######################## iic###############################
# set_property -dict {PACKAGE_PIN B21 IOSTANDARD LVCMOS33} [get_ports {iic_scl}]
# set_property -dict {PACKAGE_PIN C21 IOSTANDARD LVCMOS33} [get_ports {iic_sda}]



# ######################## SD ##############################
# set_property -dict {PACKAGE_PIN G24 IOSTANDARD LVCMOS33} [get_ports SD_CLK]
# set_property -dict {PACKAGE_PIN G25 IOSTANDARD LVCMOS33} [get_ports SD_CMD]
# set_property -dict {PACKAGE_PIN F23 IOSTANDARD LVCMOS33} [get_ports SD_DATA0]
# set_property -dict {PACKAGE_PIN E23 IOSTANDARD LVCMOS33} [get_ports SD_DATA1]
# set_property -dict {PACKAGE_PIN F25 IOSTANDARD LVCMOS33} [get_ports SD_DATA2]
# set_property -dict {PACKAGE_PIN F24 IOSTANDARD LVCMOS33} [get_ports SD_DATA3]

# ######################## OLED ##############################
# set_property -dict {PACKAGE_PIN J24 IOSTANDARD LVCMOS33} [get_ports OLED_D0]
# set_property -dict {PACKAGE_PIN J25 IOSTANDARD LVCMOS33} [get_ports OLED_D1]
# set_property -dict {PACKAGE_PIN H22 IOSTANDARD LVCMOS33} [get_ports OLED_DC]
# set_property -dict {PACKAGE_PIN J21 IOSTANDARD LVCMOS33} [get_ports OLED_RST]


