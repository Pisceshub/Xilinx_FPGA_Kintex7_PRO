set_property IOSTANDARD LVCMOS33 [get_ports calib_done]
set_property PACKAGE_PIN A24 [get_ports calib_done]
set_property PACKAGE_PIN A23 [get_ports locked]
set_property IOSTANDARD LVCMOS33 [get_ports locked]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]
set_property PACKAGE_PIN D26 [get_ports rst_n]
set_property PACKAGE_PIN G22 [get_ports sys_clk]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list mig_7series_0_inst/u_mig_7series_0_mig/u_ddr3_infrastructure/CLK]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 29 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {app_addr[0]} {app_addr[1]} {app_addr[2]} {app_addr[3]} {app_addr[4]} {app_addr[5]} {app_addr[6]} {app_addr[7]} {app_addr[8]} {app_addr[9]} {app_addr[10]} {app_addr[11]} {app_addr[12]} {app_addr[13]} {app_addr[14]} {app_addr[15]} {app_addr[16]} {app_addr[17]} {app_addr[18]} {app_addr[19]} {app_addr[20]} {app_addr[21]} {app_addr[22]} {app_addr[23]} {app_addr[24]} {app_addr[25]} {app_addr[26]} {app_addr[27]} {app_addr[28]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 256 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {app_rd_data[0]} {app_rd_data[1]} {app_rd_data[2]} {app_rd_data[3]} {app_rd_data[4]} {app_rd_data[5]} {app_rd_data[6]} {app_rd_data[7]} {app_rd_data[8]} {app_rd_data[9]} {app_rd_data[10]} {app_rd_data[11]} {app_rd_data[12]} {app_rd_data[13]} {app_rd_data[14]} {app_rd_data[15]} {app_rd_data[16]} {app_rd_data[17]} {app_rd_data[18]} {app_rd_data[19]} {app_rd_data[20]} {app_rd_data[21]} {app_rd_data[22]} {app_rd_data[23]} {app_rd_data[24]} {app_rd_data[25]} {app_rd_data[26]} {app_rd_data[27]} {app_rd_data[28]} {app_rd_data[29]} {app_rd_data[30]} {app_rd_data[31]} {app_rd_data[32]} {app_rd_data[33]} {app_rd_data[34]} {app_rd_data[35]} {app_rd_data[36]} {app_rd_data[37]} {app_rd_data[38]} {app_rd_data[39]} {app_rd_data[40]} {app_rd_data[41]} {app_rd_data[42]} {app_rd_data[43]} {app_rd_data[44]} {app_rd_data[45]} {app_rd_data[46]} {app_rd_data[47]} {app_rd_data[48]} {app_rd_data[49]} {app_rd_data[50]} {app_rd_data[51]} {app_rd_data[52]} {app_rd_data[53]} {app_rd_data[54]} {app_rd_data[55]} {app_rd_data[56]} {app_rd_data[57]} {app_rd_data[58]} {app_rd_data[59]} {app_rd_data[60]} {app_rd_data[61]} {app_rd_data[62]} {app_rd_data[63]} {app_rd_data[64]} {app_rd_data[65]} {app_rd_data[66]} {app_rd_data[67]} {app_rd_data[68]} {app_rd_data[69]} {app_rd_data[70]} {app_rd_data[71]} {app_rd_data[72]} {app_rd_data[73]} {app_rd_data[74]} {app_rd_data[75]} {app_rd_data[76]} {app_rd_data[77]} {app_rd_data[78]} {app_rd_data[79]} {app_rd_data[80]} {app_rd_data[81]} {app_rd_data[82]} {app_rd_data[83]} {app_rd_data[84]} {app_rd_data[85]} {app_rd_data[86]} {app_rd_data[87]} {app_rd_data[88]} {app_rd_data[89]} {app_rd_data[90]} {app_rd_data[91]} {app_rd_data[92]} {app_rd_data[93]} {app_rd_data[94]} {app_rd_data[95]} {app_rd_data[96]} {app_rd_data[97]} {app_rd_data[98]} {app_rd_data[99]} {app_rd_data[100]} {app_rd_data[101]} {app_rd_data[102]} {app_rd_data[103]} {app_rd_data[104]} {app_rd_data[105]} {app_rd_data[106]} {app_rd_data[107]} {app_rd_data[108]} {app_rd_data[109]} {app_rd_data[110]} {app_rd_data[111]} {app_rd_data[112]} {app_rd_data[113]} {app_rd_data[114]} {app_rd_data[115]} {app_rd_data[116]} {app_rd_data[117]} {app_rd_data[118]} {app_rd_data[119]} {app_rd_data[120]} {app_rd_data[121]} {app_rd_data[122]} {app_rd_data[123]} {app_rd_data[124]} {app_rd_data[125]} {app_rd_data[126]} {app_rd_data[127]} {app_rd_data[128]} {app_rd_data[129]} {app_rd_data[130]} {app_rd_data[131]} {app_rd_data[132]} {app_rd_data[133]} {app_rd_data[134]} {app_rd_data[135]} {app_rd_data[136]} {app_rd_data[137]} {app_rd_data[138]} {app_rd_data[139]} {app_rd_data[140]} {app_rd_data[141]} {app_rd_data[142]} {app_rd_data[143]} {app_rd_data[144]} {app_rd_data[145]} {app_rd_data[146]} {app_rd_data[147]} {app_rd_data[148]} {app_rd_data[149]} {app_rd_data[150]} {app_rd_data[151]} {app_rd_data[152]} {app_rd_data[153]} {app_rd_data[154]} {app_rd_data[155]} {app_rd_data[156]} {app_rd_data[157]} {app_rd_data[158]} {app_rd_data[159]} {app_rd_data[160]} {app_rd_data[161]} {app_rd_data[162]} {app_rd_data[163]} {app_rd_data[164]} {app_rd_data[165]} {app_rd_data[166]} {app_rd_data[167]} {app_rd_data[168]} {app_rd_data[169]} {app_rd_data[170]} {app_rd_data[171]} {app_rd_data[172]} {app_rd_data[173]} {app_rd_data[174]} {app_rd_data[175]} {app_rd_data[176]} {app_rd_data[177]} {app_rd_data[178]} {app_rd_data[179]} {app_rd_data[180]} {app_rd_data[181]} {app_rd_data[182]} {app_rd_data[183]} {app_rd_data[184]} {app_rd_data[185]} {app_rd_data[186]} {app_rd_data[187]} {app_rd_data[188]} {app_rd_data[189]} {app_rd_data[190]} {app_rd_data[191]} {app_rd_data[192]} {app_rd_data[193]} {app_rd_data[194]} {app_rd_data[195]} {app_rd_data[196]} {app_rd_data[197]} {app_rd_data[198]} {app_rd_data[199]} {app_rd_data[200]} {app_rd_data[201]} {app_rd_data[202]} {app_rd_data[203]} {app_rd_data[204]} {app_rd_data[205]} {app_rd_data[206]} {app_rd_data[207]} {app_rd_data[208]} {app_rd_data[209]} {app_rd_data[210]} {app_rd_data[211]} {app_rd_data[212]} {app_rd_data[213]} {app_rd_data[214]} {app_rd_data[215]} {app_rd_data[216]} {app_rd_data[217]} {app_rd_data[218]} {app_rd_data[219]} {app_rd_data[220]} {app_rd_data[221]} {app_rd_data[222]} {app_rd_data[223]} {app_rd_data[224]} {app_rd_data[225]} {app_rd_data[226]} {app_rd_data[227]} {app_rd_data[228]} {app_rd_data[229]} {app_rd_data[230]} {app_rd_data[231]} {app_rd_data[232]} {app_rd_data[233]} {app_rd_data[234]} {app_rd_data[235]} {app_rd_data[236]} {app_rd_data[237]} {app_rd_data[238]} {app_rd_data[239]} {app_rd_data[240]} {app_rd_data[241]} {app_rd_data[242]} {app_rd_data[243]} {app_rd_data[244]} {app_rd_data[245]} {app_rd_data[246]} {app_rd_data[247]} {app_rd_data[248]} {app_rd_data[249]} {app_rd_data[250]} {app_rd_data[251]} {app_rd_data[252]} {app_rd_data[253]} {app_rd_data[254]} {app_rd_data[255]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 256 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {app_rd_data_reg[0]} {app_rd_data_reg[1]} {app_rd_data_reg[2]} {app_rd_data_reg[3]} {app_rd_data_reg[4]} {app_rd_data_reg[5]} {app_rd_data_reg[6]} {app_rd_data_reg[7]} {app_rd_data_reg[8]} {app_rd_data_reg[9]} {app_rd_data_reg[10]} {app_rd_data_reg[11]} {app_rd_data_reg[12]} {app_rd_data_reg[13]} {app_rd_data_reg[14]} {app_rd_data_reg[15]} {app_rd_data_reg[16]} {app_rd_data_reg[17]} {app_rd_data_reg[18]} {app_rd_data_reg[19]} {app_rd_data_reg[20]} {app_rd_data_reg[21]} {app_rd_data_reg[22]} {app_rd_data_reg[23]} {app_rd_data_reg[24]} {app_rd_data_reg[25]} {app_rd_data_reg[26]} {app_rd_data_reg[27]} {app_rd_data_reg[28]} {app_rd_data_reg[29]} {app_rd_data_reg[30]} {app_rd_data_reg[31]} {app_rd_data_reg[32]} {app_rd_data_reg[33]} {app_rd_data_reg[34]} {app_rd_data_reg[35]} {app_rd_data_reg[36]} {app_rd_data_reg[37]} {app_rd_data_reg[38]} {app_rd_data_reg[39]} {app_rd_data_reg[40]} {app_rd_data_reg[41]} {app_rd_data_reg[42]} {app_rd_data_reg[43]} {app_rd_data_reg[44]} {app_rd_data_reg[45]} {app_rd_data_reg[46]} {app_rd_data_reg[47]} {app_rd_data_reg[48]} {app_rd_data_reg[49]} {app_rd_data_reg[50]} {app_rd_data_reg[51]} {app_rd_data_reg[52]} {app_rd_data_reg[53]} {app_rd_data_reg[54]} {app_rd_data_reg[55]} {app_rd_data_reg[56]} {app_rd_data_reg[57]} {app_rd_data_reg[58]} {app_rd_data_reg[59]} {app_rd_data_reg[60]} {app_rd_data_reg[61]} {app_rd_data_reg[62]} {app_rd_data_reg[63]} {app_rd_data_reg[64]} {app_rd_data_reg[65]} {app_rd_data_reg[66]} {app_rd_data_reg[67]} {app_rd_data_reg[68]} {app_rd_data_reg[69]} {app_rd_data_reg[70]} {app_rd_data_reg[71]} {app_rd_data_reg[72]} {app_rd_data_reg[73]} {app_rd_data_reg[74]} {app_rd_data_reg[75]} {app_rd_data_reg[76]} {app_rd_data_reg[77]} {app_rd_data_reg[78]} {app_rd_data_reg[79]} {app_rd_data_reg[80]} {app_rd_data_reg[81]} {app_rd_data_reg[82]} {app_rd_data_reg[83]} {app_rd_data_reg[84]} {app_rd_data_reg[85]} {app_rd_data_reg[86]} {app_rd_data_reg[87]} {app_rd_data_reg[88]} {app_rd_data_reg[89]} {app_rd_data_reg[90]} {app_rd_data_reg[91]} {app_rd_data_reg[92]} {app_rd_data_reg[93]} {app_rd_data_reg[94]} {app_rd_data_reg[95]} {app_rd_data_reg[96]} {app_rd_data_reg[97]} {app_rd_data_reg[98]} {app_rd_data_reg[99]} {app_rd_data_reg[100]} {app_rd_data_reg[101]} {app_rd_data_reg[102]} {app_rd_data_reg[103]} {app_rd_data_reg[104]} {app_rd_data_reg[105]} {app_rd_data_reg[106]} {app_rd_data_reg[107]} {app_rd_data_reg[108]} {app_rd_data_reg[109]} {app_rd_data_reg[110]} {app_rd_data_reg[111]} {app_rd_data_reg[112]} {app_rd_data_reg[113]} {app_rd_data_reg[114]} {app_rd_data_reg[115]} {app_rd_data_reg[116]} {app_rd_data_reg[117]} {app_rd_data_reg[118]} {app_rd_data_reg[119]} {app_rd_data_reg[120]} {app_rd_data_reg[121]} {app_rd_data_reg[122]} {app_rd_data_reg[123]} {app_rd_data_reg[124]} {app_rd_data_reg[125]} {app_rd_data_reg[126]} {app_rd_data_reg[127]} {app_rd_data_reg[128]} {app_rd_data_reg[129]} {app_rd_data_reg[130]} {app_rd_data_reg[131]} {app_rd_data_reg[132]} {app_rd_data_reg[133]} {app_rd_data_reg[134]} {app_rd_data_reg[135]} {app_rd_data_reg[136]} {app_rd_data_reg[137]} {app_rd_data_reg[138]} {app_rd_data_reg[139]} {app_rd_data_reg[140]} {app_rd_data_reg[141]} {app_rd_data_reg[142]} {app_rd_data_reg[143]} {app_rd_data_reg[144]} {app_rd_data_reg[145]} {app_rd_data_reg[146]} {app_rd_data_reg[147]} {app_rd_data_reg[148]} {app_rd_data_reg[149]} {app_rd_data_reg[150]} {app_rd_data_reg[151]} {app_rd_data_reg[152]} {app_rd_data_reg[153]} {app_rd_data_reg[154]} {app_rd_data_reg[155]} {app_rd_data_reg[156]} {app_rd_data_reg[157]} {app_rd_data_reg[158]} {app_rd_data_reg[159]} {app_rd_data_reg[160]} {app_rd_data_reg[161]} {app_rd_data_reg[162]} {app_rd_data_reg[163]} {app_rd_data_reg[164]} {app_rd_data_reg[165]} {app_rd_data_reg[166]} {app_rd_data_reg[167]} {app_rd_data_reg[168]} {app_rd_data_reg[169]} {app_rd_data_reg[170]} {app_rd_data_reg[171]} {app_rd_data_reg[172]} {app_rd_data_reg[173]} {app_rd_data_reg[174]} {app_rd_data_reg[175]} {app_rd_data_reg[176]} {app_rd_data_reg[177]} {app_rd_data_reg[178]} {app_rd_data_reg[179]} {app_rd_data_reg[180]} {app_rd_data_reg[181]} {app_rd_data_reg[182]} {app_rd_data_reg[183]} {app_rd_data_reg[184]} {app_rd_data_reg[185]} {app_rd_data_reg[186]} {app_rd_data_reg[187]} {app_rd_data_reg[188]} {app_rd_data_reg[189]} {app_rd_data_reg[190]} {app_rd_data_reg[191]} {app_rd_data_reg[192]} {app_rd_data_reg[193]} {app_rd_data_reg[194]} {app_rd_data_reg[195]} {app_rd_data_reg[196]} {app_rd_data_reg[197]} {app_rd_data_reg[198]} {app_rd_data_reg[199]} {app_rd_data_reg[200]} {app_rd_data_reg[201]} {app_rd_data_reg[202]} {app_rd_data_reg[203]} {app_rd_data_reg[204]} {app_rd_data_reg[205]} {app_rd_data_reg[206]} {app_rd_data_reg[207]} {app_rd_data_reg[208]} {app_rd_data_reg[209]} {app_rd_data_reg[210]} {app_rd_data_reg[211]} {app_rd_data_reg[212]} {app_rd_data_reg[213]} {app_rd_data_reg[214]} {app_rd_data_reg[215]} {app_rd_data_reg[216]} {app_rd_data_reg[217]} {app_rd_data_reg[218]} {app_rd_data_reg[219]} {app_rd_data_reg[220]} {app_rd_data_reg[221]} {app_rd_data_reg[222]} {app_rd_data_reg[223]} {app_rd_data_reg[224]} {app_rd_data_reg[225]} {app_rd_data_reg[226]} {app_rd_data_reg[227]} {app_rd_data_reg[228]} {app_rd_data_reg[229]} {app_rd_data_reg[230]} {app_rd_data_reg[231]} {app_rd_data_reg[232]} {app_rd_data_reg[233]} {app_rd_data_reg[234]} {app_rd_data_reg[235]} {app_rd_data_reg[236]} {app_rd_data_reg[237]} {app_rd_data_reg[238]} {app_rd_data_reg[239]} {app_rd_data_reg[240]} {app_rd_data_reg[241]} {app_rd_data_reg[242]} {app_rd_data_reg[243]} {app_rd_data_reg[244]} {app_rd_data_reg[245]} {app_rd_data_reg[246]} {app_rd_data_reg[247]} {app_rd_data_reg[248]} {app_rd_data_reg[249]} {app_rd_data_reg[250]} {app_rd_data_reg[251]} {app_rd_data_reg[252]} {app_rd_data_reg[253]} {app_rd_data_reg[254]} {app_rd_data_reg[255]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 256 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {app_wdf_data[0]} {app_wdf_data[1]} {app_wdf_data[2]} {app_wdf_data[3]} {app_wdf_data[4]} {app_wdf_data[5]} {app_wdf_data[6]} {app_wdf_data[7]} {app_wdf_data[8]} {app_wdf_data[9]} {app_wdf_data[10]} {app_wdf_data[11]} {app_wdf_data[12]} {app_wdf_data[13]} {app_wdf_data[14]} {app_wdf_data[15]} {app_wdf_data[16]} {app_wdf_data[17]} {app_wdf_data[18]} {app_wdf_data[19]} {app_wdf_data[20]} {app_wdf_data[21]} {app_wdf_data[22]} {app_wdf_data[23]} {app_wdf_data[24]} {app_wdf_data[25]} {app_wdf_data[26]} {app_wdf_data[27]} {app_wdf_data[28]} {app_wdf_data[29]} {app_wdf_data[30]} {app_wdf_data[31]} {app_wdf_data[32]} {app_wdf_data[33]} {app_wdf_data[34]} {app_wdf_data[35]} {app_wdf_data[36]} {app_wdf_data[37]} {app_wdf_data[38]} {app_wdf_data[39]} {app_wdf_data[40]} {app_wdf_data[41]} {app_wdf_data[42]} {app_wdf_data[43]} {app_wdf_data[44]} {app_wdf_data[45]} {app_wdf_data[46]} {app_wdf_data[47]} {app_wdf_data[48]} {app_wdf_data[49]} {app_wdf_data[50]} {app_wdf_data[51]} {app_wdf_data[52]} {app_wdf_data[53]} {app_wdf_data[54]} {app_wdf_data[55]} {app_wdf_data[56]} {app_wdf_data[57]} {app_wdf_data[58]} {app_wdf_data[59]} {app_wdf_data[60]} {app_wdf_data[61]} {app_wdf_data[62]} {app_wdf_data[63]} {app_wdf_data[64]} {app_wdf_data[65]} {app_wdf_data[66]} {app_wdf_data[67]} {app_wdf_data[68]} {app_wdf_data[69]} {app_wdf_data[70]} {app_wdf_data[71]} {app_wdf_data[72]} {app_wdf_data[73]} {app_wdf_data[74]} {app_wdf_data[75]} {app_wdf_data[76]} {app_wdf_data[77]} {app_wdf_data[78]} {app_wdf_data[79]} {app_wdf_data[80]} {app_wdf_data[81]} {app_wdf_data[82]} {app_wdf_data[83]} {app_wdf_data[84]} {app_wdf_data[85]} {app_wdf_data[86]} {app_wdf_data[87]} {app_wdf_data[88]} {app_wdf_data[89]} {app_wdf_data[90]} {app_wdf_data[91]} {app_wdf_data[92]} {app_wdf_data[93]} {app_wdf_data[94]} {app_wdf_data[95]} {app_wdf_data[96]} {app_wdf_data[97]} {app_wdf_data[98]} {app_wdf_data[99]} {app_wdf_data[100]} {app_wdf_data[101]} {app_wdf_data[102]} {app_wdf_data[103]} {app_wdf_data[104]} {app_wdf_data[105]} {app_wdf_data[106]} {app_wdf_data[107]} {app_wdf_data[108]} {app_wdf_data[109]} {app_wdf_data[110]} {app_wdf_data[111]} {app_wdf_data[112]} {app_wdf_data[113]} {app_wdf_data[114]} {app_wdf_data[115]} {app_wdf_data[116]} {app_wdf_data[117]} {app_wdf_data[118]} {app_wdf_data[119]} {app_wdf_data[120]} {app_wdf_data[121]} {app_wdf_data[122]} {app_wdf_data[123]} {app_wdf_data[124]} {app_wdf_data[125]} {app_wdf_data[126]} {app_wdf_data[127]} {app_wdf_data[128]} {app_wdf_data[129]} {app_wdf_data[130]} {app_wdf_data[131]} {app_wdf_data[132]} {app_wdf_data[133]} {app_wdf_data[134]} {app_wdf_data[135]} {app_wdf_data[136]} {app_wdf_data[137]} {app_wdf_data[138]} {app_wdf_data[139]} {app_wdf_data[140]} {app_wdf_data[141]} {app_wdf_data[142]} {app_wdf_data[143]} {app_wdf_data[144]} {app_wdf_data[145]} {app_wdf_data[146]} {app_wdf_data[147]} {app_wdf_data[148]} {app_wdf_data[149]} {app_wdf_data[150]} {app_wdf_data[151]} {app_wdf_data[152]} {app_wdf_data[153]} {app_wdf_data[154]} {app_wdf_data[155]} {app_wdf_data[156]} {app_wdf_data[157]} {app_wdf_data[158]} {app_wdf_data[159]} {app_wdf_data[160]} {app_wdf_data[161]} {app_wdf_data[162]} {app_wdf_data[163]} {app_wdf_data[164]} {app_wdf_data[165]} {app_wdf_data[166]} {app_wdf_data[167]} {app_wdf_data[168]} {app_wdf_data[169]} {app_wdf_data[170]} {app_wdf_data[171]} {app_wdf_data[172]} {app_wdf_data[173]} {app_wdf_data[174]} {app_wdf_data[175]} {app_wdf_data[176]} {app_wdf_data[177]} {app_wdf_data[178]} {app_wdf_data[179]} {app_wdf_data[180]} {app_wdf_data[181]} {app_wdf_data[182]} {app_wdf_data[183]} {app_wdf_data[184]} {app_wdf_data[185]} {app_wdf_data[186]} {app_wdf_data[187]} {app_wdf_data[188]} {app_wdf_data[189]} {app_wdf_data[190]} {app_wdf_data[191]} {app_wdf_data[192]} {app_wdf_data[193]} {app_wdf_data[194]} {app_wdf_data[195]} {app_wdf_data[196]} {app_wdf_data[197]} {app_wdf_data[198]} {app_wdf_data[199]} {app_wdf_data[200]} {app_wdf_data[201]} {app_wdf_data[202]} {app_wdf_data[203]} {app_wdf_data[204]} {app_wdf_data[205]} {app_wdf_data[206]} {app_wdf_data[207]} {app_wdf_data[208]} {app_wdf_data[209]} {app_wdf_data[210]} {app_wdf_data[211]} {app_wdf_data[212]} {app_wdf_data[213]} {app_wdf_data[214]} {app_wdf_data[215]} {app_wdf_data[216]} {app_wdf_data[217]} {app_wdf_data[218]} {app_wdf_data[219]} {app_wdf_data[220]} {app_wdf_data[221]} {app_wdf_data[222]} {app_wdf_data[223]} {app_wdf_data[224]} {app_wdf_data[225]} {app_wdf_data[226]} {app_wdf_data[227]} {app_wdf_data[228]} {app_wdf_data[229]} {app_wdf_data[230]} {app_wdf_data[231]} {app_wdf_data[232]} {app_wdf_data[233]} {app_wdf_data[234]} {app_wdf_data[235]} {app_wdf_data[236]} {app_wdf_data[237]} {app_wdf_data[238]} {app_wdf_data[239]} {app_wdf_data[240]} {app_wdf_data[241]} {app_wdf_data[242]} {app_wdf_data[243]} {app_wdf_data[244]} {app_wdf_data[245]} {app_wdf_data[246]} {app_wdf_data[247]} {app_wdf_data[248]} {app_wdf_data[249]} {app_wdf_data[250]} {app_wdf_data[251]} {app_wdf_data[252]} {app_wdf_data[253]} {app_wdf_data[254]} {app_wdf_data[255]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 3 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {app_cmd[0]} {app_cmd[1]} {app_cmd[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list app_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list app_rd_data_end]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list app_rd_data_valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list app_rdy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list app_wdf_end]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list app_wdf_rdy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list app_wdf_wren]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list ui_clk]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list write_state_flag]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets ui_clk]
