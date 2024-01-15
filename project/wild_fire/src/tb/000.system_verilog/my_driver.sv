`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV
class my_driver extends uvm_driver#(my_transaction);

   `uvm_component_utils(my_driver); 
   /*
   1.引入factory机制,加入此句后,需要修改top_tb,2.根据类名创建一个类的实例,所有派生自uvm_component及其派生类的类都应该使用uvm_component_utils宏注册。3.被该宏注册且被实例化后,类的main_phase会自动被调用
   问题:data is drived没有输出,所以需要objection机制来控制验证平台的关闭,
   */
   
   int var_int;
   virtual my_if vif;
   virtual my_if vif2;
   /*在类中使用virtual interface声明,就可以在main_phase中使用如下方式驱动其中的信号*/

   function new(string name = "my_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   

   /*config_tb机制,my_driver中引入get操作*/
   virtual function void build_phase(uvm_phase phase);
      /*引入build_phase,与main_phase一样,uvm启动后会自动执行build_phase,在new之后.main_phase之前,
      主要通过config_db的set和get传递一些数据*/

      super.build_phase(phase);
      /*在父类的build_phase中执行了一些操作,必须显示的执行调用
      build_phase不消耗仿真时间*/

      `uvm_info("my_driver","build_phase is called",UVM_LOW);
      if(!uvm_config_db#(virtual my_if)::get(this,"","vif1",vif))
         /*get的第四个参数表示把得到的interface传递给哪个my_driver成员变量,*/

         `uvm_fatal("my_driver","virtual interface must be set for vif!!!")
         /*uvm_fatal类似uvm_info,只有两个参数,第二个参数打印时会直接调用finish结束仿真,表示出现重大问题而无法继续,必须停止并检查*/
      if(!uvm_config_db#(int)::get(this,"","var_int",var_int)) 
         `uvm_fatal("my_driver","var_int must be set!!!")

      /*传递相同类型的不同数据*/
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif2", vif2))
         `uvm_fatal("my_driver", "virtual interface must be set for vif2!!!")
   endfunction

   extern virtual task main_phase(uvm_phase phase);
   extern task drive_one_pkt(my_transaction tr);

endclass

`define TOP top_tb
/*使用宏给DUT输入端赋值,避免从top_tb.clk变为top_tb.clk_inst.clk的修改
但如果clk为top_tb.clk_inst.clk,而rst_n变为top_tb.rst_inst.rst_n,则宏定义也无用
必须引入interface,来连接验证平台与DUT端口,即编写my_if.sv*/

task my_driver::main_phase(uvm_phase phase);
   //my_transaction tr;
   phase.raise_objection(this);
   /*加入objection机制防止仿真平台关闭,每个phase中,uvm会检查是否有objection被提起,有就等待其被撤销后停止仿真,没有就马上结束当前phase
   必须要放在第一个消耗仿真时间的语句之前,比如@(posedge top.clk),而dispaly不消耗仿真时间*/
   
   
   /*
   `uvm_info("my_driver", "main_phase is called", UVM_LOW)
   `TOP.rxd <= 8'b0; 
   `TOP.rx_dv <= 1'b0;
   while(!`TOP.rst_n)
      @(posedge `TOP.clk);
   for(int i = 0; i < 256; i++)begin
      @(posedge `TOP.clk);
      `TOP.rxd <= $urandom_range(0, 255);  
      `TOP.rx_dv <= 1'b1;
      `uvm_info("my_driver", "data is drived", UVM_LOW); //还有uvm_error\warning
      //$display("the full name of current component is: %s", get_full_name()); //driver在UVM树中的路径索引,插入任意地方即可得知当前节点的路径索引
   end
   */

   /*使用interface声明vif,改成该形式*/
   `uvm_info("my_driver", "main_phase is called", UVM_LOW)
   vif.data <= 8'b0; 
   vif.valid <= 1'b0;
   while(!vif.rst_n)
      @(posedge vif.clk);
   /*
   for(int i = 0; i < 256; i++)begin
      @(posedge vif.clk);
      vif.data <= $urandom_range(0, 255);  
      vif.valid <= 1'b1;
      `uvm_info("my_driver", "data is drived", UVM_LOW); //还有uvm_error\warning
      //$display("the full name of current component is: %s", get_full_name()); //driver在UVM树中的路径索引,插入任意地方即可得知当前节点的路径索引
   end
   @(posedge vif.clk);
   vif.valid <= 1'b0;
   */
   while(1)begin
      seq_item_port.try_next_item(req);
      if(req == null)
         @(posedge vif.clk);
      else begin
         drive_one_pkt(req);
         seq_item_port.item_done();
      end
   end

   /*先将tr随机化,通过drive_one_pkt任务将tr的内容驱动到DUT端口*/
   for(int i = 0; i < 2; i++) begin 
      req = new("req");
      assert(req.randomize() with {pload.size == 200;});
      drive_one_pkt(req);
   end
   repeat(5) @(posedge vif.clk);

   phase.drop_objection(this);
   /*加入objection机制防止仿真平台关闭,每个phase中,uvm会检查是否有objection被提起,有就等待其被撤销后停止仿真,没有就马上结束当前phase
   与raise_objection成对出现*/
endtask

/*
task my_driver::drive_one_pkt(my_transaction tr);
   bit [47:0] tmp_data;
   bit [7:0] data_q[$]; 
  
   //push dmac to data_q
   tmp_data = tr.dmac;
   for(int i = 0; i < 6; i++) begin
      data_q.push_back(tmp_data[7:0]);
      tmp_data = (tmp_data >> 8);
   end
   //push smac to data_q
   tmp_data = tr.smac;
   for(int i = 0; i < 6; i++) begin
      data_q.push_back(tmp_data[7:0]);
      tmp_data = (tmp_data >> 8);
   end
   //push ether_type to data_q
   tmp_data = tr.ether_type;
   for(int i = 0; i < 2; i++) begin
      data_q.push_back(tmp_data[7:0]);
      tmp_data = (tmp_data >> 8);
   end
   //push payload to data_q
   for(int i = 0; i < tr.pload.size; i++) begin
      data_q.push_back(tr.pload[i]);
   end
   //push crc to data_q
   tmp_data = tr.crc;
   for(int i = 0; i < 4; i++) begin
      data_q.push_back(tmp_data[7:0]);
      tmp_data = (tmp_data >> 8);
   end

   `uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
   repeat(3) @(posedge vif.clk);

   while(data_q.size() > 0) begin
      @(posedge vif.clk);
      vif.valid <= 1'b1;
      vif.data <= data_q.pop_front(); 
   end

   @(posedge vif.clk);
   vif.valid <= 1'b0;
   `uvm_info("my_driver", "end drive one pkt", UVM_LOW);
endtask
*/

/*引入field_automation机制*/
task my_driver::drive_one_pkt(my_transaction tr);
   byte unsigned     data_q[];
   int  data_size;
   
   data_size = tr.pack_bytes(data_q) / 8; 
   `uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
   repeat(3) @(posedge vif.clk);
   for ( int i = 0; i < data_size; i++ ) begin
      @(posedge vif.clk);
      vif.valid <= 1'b1;
      vif.data <= data_q[i]; 
   end

   @(posedge vif.clk);
   vif.valid <= 1'b0;
   `uvm_info("my_driver", "end drive one pkt", UVM_LOW);
endtask
`endif
