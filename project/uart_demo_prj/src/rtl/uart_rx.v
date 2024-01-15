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

module uart_rx #(
    parameter CLOCK_FREQ = 50_000_000,
    parameter UART_BPS  = 1000_000
)
(
    input sys_clk,          //时钟
    input sys_rst_n,        //复位
    input uart_rx,         //接收的数据线

    output reg [7:0] uart_rxd,  //输出接收的数据
    output reg rx_done         //接收完成 
);

    localparam BPS_CNT = CLOCK_FREQ/UART_BPS;   //接收的比特计数器最大值=50个clk

    wire start_flag;            //对uart_rx下降沿进行检测

    reg rxd_d0;       
    reg rxd_d1;       

    reg rx_flag;        //接收数据标志信号

    reg [15:0]  bps_cnt;    //对时钟的计数
    reg [3:0]   rx_cnt;     //对接收的数据计数
    reg [7:0]   rx_data;    //接收的数据寄存

    assign start_flag = rxd_d1 && (~rxd_d0);   //下降沿检测

    //对uart_rx接收的数据延迟两个时钟单元
    always@(posedge sys_clk or negedge sys_rst_n)begin
        if(!sys_rst_n)begin
            rxd_d0  <= 1'b0;
            rxd_d1  <= 1'b0;
        end
        else begin
            rxd_d0 <= uart_rx;
            rxd_d1 <= rxd_d0;
        end
    end

    //当start_flag来临时，开始接收数据
    always@(posedge sys_clk or negedge sys_rst_n)begin
        if(!sys_rst_n)begin
            rx_flag  <= 1'b0;
        end

        else begin
            if(start_flag)begin
                rx_flag <= 1'b1;
            end
            else if((bps_cnt == BPS_CNT/2) && (rx_cnt == 4'd9))begin
                rx_flag <= 1'b0;
            end
            else begin
                rx_flag <= rx_flag;
            end
        end
    end

    //进入接收过程，启动时钟计数器和数据计数器
    always@(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            bps_cnt <= 16'd0;
            rx_cnt  <= 4'd0;
        end
        else if(rx_flag) begin
            if(bps_cnt < BPS_CNT - 1'b1)begin
                bps_cnt <= bps_cnt + 1'b1;
                rx_cnt <= rx_cnt;
            end
            else begin
                bps_cnt <= 16'd0;
                rx_cnt  <= rx_cnt + 1'b1;
            end
        end

        else begin
            bps_cnt <= 16'd0;
            rx_cnt  <= 4'd0;
        end
    end

    //通过计数器来寄存接收的数据
    always@(posedge sys_clk or negedge sys_rst_n)begin
        if(!sys_rst_n)begin
            rx_data <= 8'd0;
        end
        else if(rx_flag)begin
            if(bps_cnt == BPS_CNT/2)begin
                case(rx_cnt)
                    4'd1: rx_data[0] <= rxd_d1;
                    4'd2: rx_data[1] <= rxd_d1;
                    4'd3: rx_data[2] <= rxd_d1;
                    4'd4: rx_data[3] <= rxd_d1;
                    4'd5: rx_data[4] <= rxd_d1;
                    4'd6: rx_data[5] <= rxd_d1;
                    4'd7: rx_data[6] <= rxd_d1;
                    4'd8: rx_data[7] <= rxd_d1;
                default:;
                endcase
            end
            else begin
                rx_data <= rx_data;
            end
        end
        else begin
            rx_data <= 8'd0;
        end
    end

    //接收数据寄存，并输出接收完成标志位
    always@(posedge sys_clk or negedge sys_rst_n)begin
        if(!sys_rst_n) begin
            rx_done <= 1'b0;
            uart_rxd <= 8'd0;
        end
        else if(rx_cnt == 4'd9) begin
            rx_done <= 1'b1;
            uart_rxd <= rx_data;
        end
        else begin
            rx_done <= 1'b0;
            uart_rxd <= 8'd0;
        end
    end

endmodule