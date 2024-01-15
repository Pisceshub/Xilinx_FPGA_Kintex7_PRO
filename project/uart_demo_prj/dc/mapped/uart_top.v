/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sat Aug 19 14:37:28 2023
/////////////////////////////////////////////////////////////


module uart_rx_CLOCK_FREQ50000000_UART_BPS10000000_DW01_inc_0 ( A, SUM );
  input [15:0] A;
  output [15:0] SUM;

  wire   [15:2] carry;

  ADDHX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .CO(carry[15]), .S(SUM[14]) );
  ADDHX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .CO(carry[14]), .S(SUM[13]) );
  ADDHX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[15]), .B(A[15]), .Y(SUM[15]) );
endmodule


module uart_rx_CLOCK_FREQ50000000_UART_BPS10000000 ( sys_clk, sys_rst_n, 
        uart_rx, uart_rxd, rx_done );
  output [7:0] uart_rxd;
  input sys_clk, sys_rst_n, uart_rx;
  output rx_done;
  wire   rxd_d1, rxd_d0, rx_flag, N28, N29, N30, N31, N32, N33, N34, N35, N36,
         N37, N38, N39, N40, N41, N42, N43, N68, N69, N70, N71, N72, N73, N74,
         N75, N76, N77, N78, N79, N80, N81, N82, N83, N157, N158, N159, N160,
         N161, N162, N163, N164, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n1, n2,
         n3, n4, n5, n6, n7, n8, n58;
  wire   [15:0] bps_cnt;
  wire   [3:0] rx_cnt;
  wire   [7:0] rx_data;

  uart_rx_CLOCK_FREQ50000000_UART_BPS10000000_DW01_inc_0 add_89 ( .A(bps_cnt), 
        .SUM({N43, N42, N41, N40, N39, N38, N37, N36, N35, N34, N33, N32, N31, 
        N30, N29, N28}) );
  DFFRQX2 \uart_rxd_reg[7]  ( .D(N164), .CK(sys_clk), .RN(sys_rst_n), .Q(
        uart_rxd[7]) );
  DFFRQX2 \uart_rxd_reg[6]  ( .D(N163), .CK(sys_clk), .RN(sys_rst_n), .Q(
        uart_rxd[6]) );
  DFFRQX2 \uart_rxd_reg[5]  ( .D(N162), .CK(sys_clk), .RN(sys_rst_n), .Q(
        uart_rxd[5]) );
  DFFRQX2 \uart_rxd_reg[3]  ( .D(N160), .CK(sys_clk), .RN(sys_rst_n), .Q(
        uart_rxd[3]) );
  DFFRQX2 \uart_rxd_reg[4]  ( .D(N161), .CK(sys_clk), .RN(sys_rst_n), .Q(
        uart_rxd[4]) );
  DFFRQX2 \uart_rxd_reg[2]  ( .D(N159), .CK(sys_clk), .RN(sys_rst_n), .Q(
        uart_rxd[2]) );
  DFFRQX2 \uart_rxd_reg[1]  ( .D(N158), .CK(sys_clk), .RN(sys_rst_n), .Q(
        uart_rxd[1]) );
  DFFRQX2 \uart_rxd_reg[0]  ( .D(N157), .CK(sys_clk), .RN(sys_rst_n), .Q(
        uart_rxd[0]) );
  DFFRQX2 rxd_d0_reg ( .D(uart_rx), .CK(sys_clk), .RN(sys_rst_n), .Q(rxd_d0)
         );
  DFFRQX2 rxd_d1_reg ( .D(rxd_d0), .CK(sys_clk), .RN(sys_rst_n), .Q(rxd_d1) );
  DFFRQX2 \bps_cnt_reg[15]  ( .D(N83), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[15]) );
  DFFRQX2 \rx_data_reg[7]  ( .D(n51), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_data[7]) );
  DFFRQX2 \rx_data_reg[6]  ( .D(n50), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_data[6]) );
  DFFRQX2 \rx_data_reg[5]  ( .D(n49), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_data[5]) );
  DFFRQX2 \rx_data_reg[4]  ( .D(n48), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_data[4]) );
  DFFRQX2 \rx_data_reg[3]  ( .D(n47), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_data[3]) );
  DFFRQX2 \rx_data_reg[2]  ( .D(n46), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_data[2]) );
  DFFRQX2 \rx_data_reg[1]  ( .D(n45), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_data[1]) );
  DFFRQX2 \rx_data_reg[0]  ( .D(n44), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_data[0]) );
  DFFRQX2 \bps_cnt_reg[6]  ( .D(N74), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[6]) );
  DFFRQX2 \bps_cnt_reg[13]  ( .D(N81), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[13]) );
  DFFRQX2 \bps_cnt_reg[9]  ( .D(N77), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[9]) );
  DFFRQX2 \bps_cnt_reg[8]  ( .D(N76), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[8]) );
  DFFRQX2 \bps_cnt_reg[5]  ( .D(N73), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[5]) );
  DFFRQX2 \bps_cnt_reg[12]  ( .D(N80), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[12]) );
  DFFRQX2 \bps_cnt_reg[7]  ( .D(N75), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[7]) );
  DFFRQX2 \bps_cnt_reg[14]  ( .D(N82), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[14]) );
  DFFRQX2 \bps_cnt_reg[10]  ( .D(N78), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[10]) );
  DFFRQX2 \bps_cnt_reg[11]  ( .D(N79), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[11]) );
  DFFRQX2 \rx_cnt_reg[3]  ( .D(n53), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_cnt[3]) );
  DFFRQX2 \rx_cnt_reg[2]  ( .D(n54), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_cnt[2]) );
  DFFRQX2 \rx_cnt_reg[0]  ( .D(n56), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_cnt[0]) );
  DFFRQX2 rx_flag_reg ( .D(n52), .CK(sys_clk), .RN(sys_rst_n), .Q(rx_flag) );
  DFFRQX2 \bps_cnt_reg[1]  ( .D(N69), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[1]) );
  DFFRQX2 \bps_cnt_reg[2]  ( .D(N70), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[2]) );
  DFFRQX2 \bps_cnt_reg[3]  ( .D(N71), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[3]) );
  DFFRQX2 \bps_cnt_reg[4]  ( .D(N72), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[4]) );
  DFFRQX2 \bps_cnt_reg[0]  ( .D(N68), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[0]) );
  DFFRQX2 rx_done_reg ( .D(n1), .CK(sys_clk), .RN(sys_rst_n), .Q(rx_done) );
  DFFRQX2 \rx_cnt_reg[1]  ( .D(n55), .CK(sys_clk), .RN(sys_rst_n), .Q(
        rx_cnt[1]) );
  INVX2 U3 ( .A(n38), .Y(n2) );
  AND2X2 U4 ( .A(N42), .B(n5), .Y(N82) );
  AND2X2 U5 ( .A(N41), .B(n5), .Y(N81) );
  NOR2X2 U6 ( .A(n20), .B(n4), .Y(n38) );
  INVX4 U7 ( .A(n26), .Y(n5) );
  AND2X2 U8 ( .A(N40), .B(n5), .Y(N80) );
  AND2X2 U9 ( .A(N39), .B(n5), .Y(N79) );
  AND2X2 U10 ( .A(N38), .B(n5), .Y(N78) );
  AND2X2 U11 ( .A(N37), .B(n5), .Y(N77) );
  AND2X2 U12 ( .A(N36), .B(n5), .Y(N76) );
  AND2X2 U13 ( .A(N35), .B(n5), .Y(N75) );
  AND2X2 U14 ( .A(N34), .B(n5), .Y(N74) );
  AND2X2 U15 ( .A(N33), .B(n5), .Y(N73) );
  AND2X2 U16 ( .A(N32), .B(n5), .Y(N72) );
  AND2X2 U17 ( .A(N31), .B(n5), .Y(N71) );
  AND2X2 U18 ( .A(N30), .B(n5), .Y(N70) );
  AND2X2 U19 ( .A(N29), .B(n5), .Y(N69) );
  AND2X2 U20 ( .A(N43), .B(n5), .Y(N83) );
  OAI21X1 U21 ( .A0(n30), .A1(n10), .B0(n31), .Y(n45) );
  OAI21X1 U22 ( .A0(n12), .A1(n30), .B0(rx_data[1]), .Y(n31) );
  AOI31X1 U23 ( .A0(n29), .A1(n6), .A2(rx_cnt[1]), .B0(n2), .Y(n30) );
  NAND2X2 U24 ( .A(rxd_d1), .B(n38), .Y(n10) );
  OAI32XL U25 ( .A0(n21), .A1(rx_cnt[2]), .A2(n7), .B0(n3), .B1(n8), .Y(n54)
         );
  INVX2 U26 ( .A(n23), .Y(n3) );
  OAI32XL U27 ( .A0(n4), .A1(rx_cnt[0]), .A2(n5), .B0(n6), .B1(n26), .Y(n56)
         );
  NAND3BX2 U28 ( .AN(bps_cnt[0]), .B(n39), .C(bps_cnt[1]), .Y(n20) );
  INVX2 U29 ( .A(rx_cnt[0]), .Y(n6) );
  AND2X2 U30 ( .A(n20), .B(rx_flag), .Y(n12) );
  NOR2X2 U31 ( .A(n8), .B(rx_cnt[3]), .Y(n24) );
  NOR2X2 U32 ( .A(rx_cnt[2]), .B(rx_cnt[3]), .Y(n29) );
  NOR4X2 U33 ( .A(bps_cnt[9]), .B(bps_cnt[8]), .C(bps_cnt[7]), .D(bps_cnt[6]), 
        .Y(n43) );
  OAI21X1 U34 ( .A0(rx_cnt[1]), .A1(n4), .B0(n25), .Y(n23) );
  NAND2X2 U35 ( .A(rx_flag), .B(n39), .Y(n26) );
  OAI22X1 U36 ( .A0(n25), .A1(n7), .B0(rx_cnt[1]), .B1(n21), .Y(n55) );
  OAI2B2X1 U37 ( .A1N(rxd_d1), .A0(rxd_d0), .B0(n19), .B1(n4), .Y(n52) );
  NOR2BX1 U38 ( .AN(n1), .B(n20), .Y(n19) );
  OAI22X1 U39 ( .A0(n13), .A1(n21), .B0(n22), .B1(n58), .Y(n53) );
  AOI21X1 U40 ( .A0(rx_flag), .A1(n8), .B0(n23), .Y(n22) );
  INVX2 U41 ( .A(rx_cnt[1]), .Y(n7) );
  AOI21X1 U42 ( .A0(n6), .A1(rx_flag), .B0(n5), .Y(n25) );
  NAND3X2 U43 ( .A(rx_flag), .B(n26), .C(rx_cnt[0]), .Y(n21) );
  INVX2 U44 ( .A(rx_flag), .Y(n4) );
  AND4X2 U45 ( .A(n40), .B(n41), .C(n42), .D(n43), .Y(n39) );
  NOR3X1 U46 ( .A(bps_cnt[10]), .B(bps_cnt[12]), .C(bps_cnt[11]), .Y(n40) );
  NOR3X1 U47 ( .A(bps_cnt[3]), .B(bps_cnt[5]), .C(bps_cnt[4]), .Y(n42) );
  NOR4X2 U48 ( .A(bps_cnt[2]), .B(bps_cnt[15]), .C(bps_cnt[14]), .D(
        bps_cnt[13]), .Y(n41) );
  NAND2X2 U49 ( .A(rx_cnt[1]), .B(n24), .Y(n13) );
  OAI21X1 U50 ( .A0(n27), .A1(n10), .B0(n28), .Y(n44) );
  OAI21X1 U51 ( .A0(n12), .A1(n27), .B0(rx_data[0]), .Y(n28) );
  AOI31X1 U52 ( .A0(n29), .A1(n7), .A2(rx_cnt[0]), .B0(n2), .Y(n27) );
  OAI21X1 U53 ( .A0(n32), .A1(n10), .B0(n33), .Y(n46) );
  OAI21X1 U54 ( .A0(n12), .A1(n32), .B0(rx_data[2]), .Y(n33) );
  AOI31X1 U55 ( .A0(n29), .A1(rx_cnt[1]), .A2(rx_cnt[0]), .B0(n2), .Y(n32) );
  OAI21X1 U56 ( .A0(n34), .A1(n10), .B0(n35), .Y(n47) );
  OAI21X1 U57 ( .A0(n12), .A1(n34), .B0(rx_data[3]), .Y(n35) );
  AOI31X1 U58 ( .A0(n24), .A1(n7), .A2(n6), .B0(n2), .Y(n34) );
  OAI21X1 U59 ( .A0(n36), .A1(n10), .B0(n37), .Y(n48) );
  OAI21X1 U60 ( .A0(n12), .A1(n36), .B0(rx_data[4]), .Y(n37) );
  AOI31X1 U61 ( .A0(rx_cnt[0]), .A1(n7), .A2(n24), .B0(n2), .Y(n36) );
  OAI21X1 U62 ( .A0(n9), .A1(n10), .B0(n11), .Y(n49) );
  OAI21X1 U63 ( .A0(n12), .A1(n9), .B0(rx_data[5]), .Y(n11) );
  AOI2BB1X2 U64 ( .A0N(rx_cnt[0]), .A1N(n13), .B0(n2), .Y(n9) );
  OAI21X1 U65 ( .A0(n14), .A1(n10), .B0(n15), .Y(n50) );
  OAI21X1 U66 ( .A0(n12), .A1(n14), .B0(rx_data[6]), .Y(n15) );
  AOI2BB1X2 U67 ( .A0N(n13), .A1N(n6), .B0(n2), .Y(n14) );
  OAI21X1 U68 ( .A0(n16), .A1(n10), .B0(n17), .Y(n51) );
  OAI21X1 U69 ( .A0(n12), .A1(n16), .B0(rx_data[7]), .Y(n17) );
  AOI31X1 U70 ( .A0(n18), .A1(n6), .A2(rx_cnt[3]), .B0(n2), .Y(n16) );
  NOR2X2 U71 ( .A(rx_cnt[1]), .B(rx_cnt[2]), .Y(n18) );
  INVX2 U72 ( .A(rx_cnt[2]), .Y(n8) );
  INVX2 U73 ( .A(rx_cnt[3]), .Y(n58) );
  CLKBUFX4 U74 ( .A(n57), .Y(n1) );
  NOR4X2 U75 ( .A(n58), .B(n6), .C(rx_cnt[1]), .D(rx_cnt[2]), .Y(n57) );
  AND2X2 U76 ( .A(N28), .B(n5), .Y(N68) );
  AND2X2 U77 ( .A(rx_data[5]), .B(n1), .Y(N162) );
  AND2X2 U78 ( .A(rx_data[6]), .B(n1), .Y(N163) );
  AND2X2 U79 ( .A(rx_data[7]), .B(n1), .Y(N164) );
  AND2X2 U80 ( .A(n1), .B(rx_data[0]), .Y(N157) );
  AND2X2 U81 ( .A(n1), .B(rx_data[1]), .Y(N158) );
  AND2X2 U82 ( .A(n1), .B(rx_data[2]), .Y(N159) );
  AND2X2 U83 ( .A(n1), .B(rx_data[3]), .Y(N160) );
  AND2X2 U84 ( .A(n1), .B(rx_data[4]), .Y(N161) );
