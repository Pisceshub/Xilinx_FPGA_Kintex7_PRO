`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2023 04:21:00 PM
// Design Name: 
// Module Name: uart_rx
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


module uart_top(
    input sys_clk,  //时钟
    input sys_rst_n,     //复位

    input uart_rx,  //  接收数据线
    output uart_tx,  //  发送数据线
    output wire en
    );

    parameter CLOCK_FREQ = 50_000_000;  //时钟频率
    parameter UART_BPS = 10_000_000;      //波特率


    wire [7:0] uart_data;

    wire clk_out1;
    wire locked;
    
    clk_wiz_0 clk_wiz_inst
    (
    // Clock out ports  
    .clk_out1(clk_out1),
    // Status and control signals               
    .reset(~sys_rst_n), 
    .locked(locked),
    // Clock in ports
    .clk_in1(sys_clk)
    );

    // 实例化模块
    uart_rx #(
        .CLOCK_FREQ(CLOCK_FREQ),
        .UART_BPS(UART_BPS)
    ) 
    uart_rx_inst(
        .sys_clk(clk_out1),
        .sys_rst_n(locked),
        .uart_rx(uart_rx),

        .uart_rxd(uart_data),
        .rx_done(en)
    );


    uart_tx  #(
        .CLOCK_FREQ(CLOCK_FREQ),
        .UART_BPS(UART_BPS)
    ) 
    uart_tx_inst(
        .sys_clk(clk_out1),
        .sys_rst_n(locked),

        .uart_din(uart_data),
        .tx_en(en),
        .uart_tx(uart_tx)
    ); 
/*



    // 实例化模块
    uart_rx #(
        .CLOCK_FREQ(CLOCK_FREQ),
        .UART_BPS(UART_BPS)
    ) 
    uart_rx_inst(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .uart_rx(uart_rx),

        .uart_rxd(uart_data),
        .rx_done(en)
    );


    uart_tx  #(
        .CLOCK_FREQ(CLOCK_FREQ),
        .UART_BPS(UART_BPS)
    ) 
    uart_tx_inst(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),

        .uart_din(uart_data),
        .tx_en(en),
        .uart_tx(uart_tx)
    );

    */   
endmodule
