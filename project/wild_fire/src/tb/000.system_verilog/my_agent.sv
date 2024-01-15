`ifndef MY_AGENT__SV
`define MY_AGENT__SV


//将driver和monitor封装在一起,组成一个agent
class my_agent extends uvm_agent ;
   my_sequencer   sqr;
   my_driver      drv;
   my_monitor     mon;
   uvm_analysis_port #(my_transaction)  ap;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(my_agent) //实现facory注册
endclass 


function void my_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   //is_active时uvm_agent成员变量,默认时UVM_ACTIVE,此时需要实例化driver
   //还有UVM_PASSIVE模式,这章中输出端口不需要驱动任何信号,只需要监测,
   if (is_active == UVM_ACTIVE) begin
      sqr =my_sequencer::type_id::create("sqr", this);
      drv = my_driver::type_id::create("drv", this);
   end
   mon = my_monitor::type_id::create("mon", this);
endfunction 

function void my_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   iif (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(sqr.seq_item_export);
   end
   ap = mon.ap;
endfunction

`endif

