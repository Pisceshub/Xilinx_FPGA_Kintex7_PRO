`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2023 11:42:17 PM
// Design Name: 
// Module Name: uart_top_tb
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


module uart_top_tb();
    
    //生成的信号定义
    reg sys_clk_reg;
    reg sys_rst_n_reg;
    reg uart_rx_reg;
    
    //连接的信号
    wire sys_clk = sys_clk_reg;
    wire sys_rst_n = sys_rst_n_reg;
    wire uart_rx = uart_rx_reg;
    wire uart_tx;
    wire en;

    //生成时钟和复位信号
    always #10 sys_clk_reg=~sys_clk_reg;
    initial begin
        sys_clk_reg   = 0;
        sys_rst_n_reg = 0;
        uart_rx_reg = 1'b1;
        #20
        sys_rst_n_reg = 1;
        repeat (10) begin
            # 100 uart_rx_reg = 1'b1;
            # 100 uart_rx_reg = 1'b1;
            # 100 uart_rx_reg = 1'b0;
            # 100 uart_rx_reg = 1'b1;
            # 100 uart_rx_reg = 1'b1;
            # 100 uart_rx_reg = 1'b0;
            # 100 uart_rx_reg = 1'b0;
            # 100 uart_rx_reg = 1'b1;
            # 100 uart_rx_reg = 1'b0;
            # 100 uart_rx_reg = 1'b0;
            # 100 uart_rx_reg = 1'b1;
            # 100 uart_rx_reg = 1'b0;
            # 100 uart_rx_reg = 1'b1;
            # 100 uart_rx_reg = 1'b1;
        end

    end
    
    // uart_top uart_top_inst(
    //     .sys_clk(sys_clk),  //时钟
    //     .sys_rst_n(sys_rst_n),     //复位

    //     .uart_rx(uart_rx),  //  接收数据
    //     .uart_tx(uart_tx),  //  发送数据
    //     .en(en)
    // );
    
    initial begin
        # 10000;
        $finish; 
    end
    
    `ifdef FSDB
    initial begin
        $fsdbDumpfile("simv.fsdb");
        $fsdbDumpvars;
    end
    `endif 
    `ifdef VCD
    initial begin
            $dumpfile("simv.vcd");
            $dumpvars;
    end
    `endif  
endmodule