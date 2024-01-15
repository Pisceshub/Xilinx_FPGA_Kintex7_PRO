###################################################################

# Created by write_sdc on Sat Aug 19 14:37:28 2023

###################################################################
set sdc_version 1.7

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions typical -library typical
set_wire_load_mode top
set_wire_load_model -name tsmc090_wl10 -library typical
set_max_area 10000
set_driving_cell -lib_cell INVX1 -pin Y [get_ports sys_rst_n]
set_driving_cell -lib_cell INVX1 -pin Y [get_ports uart_rx]
set_load -pin_load 0.25299 [get_ports uart_tx]
set_load -pin_load 0.25299 [get_ports en]
set_max_capacitance 0 [get_ports sys_rst_n]
set_max_capacitance 0 [get_ports uart_rx]
set_ideal_network [get_ports sys_clk]
set_ideal_network [get_ports sys_rst_n]
create_clock [get_ports sys_clk]  -period 20  -waveform {0 10}
set_clock_latency -max 2  [get_clocks sys_clk]
set_clock_latency -source -max 2  [get_clocks sys_clk]
set_clock_uncertainty -setup 1  [get_clocks sys_clk]
set_clock_transition -max -rise 0.2 [get_clocks sys_clk]
set_clock_transition -max -fall 0.2 [get_clocks sys_clk]
group_path -weight 5  -name sys_clk  -from [list [get_ports sys_clk] [get_ports sys_rst_n] [get_ports uart_rx]]  -to [list [get_ports uart_tx] [get_ports en]]
group_path -weight 5  -name sys_clk  -to [list [get_ports uart_tx] [get_ports en] [get_clocks sys_clk]]
group_path -name INPUTS  -from [list [get_ports sys_clk] [get_ports sys_rst_n] [get_ports uart_rx]]
set_input_delay -clock sys_clk  12  [get_ports sys_rst_n]
set_input_delay -clock sys_clk  12  [get_ports uart_rx]
set_output_delay -clock sys_clk  12  [get_ports uart_tx]
set_output_delay -clock sys_clk  12  [get_ports en]
