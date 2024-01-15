create_clock -period 20.000 -name sys_clk [get_ports sys_clk]
set_property    -dict  {PACKAGE_PIN G22 IOSTANDARD LVCMOS33}    [get_ports sys_clk]

set_property    -dict  {PACKAGE_PIN D26 IOSTANDARD LVCMOS33}    [get_ports sys_rst_n]

set_property    -dict  {PACKAGE_PIN A23 IOSTANDARD LVCMOS33}    [get_ports {led[0]}]
set_property    -dict  {PACKAGE_PIN A24 IOSTANDARD LVCMOS33}    [get_ports {led[1]}]
set_property    -dict  {PACKAGE_PIN D23 IOSTANDARD LVCMOS33}    [get_ports {led[2]}]
set_property    -dict  {PACKAGE_PIN C24 IOSTANDARD LVCMOS33}    [get_ports {led[3]}]
set_property    -dict  {PACKAGE_PIN C26 IOSTANDARD LVCMOS33}    [get_ports {led[4]}]
set_property    -dict  {PACKAGE_PIN D24 IOSTANDARD LVCMOS33}    [get_ports {led[5]}]
set_property    -dict  {PACKAGE_PIN D25 IOSTANDARD LVCMOS33}    [get_ports {led[6]}]
set_property    -dict  {PACKAGE_PIN E25 IOSTANDARD LVCMOS33}    [get_ports {led[7]}]