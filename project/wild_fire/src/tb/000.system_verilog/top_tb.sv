`timescale 1ns/1ps
`include "/home/ICer/my_ic/wild_fire/src/tb/000.system_verilog/my_if.sv"
`include "/home/ICer/my_ic/wild_fire/src/tb/000.system_verilog/my_transaction.sv"
`include "/home/ICer/my_ic/wild_fire/src/tb/000.system_verilog/my_driver.sv" 
import uvm_pkg::*;  //将uvm_pkg导入验证平台,导入后才会识别uvm_driver等类名
`include "/home/ICer/my_ic/uvm/uvm_lib/uvm-1.1a/src/uvm_macros.svh" //包含众多
module top_tb;

reg clk;
reg rst_n;
reg[7:0] rxd;
reg rx_dv;
wire[7:0] txd;
wire tx_en;

/*
dut my_dut(.clk(clk),
           .rst_n(rst_n),
           .rxd(rxd),
           .rx_dv(rx_dv),
           .txd(txd),
           .tx_en(tx_en));
*/

/*加入interface,在top_tb中实例化DUT*/
my_if input_if(clk,rst_n);
my_if output_if(clk,rst_n);
dut my_dut(.clk(clk),
           .rst_n(rst_n),
           .rxd(input_if.data),
           .rx_dv(input_if.valid),
           .txd(output_if.data),
           .tx_en(output_if.valid));
initial begin
   /*
   my_driver drv;          //定义一个my_driver实例
   drv = new("drv1", null); //将属于my_driver类的drv实例化,传入参数drv,路径索引的drv就是这里的参数,这里暂时用null
   drv.main_phase(null); //调用类中的main_phase任务,这里的null不用管
   $finish();
   */

   /*
   run_test("my_driver"); //当加入factory后,修改为此句,该句会创建一个my_driver实例,并自动调用实例的main_phase.
   */

   /*加入env后,使用my_env*/
   run_test("my_env");
end

initial begin
   clk = 0;
   forever begin
      #100 clk = ~clk;
   end
end

initial begin
   rst_n = 1'b0;
   #1000;
   rst_n = 1'b1;
end

/*config_db机制,在top_tb中执行set操作,在my_driver中执行get操作*/
initial begin
   uvm_config_db#(virtual my_if)::set(null,"uvm_test_top.i_agt.my_drv","vif",input_if);
   /*set第四个参数表示将哪个interface通过config_db传递给my_driver,第二个参数表示路径索引,top_tb中用run_test创建的my_driver实例,实例的名字就是uvm_test_top(全都是这个名字)*/
   /*::表示静态函数.uvm_config_db#(virtual my_if)表示一个参数化的类,参数就是寄信的类型*/
   uvm_config_db #(virtual my_if )::set(null,"uvm_test_top.i_agt.mon","vif",input_if);
   uvm_config_db #(virtual my_if )::set(null,"uvm_test_top.o_agt.mon","vif",output_if);


   uvm_config_db #(virtual my_if)::set(null,"uvm_test_top.i_agt.my_drv","vif2",output_if);

   /*如果要传递一个int类型数据,并修改my_driver*/
   uvm_config_db #(int )::set(null,"uvm_test_top.i_agt.my_drv","var_int",100);




end


initial begin
    $fsdbDumpfile("simv.fsdb");
    $fsdbDumpvars;
end

endmodule
