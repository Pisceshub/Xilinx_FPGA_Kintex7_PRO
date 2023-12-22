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

module uart_tx #(
    parameter CLOCK_FREQ = 50_000_000,
    parameter UART_BPS  = 1000_000
)
(
    input sys_clk,              //时钟
    input sys_rst_n,            //复位
    input tx_en,                //使能
    input wire [7:0] uart_din,  //输入要输出的数据

    output wire uart_tx_busy,  //正在发送
    output reg uart_tx         //发送的数据线
);


    localparam BPS_CNT = CLOCK_FREQ/UART_BPS;   //接收的比特计数器最大值=50个clk

    wire start_flag;

    reg tx_en_d0;       
    reg tx_en_d1;       

    reg tx_flag;        //发送过程标志

    reg [15:0]  bps_cnt;
    reg [3:0]   tx_cnt;
    reg [7:0]   tx_data;        //发送数据寄存

    assign uart_tx_busy = tx_flag;
    assign start_flag = tx_en && (~tx_en_d1);   //看tx_en的上升沿,到了就开始
    
    //打两拍抓沿
    always@(posedge sys_clk or negedge sys_rst_n)begin
        if(!sys_rst_n)begin
            tx_en_d0  <= 1'b0;
            tx_en_d1  <= 1'b0;
        end
        else begin
            tx_en_d0 <= tx_en;
            tx_en_d1 <= tx_en_d0;
        end
    end

    // 波特率计数和发送数据计数
    always@(posedge sys_clk or negedge sys_rst_n)begin
        if(!sys_rst_n)begin
            bps_cnt <= 16'b0;
            tx_cnt  <= 4'b0;
        end
        else if(tx_flag) begin
            if(bps_cnt < BPS_CNT - 1) begin   //没有加到波特率就一直加
                bps_cnt <= bps_cnt + 1'b1;
                tx_cnt  <= tx_cnt;
            end
            else begin
                bps_cnt <= 16'd0;
                tx_cnt <= tx_cnt + 1'b1;           //加到了就计一位
            end
        end
        
        else begin
            bps_cnt <= 16'd0;
            tx_cnt <=4'd0;
        end
    end

    //计数到了刷新标志
    always@(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n)begin
            tx_flag <= 1'b0;
            tx_data <= 8'd0;
        end
        else if(start_flag)begin            //在发送中
            tx_flag <= 1'b1;
            tx_data <= uart_din;
        end
        else if((tx_cnt == 4'd9)&&(bps_cnt == BPS_CNT/2))begin              //发送结束
            tx_flag <= 1'b0;
            tx_data <= 8'b0;
        end
        else begin
            tx_flag <= tx_flag;
            tx_data <= tx_data;

        end
    end

    //发送数据

    always@(posedge	sys_clk	or	negedge	sys_rst_n)begin
    	if(!sys_rst_n)begin
    		uart_tx		<=		1'b1;		//空闲状态，发送端为高电平
    	end
    	else if(tx_flag)begin
    			case(tx_cnt)
    				4'd0	:	uart_tx	<=	1'b0;//起始位
    				4'd1	:	uart_tx	<=	tx_data[0];
    				4'd2	:	uart_tx	<=	tx_data[1];
    				4'd3	:	uart_tx	<=	tx_data[2];
    				4'd4	:	uart_tx	<=	tx_data[3];
    				4'd5	:	uart_tx	<=	tx_data[4];
    				4'd6	:	uart_tx	<=	tx_data[5];
    				4'd7	:	uart_tx	<=	tx_data[6];
    				4'd8	:	uart_tx	<=	tx_data[7];
    				4'd9	:	uart_tx	<=	1'b1;//停止位
    				default	:	uart_tx	<=	1'b1;
    				endcase
    			end
    		else begin
    			uart_tx	<=	1'b1;
    		end
    end
endmodule
