`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2023 07:39:50 PM
// Design Name: 
// Module Name: M0_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// `ifdef K325T
// `else
//     `include "/home/ICer/my_ic/wild_fire/src/rtl/000.my_m0_0macro/AHBLITE_SYS.v"
//     `include "/home/ICer/my_ic/wild_fire/src/glbl/fsdb.v"
//     
// `endif
`include "/home/ICer/my_ic/project/wild_fire/src/rtl/000.my_m0_0macro/vcs_define_macro.v"
module M0_tb();
    reg                     sys_clk;
    reg                     sys_rst_n;
    reg     [3:0]           key;
    wire    [7:0]           led;
    wire    [6:0]   		seg ;
    wire 	[7:0]   		an;
    wire    				dp;
    reg                     rx;
    wire                    tx;
    wire                    eth_mdc;
    wire                    eth_mdio;



    `ifdef K7BOARD
        AHBLITE_SYS AHBLITE_SYS_U1(
            .sys_clk(sys_clk),
            .sys_rst_n(sys_rst_n),
            .key(key),
            .led(led),
            .eth_mdc(eth_mdc),
            .eth_mdio(eth_mdio),
            .rx(rx),
            .tx(tx)
        );
    `else
        AHBLITE_SYS AHBLITE_SYS_U1(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key(key),
        .led(led),
        .seg(seg),
        .an(an),
        .dp(dp),
        .eth_mdc(eth_mdc),
        .eth_mdio(eth_mdio),
        .rx(rx),
        .tx(tx)
        );
    `endif 

    `ifdef BTN_NVIC_TEST
        initial begin
            repeat (10) begin
                #1000 key = 4'b1110;
                #600  key = 4'b1111;
                #1000 key = 4'b1111;
                #600  key = 4'b1110;
                #1000 key = 4'b1110;
                #600  key = 4'b1111;
            end 
        end
    `endif

    `ifdef UART_TEST
        initial begin
            #80000
            repeat (1) begin
                #2050 rx = 1'b1;
                #1000 rx = 1'b0;

                #1000 rx = 1'b1;
                #1000 rx = 1'b1;
                #1000 rx = 1'b0;
                #1000 rx = 1'b0;

                #1000 rx = 1'b1;
                #1000 rx = 1'b1;
                #1000 rx = 1'b0;
                #1000 rx = 1'b1;

                #1000 rx = 1'b1;
                #1000 rx = 1'b1;
                #1000 rx = 1'b1;
                
            end
        end
    `endif

        	


    always  #10 sys_clk = ~sys_clk;
    initial begin
        sys_clk = 0;
        sys_rst_n = 0;
        key = 4'b1111;
        rx = 1'b1;
        # 100;
        sys_rst_n = 1;
    end

    always # 100000 $display("simulation have done %d us",$time/1000);

    `ifndef K325T
        fsdb #(.finishtime(100000)) fsdb_u();
    `endif

endmodule
