`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2023 07:39:50 PM
// Design Name: 
// Module Name: M0_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// `ifdef K325T
// `else
//     `include "/home/ICer/my_ic/wild_fire/src/rtl/000.my_m0_0macro/AHBLITE_SYS.v"
//     `include "/home/ICer/my_ic/wild_fire/src/glbl/fsdb.v"
//     
// `endif
`include "/home/ICer/my_ic/project/wild_fire/src/rtl/000.my_m0_0macro/vcs_define_macro.v"
module M0_tb ();
    parameter ADC_Daisy_chain_M = 8;
    parameter ADC_DCN = 8;
    reg                                     sys_clk;
    reg                                     sys_rst_n;
    reg     [3:0]                           key;
    wire    [7:0]                           led;
    reg                                     rx;
    wire                                    tx;
	
    // wire                                    SCLK;
    // wire                                    MOSI;
    // reg                                     DRDYOUT;
    // reg                                     MISO;
    // wire                                    CS;
    // wire                                    adc_to_fifo_wen_hp;
    // wire  [32-1:0]                          adc_to_fifo_wdata;
    // wire                                    adc_frame_flag_hp;

    reg  [ADC_Daisy_chain_M-1:0]       DRDYOUT;
    wire [ADC_Daisy_chain_M-1:0]       SCLK;
    wire [ADC_Daisy_chain_M-1:0]       MOSI;
    reg  [ADC_Daisy_chain_M-1:0]       MISO;
    wire [ADC_Daisy_chain_M-1:0]       CS;
    wire [ADC_Daisy_chain_M-1:0]       adc_to_fifo_wen_hp;
    wire [ADC_Daisy_chain_M * 8-1:0]   adc_to_fifo_wdata;
    wire [ADC_Daisy_chain_M-1:0]       adc_frame_flag_h;  
    wire [ADC_Daisy_chain_M * 8-1:0]   fifo_frame_dep_cnt_time_andfremecnt;
    reg                                external_module_rd_clk;

    AHBLITE_SYS#(
        .ADC_Daisy_chain_M(ADC_Daisy_chain_M),
        .ADC_DCN(ADC_DCN)) 
    AHBLITE_SYS_U1(
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key(key),
        .led(led),
        .DRDYOUT(DRDYOUT),
        .SCLK(SCLK),
        .MOSI(MOSI),
        .MISO(MISO),
        .CS(CS),
        .adc_to_fifo_wen_hp(adc_to_fifo_wen_hp),
        .adc_to_fifo_wdata(adc_to_fifo_wdata),
        .adc_frame_flag_h(adc_frame_flag_h),
        .fifo_frame_dep_cnt_time_andfremecnt(fifo_frame_dep_cnt_time_andfremecnt),
        .external_module_rd_clk(external_module_rd_clk),
        .rx(rx),
        .tx(tx)
    );
    initial begin
        DRDYOUT = 8'b1111_1111; 
        # 35000; 
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 8000; 
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 8000; 
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 30000; 
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 10000; 
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 10000; 
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 30000; 
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000; 
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000;
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000;
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000;

        DRDYOUT = 8'b1111_1111;
        # 500;
        DRDYOUT = 8'b1111_1110;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 500;
        DRDYOUT = 8'b1111_1101;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 50000;
        DRDYOUT = 8'b1111_1011;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 500;
        DRDYOUT = 8'b1111_0111;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 500;
        DRDYOUT = 8'b1110_1111;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 500;
        DRDYOUT = 8'b1101_1111;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 5000;
        DRDYOUT = 8'b1011_1111;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 500;
        DRDYOUT = 8'b1111_1111;
        # 5000;
        DRDYOUT = 8'b1111_1010;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 500;
        DRDYOUT = 8'b1111_1110;
        # 50;

        DRDYOUT = 8'b1111_1111;
        # 100000;
        DRDYOUT = 8'b1111_1111;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000;
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000;
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000;
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000;
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000;
        DRDYOUT =8'b0000_0000;
        # 50;
        DRDYOUT = 8'b1111_1111;
        # 100000;
        
    end

    always  #20 MISO = {$random}%256;        
    always  #10 sys_clk = ~sys_clk;
    always  #4 external_module_rd_clk = ~external_module_rd_clk;
    
    initial begin
        sys_clk = 0;
        external_module_rd_clk = 0;
        sys_rst_n = 0;
        key = 4'b1111;
        rx = 1'b1;
        # 100;
        sys_rst_n = 1;
    end

    always # 100000 $display("simulation have done %d us",$time/1000);


    fsdb #(.finishtime(1200000)) fsdb_u();


endmodule