endmodule


module uart_tx_CLOCK_FREQ50000000_UART_BPS10000000_DW01_inc_0 ( A, SUM );
  input [15:0] A;
  output [15:0] SUM;

  wire   [15:2] carry;

  ADDHX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .CO(carry[15]), .S(SUM[14]) );
  ADDHX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .CO(carry[14]), .S(SUM[13]) );
  ADDHX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX1 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[15]), .B(A[15]), .Y(SUM[15]) );
endmodule


module uart_tx_CLOCK_FREQ50000000_UART_BPS10000000 ( sys_clk, sys_rst_n, tx_en, 
        uart_din, uart_tx );
  input [7:0] uart_din;
  input sys_clk, sys_rst_n, tx_en;
  output uart_tx;
  wire   tx_en_d1, tx_en_d0, tx_flag, N21, N22, N23, N24, N25, N26, N27, N28,
         N29, N30, N31, N32, N33, N34, N35, N36, N61, N62, N63, N64, N65, N66,
         N67, N68, N69, N70, N71, N72, N73, N74, N75, N76, N135, n8, n9, n10,
         n11, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n1, n2, n3, n4, n5, n6,
         n7, n12, n49, n50;
  wire   [15:0] bps_cnt;
  wire   [3:0] tx_cnt;
  wire   [7:0] tx_data;

  uart_tx_CLOCK_FREQ50000000_UART_BPS10000000_DW01_inc_0 add_71 ( .A(bps_cnt), 
        .SUM({N36, N35, N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24, 
        N23, N22, N21}) );
  DFFRQX2 tx_en_d1_reg ( .D(tx_en_d0), .CK(sys_clk), .RN(sys_rst_n), .Q(
        tx_en_d1) );
  DFFRQX2 \tx_data_reg[0]  ( .D(n43), .CK(sys_clk), .RN(sys_rst_n), .Q(
        tx_data[0]) );
  DFFRQX2 \tx_data_reg[4]  ( .D(n39), .CK(sys_clk), .RN(sys_rst_n), .Q(
        tx_data[4]) );
  DFFRQX2 \tx_data_reg[2]  ( .D(n41), .CK(sys_clk), .RN(sys_rst_n), .Q(
        tx_data[2]) );
  DFFRQX2 \tx_data_reg[1]  ( .D(n42), .CK(sys_clk), .RN(sys_rst_n), .Q(
        tx_data[1]) );
  DFFRQX2 \bps_cnt_reg[15]  ( .D(N76), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[15]) );
  DFFRQX2 \tx_cnt_reg[3]  ( .D(n45), .CK(sys_clk), .RN(sys_rst_n), .Q(
        tx_cnt[3]) );
  DFFRQX2 \bps_cnt_reg[6]  ( .D(N67), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[6]) );
  DFFRQX2 \bps_cnt_reg[13]  ( .D(N74), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[13]) );
  DFFRQX2 \bps_cnt_reg[9]  ( .D(N70), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[9]) );
  DFFRQX2 \bps_cnt_reg[8]  ( .D(N69), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[8]) );
  DFFRQX2 \bps_cnt_reg[5]  ( .D(N66), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[5]) );
  DFFRQX2 \bps_cnt_reg[12]  ( .D(N73), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[12]) );
  DFFRQX2 \bps_cnt_reg[7]  ( .D(N68), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[7]) );
  DFFRQX2 \bps_cnt_reg[14]  ( .D(N75), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[14]) );
  DFFRQX2 \bps_cnt_reg[10]  ( .D(N71), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[10]) );
  DFFRQX2 \bps_cnt_reg[11]  ( .D(N72), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[11]) );
  DFFRQX2 \tx_cnt_reg[2]  ( .D(n4), .CK(sys_clk), .RN(sys_rst_n), .Q(tx_cnt[2]) );
  DFFRX1 \tx_data_reg[3]  ( .D(n40), .CK(sys_clk), .RN(sys_rst_n), .QN(n11) );
  DFFRX1 \tx_data_reg[6]  ( .D(n37), .CK(sys_clk), .RN(sys_rst_n), .QN(n9) );
  DFFRX1 \tx_data_reg[5]  ( .D(n38), .CK(sys_clk), .RN(sys_rst_n), .QN(n10) );
  DFFRX1 \tx_data_reg[7]  ( .D(n44), .CK(sys_clk), .RN(sys_rst_n), .QN(n8) );
  DFFRQX2 tx_flag_reg ( .D(n48), .CK(sys_clk), .RN(sys_rst_n), .Q(tx_flag) );
  DFFRQX2 \tx_cnt_reg[0]  ( .D(n47), .CK(sys_clk), .RN(sys_rst_n), .Q(
        tx_cnt[0]) );
  DFFRQX2 \tx_cnt_reg[1]  ( .D(n46), .CK(sys_clk), .RN(sys_rst_n), .Q(
        tx_cnt[1]) );
  DFFRQX2 \bps_cnt_reg[1]  ( .D(N62), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[1]) );
  DFFRQX2 \bps_cnt_reg[2]  ( .D(N63), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[2]) );
  DFFRQX2 \bps_cnt_reg[3]  ( .D(N64), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[3]) );
  DFFRQX2 \bps_cnt_reg[4]  ( .D(N65), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[4]) );
  DFFRQX2 \bps_cnt_reg[0]  ( .D(N61), .CK(sys_clk), .RN(sys_rst_n), .Q(
        bps_cnt[0]) );
  DFFRQX2 tx_en_d0_reg ( .D(tx_en), .CK(sys_clk), .RN(sys_rst_n), .Q(tx_en_d0)
         );
  DFFSHQX8 uart_tx_reg ( .D(N135), .CK(sys_clk), .SN(sys_rst_n), .Q(uart_tx)
         );
  BUFX2 U3 ( .A(n13), .Y(n2) );
  BUFX2 U4 ( .A(n5), .Y(n1) );
  INVX2 U5 ( .A(n21), .Y(n5) );
  NOR2BX1 U6 ( .AN(N35), .B(n1), .Y(N75) );
  NOR2BX1 U7 ( .AN(N34), .B(n1), .Y(N74) );
  NOR2X2 U8 ( .A(n6), .B(n23), .Y(n21) );
  NOR3X2 U9 ( .A(n7), .B(n21), .C(n6), .Y(n18) );
  INVX2 U10 ( .A(n14), .Y(n3) );
  OAI2BB2X2 U11 ( .B0(n20), .B1(n12), .A0N(n18), .A1N(n12), .Y(n46) );
  OAI21X1 U12 ( .A0(n2), .A1(n6), .B0(n14), .Y(n48) );
  NOR2BX1 U13 ( .AN(N33), .B(n1), .Y(N73) );
  NOR2BX1 U14 ( .AN(N32), .B(n1), .Y(N72) );
  NOR2BX1 U15 ( .AN(N31), .B(n1), .Y(N71) );
  NOR2BX1 U16 ( .AN(N30), .B(n1), .Y(N70) );
  NOR2BX1 U17 ( .AN(N29), .B(n1), .Y(N69) );
  NOR2BX1 U18 ( .AN(N28), .B(n5), .Y(N68) );
  NOR2BX1 U19 ( .AN(N27), .B(n5), .Y(N67) );
  NOR2BX1 U20 ( .AN(N26), .B(n5), .Y(N66) );
  NOR2BX1 U21 ( .AN(N25), .B(n5), .Y(N65) );
  NOR2BX1 U22 ( .AN(N24), .B(n5), .Y(N64) );
  NOR2BX1 U23 ( .AN(N23), .B(n5), .Y(N63) );
  NOR2BX1 U24 ( .AN(N22), .B(n5), .Y(N62) );
  NOR2BX1 U25 ( .AN(N36), .B(n1), .Y(N76) );
  OAI31X1 U26 ( .A0(n22), .A1(n23), .A2(n24), .B0(n14), .Y(n13) );
  OR2X2 U27 ( .A(bps_cnt[0]), .B(tx_cnt[2]), .Y(n24) );
  NAND3XL U28 ( .A(bps_cnt[1]), .B(n25), .C(tx_cnt[3]), .Y(n22) );
  OAI32XL U29 ( .A0(n6), .A1(tx_cnt[0]), .A2(n21), .B0(n7), .B1(n1), .Y(n47)
         );
  OAI32XL U30 ( .A0(n15), .A1(n12), .A2(n49), .B0(n16), .B1(n50), .Y(n45) );
  NAND2X2 U31 ( .A(n18), .B(n50), .Y(n15) );
  AOI21X1 U32 ( .A0(tx_flag), .A1(n49), .B0(n17), .Y(n16) );
  INVX2 U33 ( .A(tx_cnt[0]), .Y(n7) );
  NOR4X2 U34 ( .A(bps_cnt[9]), .B(bps_cnt[8]), .C(bps_cnt[7]), .D(bps_cnt[6]), 
        .Y(n29) );
  AOI31X1 U35 ( .A0(n12), .A1(n8), .A2(n7), .B0(n50), .Y(n33) );
  NOR2X2 U36 ( .A(n7), .B(tx_cnt[1]), .Y(n25) );
  OAI22X1 U37 ( .A0(n7), .A1(n9), .B0(tx_cnt[0]), .B1(n10), .Y(n35) );
  OAI2BB2X2 U38 ( .B0(n34), .B1(n12), .A0N(n25), .A1N(tx_data[0]), .Y(n32) );
  AOI22XL U39 ( .A0(tx_data[1]), .A1(n7), .B0(tx_data[2]), .B1(tx_cnt[0]), .Y(
        n34) );
  INVX2 U40 ( .A(tx_flag), .Y(n6) );
  OAI21X1 U41 ( .A0(tx_cnt[1]), .A1(n6), .B0(n20), .Y(n17) );
  NAND4X2 U42 ( .A(n26), .B(n27), .C(n28), .D(n29), .Y(n23) );
  NOR3X1 U43 ( .A(bps_cnt[10]), .B(bps_cnt[12]), .C(bps_cnt[11]), .Y(n26) );
  NOR3X1 U44 ( .A(bps_cnt[3]), .B(bps_cnt[5]), .C(bps_cnt[4]), .Y(n28) );
  NOR4X2 U45 ( .A(bps_cnt[2]), .B(bps_cnt[15]), .C(bps_cnt[14]), .D(
        bps_cnt[13]), .Y(n27) );
  AOI21X1 U46 ( .A0(n7), .A1(tx_flag), .B0(n21), .Y(n20) );
  OAI211XL U47 ( .A0(n30), .A1(n49), .B0(tx_flag), .C0(n31), .Y(N135) );
  AOI221XL U48 ( .A0(tx_cnt[1]), .A1(n35), .B0(tx_data[4]), .B1(n25), .C0(n36), 
        .Y(n30) );
  AOI21X1 U49 ( .A0(n32), .A1(n49), .B0(n33), .Y(n31) );
  OAI31X1 U50 ( .A0(n11), .A1(tx_cnt[1]), .A2(tx_cnt[0]), .B0(n50), .Y(n36) );
  INVX2 U51 ( .A(tx_cnt[2]), .Y(n49) );
  INVX2 U52 ( .A(tx_cnt[1]), .Y(n12) );
  OAI2BB2X2 U53 ( .B0(n2), .B1(n8), .A0N(uart_din[7]), .A1N(n3), .Y(n44) );
  OAI2BB2X2 U54 ( .B0(n2), .B1(n10), .A0N(uart_din[5]), .A1N(n3), .Y(n38) );
  OAI2BB2X2 U55 ( .B0(n2), .B1(n11), .A0N(uart_din[3]), .A1N(n3), .Y(n40) );
  OAI2BB2X2 U56 ( .B0(n2), .B1(n9), .A0N(uart_din[6]), .A1N(n3), .Y(n37) );
  INVX2 U57 ( .A(tx_cnt[3]), .Y(n50) );
  NAND2BX2 U58 ( .AN(tx_en_d1), .B(tx_en), .Y(n14) );
  NOR2BX1 U59 ( .AN(N21), .B(n5), .Y(N61) );
  INVX2 U60 ( .A(n19), .Y(n4) );
  AOI32XL U61 ( .A0(tx_cnt[1]), .A1(n49), .A2(n18), .B0(n17), .B1(tx_cnt[2]), 
        .Y(n19) );
  AO2B2X2 U62 ( .B0(uart_din[0]), .B1(n3), .A0(tx_data[0]), .A1N(n2), .Y(n43)
         );
  AO2B2X2 U63 ( .B0(uart_din[1]), .B1(n3), .A0(tx_data[1]), .A1N(n2), .Y(n42)
         );
  AO2B2X2 U64 ( .B0(uart_din[2]), .B1(n3), .A0(tx_data[2]), .A1N(n2), .Y(n41)
         );
  AO2B2X2 U65 ( .B0(uart_din[4]), .B1(n3), .A0(tx_data[4]), .A1N(n2), .Y(n39)
         );
endmodule


module uart_top ( sys_clk, sys_rst_n, uart_rx, uart_tx, en );
  input sys_clk, sys_rst_n, uart_rx;
  output uart_tx, en;
  wire   n2;
  wire   [7:0] uart_data;

  uart_rx_CLOCK_FREQ50000000_UART_BPS10000000 uart_rx_inst ( .sys_clk(sys_clk), 
        .sys_rst_n(sys_rst_n), .uart_rx(uart_rx), .uart_rxd(uart_data), 
        .rx_done(n2) );
  uart_tx_CLOCK_FREQ50000000_UART_BPS10000000 uart_tx_inst ( .sys_clk(sys_clk), 
        .sys_rst_n(sys_rst_n), .tx_en(n2), .uart_din(uart_data), .uart_tx(
        uart_tx) );
  BUFX5 U1 ( .A(n2), .Y(en) );
endmodule

