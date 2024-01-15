
module read_fifo_to_external_module #(
    parameter ADC_Daisy_chain_M = 2
)(
    input    wire                                           sys_rst_n                                ,
    input    wire                                           wd_clk                                   ,
    input    wire                                           rd_clk                                   ,
    input    wire    [ADC_Daisy_chain_M * 8-1:0]            fifo_frame_dep_cnt_time_andfremecnt      ,   // async read fifo dep cnt
    input    wire    [ADC_Daisy_chain_M-1:0]                adc_frame_flag_h                         ,   // async adc_frame_flag_hp_d0 

    output   reg     [ADC_Daisy_chain_M-1:0]                read_fifo_to_module_ren_hp               ,   // read more one fifo en_hp
    input    wire    [ADC_Daisy_chain_M-1:0]                read_fifo_to_module_data_valid_hp        ,   // read out data valid from some fifo 
    input    wire    [ADC_Daisy_chain_M * 32-1:0]           read_fifo_to_module_datain               ,   // read in [31:0] data out from some fifo

    output   reg                                            adc_fifo_module_data_valid_hp            ,   // take out data valid hp
    output   reg     [31:0]                                 adc_fifo_module_dataout                  ,   // take out data to external_module

    input    wire    [ADC_Daisy_chain_M-1 :0]               fifo_state_empty                         ,   // fifo state in
    output   reg                                            adc_fifo_module_data_state_empty         ,   // all adc fifo _state out
    output   reg                                            adc_fifo_module_data_state_full          ,   // all adc fifo _state out
    output   reg                                            sync_adc_fifo_module_frame_finish_flag_h      
);


    reg adc_read_fifo_start_h;
    reg adc_fifo_module_frame_finish_flag_h;
    reg [7:0] add_time_to_module_cnt;
    reg [31:0] adc_chain_frame_diff_time [ADC_Daisy_chain_M-1:0];
    reg [7:0] adc_fifo_dep_cnt;
    reg [ADC_Daisy_chain_M-1:0]  adc_chain_one_hot;
    reg adc_fifo_module_frame_finish_flag_hp_r0;
    wire adc_fifo_module_frame_finish_flag_hp;
    // reg [7:0] sync_one_fifo_frame_dep_cnt;
    reg [7:0] sync_fifo_frame_dep_cnt_time_andfremecnt_wire;
    //sync fifo_flag_hp
    reg [ADC_Daisy_chain_M-1:0]  sync_adc_frame_flag_hp_r0,sync_adc_frame_flag_hp_r1,sync_adc_frame_flag_hp_r2;
    wire [ADC_Daisy_chain_M-1:0]  sync_adc_frame_flag_hp;
    genvar gi1;
    generate
        for(gi1=0; gi1 < ADC_Daisy_chain_M; gi1=gi1+1) begin: gi1_module
            always @ (posedge rd_clk or negedge sys_rst_n) begin
                if(!sys_rst_n) begin
                    sync_adc_frame_flag_hp_r0[gi1]      <=  'd0;
                    sync_adc_frame_flag_hp_r1[gi1]      <=  'd0;
                    sync_adc_frame_flag_hp_r2[gi1]      <=  'd0;
                end
                else begin
                    sync_adc_frame_flag_hp_r0[gi1]      <=  adc_frame_flag_h[gi1];
                    sync_adc_frame_flag_hp_r1[gi1]      <=  sync_adc_frame_flag_hp_r0 [gi1];
                    sync_adc_frame_flag_hp_r2[gi1]      <=  sync_adc_frame_flag_hp_r1 [gi1];
                end
            end
            assign sync_adc_frame_flag_hp[gi1] = (sync_adc_frame_flag_hp_r1[gi1]) && (~sync_adc_frame_flag_hp_r2[gi1]);
        end
    endgenerate

    //sync fifo_dep_cnt
    reg [ADC_Daisy_chain_M * 8-1:0] sync_fifo_frame_dep_cnt_time_andfremecnt;
    genvar i;
    generate
        for(i=0; i < ADC_Daisy_chain_M; i=i+1) begin:gi0_modulle
            always @ (posedge rd_clk or negedge sys_rst_n) begin
                if(!sys_rst_n) begin
                    sync_fifo_frame_dep_cnt_time_andfremecnt[8*(i+1)-1:8*i]   <=  'd0;
                end
                else if(sync_adc_frame_flag_hp[i] && (adc_chain_frame_diff_time[i][31:0] == 'd0)) begin
                    sync_fifo_frame_dep_cnt_time_andfremecnt[8*(i+1)-1:8*i]   <=  fifo_frame_dep_cnt_time_andfremecnt[8*(i+1)-1:8*i];
                end
                else begin
                    sync_fifo_frame_dep_cnt_time_andfremecnt[8*(i+1)-1:8*i]   <= sync_fifo_frame_dep_cnt_time_andfremecnt[8*(i+1)-1:8*i];
                end
            end
        end
    endgenerate



    // all adc finish write fifo 
    reg [ADC_Daisy_chain_M -1:0] adc_finish_h;
    genvar gi3;
    generate
        for(gi3=0; gi3 < ADC_Daisy_chain_M; gi3=gi3+1) begin : gi3_module
            always @ (posedge rd_clk or negedge sys_rst_n) begin
                if(!sys_rst_n) begin
                    adc_finish_h[gi3]   <=  'd0;
                end
                else if(sync_adc_frame_flag_hp[gi3] && adc_fifo_module_frame_finish_flag_h) begin
                    adc_finish_h[gi3]   <=  'd1;
                end
                else if(adc_read_fifo_start_h) begin
                    adc_finish_h[gi3]   <=  'd0;
                end
                else begin
                    adc_finish_h[gi3]   <= adc_finish_h[gi3];
                end
            end
        end
    endgenerate


    // adc_chain_diff_time 
    genvar k;
    generate
        for(k=0; k < ADC_Daisy_chain_M; k=k+1) begin: adc_fifo_module_frame
            always @ (posedge rd_clk or negedge sys_rst_n) begin
                if(!sys_rst_n ) begin
                    adc_chain_frame_diff_time[k]   <=  'd0;
                end
                else if(adc_finish_h[k]) begin
                    adc_chain_frame_diff_time [k] <=  adc_chain_frame_diff_time [k] + 1'b1;
                end
                else if(adc_fifo_module_frame_finish_flag_hp)begin
                    adc_chain_frame_diff_time[k]   <=  'd0;
                end
                else begin
                    adc_chain_frame_diff_time [k] <=  adc_chain_frame_diff_time [k];
                end
            end
        end
    endgenerate
    
    // all adc finish write fifo and start read fifo
    genvar gi2;
    generate
        for(gi2=0; gi2 < ADC_Daisy_chain_M; gi2=gi2+1) begin: gi2_module
            always @ (posedge rd_clk or negedge sys_rst_n) begin
                if(!sys_rst_n) begin
                    adc_read_fifo_start_h <= 1'b0; 
                end
                else if(&adc_finish_h) begin  
                    adc_read_fifo_start_h <= 1'b1;
                end
                else if(!(|adc_chain_one_hot)) begin
                    adc_read_fifo_start_h <= 1'b0;
                end
                else begin
                    adc_read_fifo_start_h <= adc_read_fifo_start_h;
                end
            end
        end
    endgenerate

    reg adc_read_fifo_start_hp_r0;
    wire adc_read_fifo_start_hp,adc_read_fifo_start_lp;
    always @ (posedge rd_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            adc_read_fifo_start_hp_r0 <= 1'b0; 
        end
        else begin  
            adc_read_fifo_start_hp_r0 <= adc_read_fifo_start_h;
        end
    end
    assign  adc_read_fifo_start_hp = (~adc_read_fifo_start_hp_r0) && (adc_read_fifo_start_h);
    assign  adc_read_fifo_start_lp = (adc_read_fifo_start_hp_r0) && (~adc_read_fifo_start_h);

    always @ (posedge rd_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            adc_fifo_module_frame_finish_flag_hp_r0 <= 1'b0; 
        end
        else begin  
            adc_fifo_module_frame_finish_flag_hp_r0 <=     adc_fifo_module_frame_finish_flag_h;
        end
    end
    assign  adc_fifo_module_frame_finish_flag_hp = (~adc_fifo_module_frame_finish_flag_hp_r0) && (adc_fifo_module_frame_finish_flag_h);

    //to chose one fifo
    //read fifo cnt 
    //read fifo en_hp
    always @ (posedge rd_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            adc_chain_one_hot <= 'd0; 
        end
        else if(adc_read_fifo_start_hp) begin
            adc_chain_one_hot <= 'd1; 
        end
        else if((adc_fifo_dep_cnt == sync_fifo_frame_dep_cnt_time_andfremecnt_wire)) begin
            adc_chain_one_hot <= adc_chain_one_hot * 2;
        end
        else if(adc_fifo_module_frame_finish_flag_hp)begin
            adc_chain_one_hot <= 'd0; 
        end  
        else begin
            adc_chain_one_hot <= adc_chain_one_hot;
        end
    end
    // sel sync one fifo frame_dep_cnt
    reg [31:0] adc_fifo_module_dataout_wire;
    reg read_fifo_to_module_data_valid_hp_wire;
    
    genvar gi4;
    generate
        for (gi4 =0; gi4 < ADC_Daisy_chain_M; gi4=gi4+1) begin :gi4_module
            always @ (*) begin 
                if(!sys_rst_n) begin
                    sync_fifo_frame_dep_cnt_time_andfremecnt_wire = 'd0;
                    // sync_one_fifo_frame_dep_cnt = 'd0;
                    adc_fifo_module_dataout_wire = 'd0;
                    read_fifo_to_module_data_valid_hp_wire = 'd0;
                end
                else if(adc_chain_one_hot[gi4] == 1'b1) begin
                    // sync_one_fifo_frame_dep_cnt = sync_fifo_frame_dep_cnt_time_andfremecnt[8*(gi4+1):8*gi4];
                    sync_fifo_frame_dep_cnt_time_andfremecnt_wire   =  sync_fifo_frame_dep_cnt_time_andfremecnt[8*(gi4+1)-1:8*gi4]/4;
                    adc_fifo_module_dataout_wire = read_fifo_to_module_datain[(gi4+1)*32-1:gi4*32];
                    read_fifo_to_module_data_valid_hp_wire = read_fifo_to_module_data_valid_hp[gi4];
                end
                else begin 
                    // sync_one_fifo_frame_dep_cnt = sync_one_fifo_frame_dep_cnt;
                    adc_fifo_module_dataout_wire = adc_fifo_module_dataout_wire;
                end
            end
        end
    endgenerate

    reg or_adc_chain_one_hot_wire_d0;
    always @ (posedge rd_clk or negedge sys_rst_n) begin 
        if(!sys_rst_n) begin
            or_adc_chain_one_hot_wire_d0<='d0;
        end
        else begin
            or_adc_chain_one_hot_wire_d0<= |adc_chain_one_hot;
        end
    end

    always @ (posedge rd_clk or negedge sys_rst_n) begin 
        if(!sys_rst_n) begin
            adc_fifo_dep_cnt  <= 'd0;
            adc_fifo_module_dataout <= 'd0;
            adc_fifo_module_data_valid_hp <='d0;
            add_time_to_module_cnt<= ADC_Daisy_chain_M;
            adc_fifo_module_frame_finish_flag_h <= 'd1; 
        end
        else if(or_adc_chain_one_hot_wire_d0) begin
            add_time_to_module_cnt<= 'd0;
            adc_fifo_module_frame_finish_flag_h <= 'd0; 
            if((adc_fifo_dep_cnt < sync_fifo_frame_dep_cnt_time_andfremecnt_wire)&&(read_fifo_to_module_data_valid_hp_wire)) begin
                adc_fifo_dep_cnt <= adc_fifo_dep_cnt + 1'b1;
                adc_fifo_module_dataout <= adc_fifo_module_dataout_wire;
                adc_fifo_module_data_valid_hp <='d1;
            end
            else begin
                adc_fifo_dep_cnt <= 'd0;
                adc_fifo_module_dataout <= adc_fifo_module_dataout_wire;
                adc_fifo_module_data_valid_hp <='d0;
            end
        end
        else begin
            if (add_time_to_module_cnt <= ADC_Daisy_chain_M) begin
                add_time_to_module_cnt <= add_time_to_module_cnt + 1'b1;
                case(add_time_to_module_cnt) 
                    'd 0: begin adc_fifo_module_dataout <= adc_fifo_module_dataout;                adc_fifo_module_data_valid_hp <='d0; end
                    'd 1: begin adc_fifo_module_dataout <= adc_chain_frame_diff_time[0][31:0];     adc_fifo_module_data_valid_hp <='d1; end
                    'd 2: begin adc_fifo_module_dataout <= adc_chain_frame_diff_time[1][31:0];     adc_fifo_module_data_valid_hp <='d1; end
                    'd 3: begin adc_fifo_module_dataout <= adc_chain_frame_diff_time[2][31:0];     adc_fifo_module_data_valid_hp <='d1; end
                    'd 4: begin adc_fifo_module_dataout <= adc_chain_frame_diff_time[3][31:0];     adc_fifo_module_data_valid_hp <='d1; end
                    'd 5: begin adc_fifo_module_dataout <= adc_chain_frame_diff_time[4][31:0];     adc_fifo_module_data_valid_hp <='d1; end
                    'd 6: begin adc_fifo_module_dataout <= adc_chain_frame_diff_time[5][31:0];     adc_fifo_module_data_valid_hp <='d1; end
                    'd 7: begin adc_fifo_module_dataout <= adc_chain_frame_diff_time[6][31:0];     adc_fifo_module_data_valid_hp <='d1; end
                    'd 8: begin adc_fifo_module_dataout <= adc_chain_frame_diff_time[7][31:0];     adc_fifo_module_data_valid_hp <='d1; end
                    default: begin adc_fifo_module_dataout <= adc_fifo_module_dataout;             adc_fifo_module_data_valid_hp <='d0; end
                endcase  
            end
            else begin
                adc_fifo_module_frame_finish_flag_h <= 'd1; 
                adc_fifo_module_dataout <= adc_fifo_module_dataout; 
                adc_fifo_module_data_valid_hp <='d0;
                add_time_to_module_cnt<= add_time_to_module_cnt;
            end
        end
    end

    assign read_fifo_to_module_ren_hp = adc_chain_one_hot;

    reg sync_adc_fifo_module_frame_finish_flag_h_d0;
    reg sync_adc_fifo_module_frame_finish_flag_h_d1;
    always @(posedge wd_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
          sync_adc_fifo_module_frame_finish_flag_h_d0      <=  'd0;
          sync_adc_fifo_module_frame_finish_flag_h_d1      <=  'd0;
          sync_adc_fifo_module_frame_finish_flag_h         <=  'd0;
        end
        else begin
          sync_adc_fifo_module_frame_finish_flag_h_d0      <=  adc_fifo_module_frame_finish_flag_h;
          sync_adc_fifo_module_frame_finish_flag_h_d1      <=  sync_adc_fifo_module_frame_finish_flag_h_d0;
          sync_adc_fifo_module_frame_finish_flag_h         <=  sync_adc_fifo_module_frame_finish_flag_h_d1;
        end
    end
endmodule