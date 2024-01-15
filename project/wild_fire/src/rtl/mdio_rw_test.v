/*----------------------------------------------------------------
****designer: 
****email: 
****date: 
****funtions: 
----------------------------------------------------------------*/
 
`timescale 1ns/1ps
module mdio_rw_test  #(
    //parameter
    parameter CLOCK_FREQ  = 50_000_000, //clock frequency
    parameter DATA_WIDTH  = 8          //width of data_width
)
(
    //sys signals
    input      sys_clk      ,          //sys clock
    input      sys_rst_n    ,          //sys rst
 
    //ctrl signals
    output     eth_mdc      ,           //eth clk
    inout      eth_mdio     ,           //eth dataio
    output      eth_rst_n   ,           //eth rst

    //
    input       touch_key   ,           //key
    output  [1:0] led                   //led
);


    wire        op_exec     ;       //触发开始信号

    localparam  ;
 
    reg         ;  // 

    wire        ;
 
    //funtion description
    always@(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            A <= 'd0 ;
        end
        else begin
            A <= B ;
        end
    end
    assign A <= B? 1'b1:1'b0;
 
    al
 
endmodule