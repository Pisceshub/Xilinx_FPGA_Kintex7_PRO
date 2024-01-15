`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV
/*用于产生激励*/
class my_sequencer extends uvm_sequencer #(my_transaction);
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(my_sequencer)
endclass

`endif
