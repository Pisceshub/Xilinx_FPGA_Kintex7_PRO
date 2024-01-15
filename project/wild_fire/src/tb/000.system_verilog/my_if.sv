/*用interface来增强代码重用性,需要在top_tb中实例化*/
interface my_if(input clk,input rst_n);
    logic [7:0] data;
    logic valid;
    
endinterface //my_if(input clk,input rst_n)