`ifndef MY_TRANSACTION__SV
`define MY_TRANSACTION__SV
class my_transaction extends uvm_sequence_item; //transaction 的父类
    rand bit [47:0] dmac;//目的mac地址
    rand bit [47:0] smac;//源mac地址
    rand bit [15:0] ether_type; //以太网类型
    rand byte pload[];//携带数据大小
    rand bit [31:0] crc; //校验

    constraint pload_cons{
        pload.size >= 46;
        pload.size <= 1500;
    }
    //约束

    function bit[31:0] calc_crc();
        return 32'h0;   
    endfunction //new()

    function void post_randomize(); //post_randomize时SV函数,当某个类实例的randomize调用后,她会随后无条件调用
        //加入空函数calc_crc
        crc = calc_crc;
    endfunction

    //`uvm_object_utils(my_transaction)
    /*这里没有用uvm_component_utils实现factory机制
    my_transaction与my_driver不同,前者有生命周期,仿真某一个时间产生,经过driver驱动,经过reference model处理,由记分scoreboard比较完成后结束*/


    /*uvm_object_utils_begin end实现my_transaction 的factory注册,
    之后可以直接调用copy,compare print等函数,不需要自己定义了*/
    `uvm_object_utils_begin(my_transaction)
      `uvm_field_int(dmac, UVM_ALL_ON)
      `uvm_field_int(smac, UVM_ALL_ON)
      `uvm_field_int(ether_type, UVM_ALL_ON)
      `uvm_field_array_int(pload, UVM_ALL_ON)
      `uvm_field_int(crc, UVM_ALL_ON)
   `uvm_object_utils_end
    
    function new(string name = "my_transaction");
        super.new(name);
    endfunction

    /*收集完transaction后,通过该函数打印出来*/
    /*
    function void my_print();
      $display("dmac = %0h", dmac);
      $display("smac = %0h", smac);
      $display("ether_type = %0h", ether_type);
      for(int i = 0; i < pload.size; i++) begin
         $display("pload[%0d] = %0h", i, pload[i]);
      end
      $display("crc = %0h", crc);
   endfunction
    */
endclass //my_transaction 

`endif

