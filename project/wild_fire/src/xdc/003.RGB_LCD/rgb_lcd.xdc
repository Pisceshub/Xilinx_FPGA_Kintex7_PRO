# 时钟
create_clock    -period 20.000 -name clk_50m [get_ports clk_50m]
set_property    -dict  {PACKAGE_PIN G22 IOSTANDARD LVCMOS33}    [get_ports clk_50m]

# 复位
set_property    -dict  {PACKAGE_PIN D26 IOSTANDARD LVCMOS33}    [get_ports sys_rst_n]


# led
set_property    -dict  {PACKAGE_PIN A23 IOSTANDARD LVCMOS33}    [get_ports {led[0]}]
set_property    -dict  {PACKAGE_PIN A24 IOSTANDARD LVCMOS33}    [get_ports {led[1]}]
set_property    -dict  {PACKAGE_PIN D23 IOSTANDARD LVCMOS33}    [get_ports {led[2]}]
set_property    -dict  {PACKAGE_PIN C24 IOSTANDARD LVCMOS33}    [get_ports {led[3]}]
set_property    -dict  {PACKAGE_PIN C26 IOSTANDARD LVCMOS33}    [get_ports {led[4]}]
set_property    -dict  {PACKAGE_PIN D24 IOSTANDARD LVCMOS33}    [get_ports {led[5]}]
set_property    -dict  {PACKAGE_PIN D25 IOSTANDARD LVCMOS33}    [get_ports {led[6]}]
set_property    -dict  {PACKAGE_PIN E25 IOSTANDARD LVCMOS33}    [get_ports {led[7]}]
# 扩展口 B
set_property    -dict  {PACKAGE_PIN H14 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[16]}] 
set_property    -dict  {PACKAGE_PIN H12 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[17]}] 
set_property    -dict  {PACKAGE_PIN H11 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[18]}] 
set_property    -dict  {PACKAGE_PIN F14 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[19]}] 
set_property    -dict  {PACKAGE_PIN G14 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[20]}] 
set_property    -dict  {PACKAGE_PIN F13 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[21]}] 
set_property    -dict  {PACKAGE_PIN G12 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[22]}] 
set_property    -dict  {PACKAGE_PIN F12 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[23]}] 
# 扩展口 G
set_property    -dict  {PACKAGE_PIN G11 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[8]}]
set_property    -dict  {PACKAGE_PIN F10 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[9]}]
set_property    -dict  {PACKAGE_PIN F8  IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[10]}]
set_property    -dict  {PACKAGE_PIN A8  IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[11]}]
set_property    -dict  {PACKAGE_PIN F9  IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[12]}]
set_property    -dict  {PACKAGE_PIN B9  IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[13]}]
set_property    -dict  {PACKAGE_PIN D8  IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[14]}]
set_property    -dict  {PACKAGE_PIN A9  IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[15]}]
# 扩展口 R
set_property    -dict  {PACKAGE_PIN E13 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[0]}]
set_property    -dict  {PACKAGE_PIN C9  IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[1]}]
set_property    -dict  {PACKAGE_PIN E10 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[2]}]
set_property    -dict  {PACKAGE_PIN B11 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[3]}]
set_property    -dict  {PACKAGE_PIN E11 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[4]}]
set_property    -dict  {PACKAGE_PIN C11 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[5]}]
set_property    -dict  {PACKAGE_PIN D10 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[6]}]
set_property    -dict  {PACKAGE_PIN C13 IOSTANDARD LVCMOS33}    [get_ports {lcd_rgb[7]}]
# 扩展口lcd_ctl
set_property    -dict  {PACKAGE_PIN D9  IOSTANDARD LVCMOS33}    [get_ports {lcd_clk}]
set_property    -dict  {PACKAGE_PIN A14 IOSTANDARD LVCMOS33}    [get_ports {lcd_hs}]
set_property    -dict  {PACKAGE_PIN D11 IOSTANDARD LVCMOS33}    [get_ports {lcd_vs}]
set_property    -dict  {PACKAGE_PIN D14 IOSTANDARD LVCMOS33}    [get_ports {lcd_de}]
set_property    -dict  {PACKAGE_PIN E12 IOSTANDARD LVCMOS33}    [get_ports {lcd_bl}]
set_property    -dict  {PACKAGE_PIN A23 IOSTANDARD LVCMOS33}    [get_ports {lcd_rst}]
# 扩展口lcd_touch
set_property    -dict  {PACKAGE_PIN B12 IOSTANDARD LVCMOS33}    [get_ports {lcd_tcs}]
set_property    -dict  {PACKAGE_PIN C12 IOSTANDARD LVCMOS33}    [get_ports {lcd_tmo}]
set_property    -dict  {PACKAGE_PIN C14 IOSTANDARD LVCMOS33}    [get_ports {lcd_tmi}]
set_property    -dict  {PACKAGE_PIN D13 IOSTANDARD LVCMOS33}    [get_ports {lcd_tclk}]
set_property    -dict  {PACKAGE_PIN B14 IOSTANDARD LVCMOS33}    [get_ports {lcd_tpen}]