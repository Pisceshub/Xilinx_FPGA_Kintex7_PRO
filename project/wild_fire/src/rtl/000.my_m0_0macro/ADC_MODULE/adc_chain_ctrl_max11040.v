/*
    该模块实现功能：复位后重新配置寄存器，配置完成后、开始读数据，并保存到此模块中
    管脚说明：
    clk,rstn:时钟,复位
    上电后cfg模块自动等待时间,并陆续输出spi_en和spi_data

*/
/*上电就配置写存器,之后就使能读*/

module adc_chain_ctrl_max11040 #(
    parameter  ADC_DCN = 8,
    parameter  DATA_WIDTH = 8 
)(
    //system signal:
    input                           sys_clk,
    input                           sys_rst_n,

    //控制信号
    output                          cfg_w_en,               //配置使能
    input  [DATA_WIDTH-1:0]         cfg_w_spi_dataout,
    input           wire            cfg_w_spi_dataout_valid,
    input           wire            cfg_w_spi_cs,
    output  wire                    cfg_w_spi_done,
    input  wire                     cfg_w_done,            //配置完成信号

    output                          cfg_r_en,                //读使能
    input  [DATA_WIDTH-1:0]         cfg_r_spi_dataout,
    input           wire            cfg_r_spi_dataout_valid,
    input           wire            cfg_r_spi_cs,
    output  wire                    cfg_r_spi_done,            //配置完成信号
    input  wire                     cfg_r_done,            //配置完成信号

    output  [DATA_WIDTH-1:0]        spi_datain,
    output           wire           spi_datain_valid,
    input   [DATA_WIDTH-1:0]        spi_dataout,
    input           wire            spi_dataout_ready,
    output           wire           spi_cs,
    input  wire                     spi_done,            //配置完成信号

    output [ADC_DCN*4*24:0]         frame_data,             //加入帧传出去
    output                          frame_valid,            //保存使能

    output                          w_interruput, //中断
    input  wire                     w_interruput_grant,//中断响应
    output                          r_interruput, //中断
    input  wire                     r_interruput_grant,//中断响应
    input [15:0]                    ADC_SAMPLE_NUMBER_MAX,
    input wire                      DRDYOUT,  
    output wire                     DRDYOUT_valid      
    
);    
    //DRDYIN打两拍取上升up
    reg drdyout_d0,drdyout_d1;
    always@(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            drdyout_d0 <= 1'b0;
            drdyout_d1 <= 1'b0;
        end
        else begin
            drdyout_d0 <= DRDYOUT;
            drdyout_d1 <= drdyout_d0;
        end
    end
    assign DRDYOUT_valid = (drdyout_d0)&&(~drdyout_d1);
   
endmodule