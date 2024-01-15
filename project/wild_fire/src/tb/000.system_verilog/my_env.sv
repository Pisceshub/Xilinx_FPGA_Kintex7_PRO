`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;
    my_driver drv;

    /*
    my_monitor i_mon;
    my_monitor o_mon;
    */
    my_agent i_agt;
    my_agent o_agt;
    my_model  mdl;
    my_scoreboard scb;

    //定义一个fifo,并在build_phase中实例化
    uvm_tlm_analysis_fifo #(my_transaction) agt_mdl_fifo;
    uvm_tlm_analysis_fifo #(my_transaction) agt_scb_fifo;
    uvm_tlm_analysis_fifo #(my_transaction) mdl_scb_fifo;

    function new(string name = "my_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        /*factory机制,只有使用该机制注册过的类才能使用这种方法实例化,以后都是这种方式
        传入drv名字,和this指针,表示my_env*/
        drv = my_driver::type_id::create("my_drv",this);   
        /*
        i_mon = my_monitor::type_id::create("i_mon",this); //用于监测输入
        o_mon = my_monitor::type_id::create("o_mon",this); //用于监测输出
        */
        /*有agent就不需要以上方式了*/
        i_agt = my_agent::type_id::create("i_agt", this);
        o_agt = my_agent::type_id::create("o_agt", this);
        i_agt.is_active = UVM_ACTIVE;
        o_agt.is_active = UVM_PASSIVE;

        mdl = my_model::type_id::create("mdl", this);
        scb = my_scoreboard::type_id::create("scb", this);

        agt_scb_fifo = new("agt_scb_fifo", this);
        agt_mdl_fifo = new("agt_mdl_fifo", this);
        mdl_scb_fifo = new("mdl_scb_fifo", this);

        //使用default_sequence来启动equence
        uvm_config_db#(uvm_object_wrapper)::set(this,
                                                "i_agt.sqr.main_phase",
                                                "default_sequence",
                                                my_sequence::type_id::get());
    endfunction //new()

    extern virtual function void connect_phase(uvm_phase phase);


    `uvm_component_utils(my_env)

endclass //my_env 

function void my_env::connect_phase(uvm_phase phase);//在build_phase执行完后马上执行.先执行driver,和monitor的connect_phase,再执行agent的connect_phase,最后env中的connect_phase
   super.connect_phase(phase);
   i_agt.ap.connect(agt_mdl_fifo.analysis_export);
   mdl.port.connect(agt_mdl_fifo.blocking_get_export);
   
   mdl.ap.connect(mdl_scb_fifo.analysis_export);
   scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
   o_agt.ap.connect(agt_scb_fifo.analysis_export);
   scb.act_port.connect(agt_scb_fifo.blocking_get_export); 
endfunction

task my_env::main_phase(uvm_phase phase);
   my_sequence seq;
   phase.raise_objection(this);
   seq = my_sequence::type_id::create("seq");
   seq.start(i_agt.sqr); 
   phase.drop_objection(this);
endtask
`endif
