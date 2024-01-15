//  --========================================================================--
//  Version and Release Control Information:
//
//  File Name           : AHB2MEM.v
//  File Revision       : 1.00
//
//  ----------------------------------------------------------------------------
//  Purpose             : Basic AHBLITE Internal Memory Default Size = 1KB
//                        
//  --========================================================================--
module AHB2ADC#(
    parameter MEMWIDTH = 10,// SIZE = 1KB = 256 Words
    parameter ADC_Daisy_chain_M = 1,
    parameter ADC_DCN = 8
)(
	//AHBLITE INTERFACE
		//Slave Select Signals
			input wire HSEL,
		//Global Signal
			input wire HCLK,
			input wire HRESETn,
		//Address, Control & Write Data
			input wire HREADY,
			input wire [31:0] HADDR,
			input wire [1:0] HTRANS,
			input wire HWRITE,
			input wire [2:0] HSIZE,
			
			input wire [31:0] HWDATA,
		// Transfer Response & Read Data
			output wire HREADYOUT,
			output wire [31:0] HRDATA,
	  //LED Output
			output wire [7:0] LED,
      input  wire [ADC_Daisy_chain_M-1:0]       DRDYOUT,
      output wire [ADC_Daisy_chain_M-1:0]       SCLK,
      output wire [ADC_Daisy_chain_M-1:0]       MOSI,
      input  wire [ADC_Daisy_chain_M-1:0]       MISO,
      output wire [ADC_Daisy_chain_M-1:0]       CS,
      output wire [ADC_Daisy_chain_M-1:0]       adc_to_fifo_wen_hp, 
      output wire [ADC_Daisy_chain_M * 8-1:0]   adc_to_fifo_wdata, 
      output wire [ADC_Daisy_chain_M * 8-1:0]   fifo_frame_dep_cnt_time_andfremecnt,
      input  wire                               external_module_rd_clk,
      output wire                               adc_fifo_module_data_valid_hp,
      output wire [31:0]                        adc_fifo_module_dataout,
      output wire [ADC_Daisy_chain_M-1:0]       adc_frame_flag_h 

);

  parameter WRCR_N = 8*ADC_DCN;       // 写配置ADC寄存器 MAX11040_WCR_OPEN  8bit * n
  parameter WDRCR_N = 16;             // 数据速率控制寄存器 0x0000 16bit
  parameter WSICR_N = 8*4*ADC_DCN;    // 采样及时控制寄存器 MAX11040_WSICR_PHI0 32*n

  // localparam ADC_CFGMEM_N = 16 + WDRCR_N + WSICR_N +WRCR_N;
  localparam ADC_CFGMEM_N = 352;
  // 16bit + 16bit + 8bit*4chenel* 8adc + 8bit *adc = 
  assign HREADYOUT = 1'b1; // Always ready

// Registers to store Adress Phase Signals
 
  reg APhase_HSEL;
  reg APhase_HWRITE;
  reg [1:0] APhase_HTRANS;
  reg [31:0] APhase_HADDR;
  reg [2:0] APhase_HSIZE;

    
  // localparam     WDRCR_N = 2;   short 高位16bit为采样数
  // localparam     WSICR_N = 4*adc_number; uint 
  // localparam     WCR_N = 1*adc_number;  char 两个32bit,用于配置启动ADC
  // ADC_CFG_MEM Array  ADC_Daisy_chain_M * ADC_DCN * (1 + N +1)

  
  reg [32 + ADC_Daisy_chain_M * ADC_CFGMEM_N-1  :0] ADC_CFG_MEM = 'd0; 
  // initial begin
  //   (*rom_style="block"*)	 $readmemh("/home/ICer/my_ic/wild_fire/src/flash/4_timer_nvic.hex", ADC_CFG_MEM);
  // end
  // Sample the Address Phase   
  always @(posedge HCLK or negedge HRESETn)
  begin
	  if(!HRESETn)
	  begin
		  APhase_HSEL <= 1'b0;
      APhase_HWRITE <= 1'b0;
      APhase_HTRANS <= 2'b00;
		  APhase_HADDR <= 32'h0;
		  APhase_HSIZE <= 3'b000;
	  end
    else if(HREADY)
    begin
      APhase_HSEL <= HSEL;
      APhase_HWRITE <= HWRITE;
      APhase_HTRANS <= HTRANS;
		  APhase_HADDR <= HADDR;
		  APhase_HSIZE <= HSIZE;
    end
  end

// Decode the bytes lanes depending on HSIZE & HADDR[1:0]

  wire tx_byte = ~APhase_HSIZE[1] & ~APhase_HSIZE[0];
  wire tx_half = ~APhase_HSIZE[1] &  APhase_HSIZE[0];
  wire tx_word =  APhase_HSIZE[1];
  
  wire byte_at_00 = tx_byte & ~APhase_HADDR[1] & ~APhase_HADDR[0];
  wire byte_at_01 = tx_byte & ~APhase_HADDR[1] &  APhase_HADDR[0];
  wire byte_at_10 = tx_byte &  APhase_HADDR[1] & ~APhase_HADDR[0];
  wire byte_at_11 = tx_byte &  APhase_HADDR[1] &  APhase_HADDR[0];
  
  wire half_at_00 = tx_half & ~APhase_HADDR[1];
  wire half_at_10 = tx_half &  APhase_HADDR[1];
  
  wire word_at_00 = tx_word;
  
  wire byte0 = word_at_00 | half_at_00 | byte_at_00;
  wire byte1 = word_at_00 | half_at_00 | byte_at_01;
  wire byte2 = word_at_00 | half_at_10 | byte_at_10;
  wire byte3 = word_at_00 | half_at_10 | byte_at_11;

// Writing to the ADC_CFG_MEM

// Student Assignment: Write a testbench & simulate to spot bugs in this ADC_CFG_MEM module

  always @(posedge HCLK)
  begin
	 if(APhase_HSEL & APhase_HWRITE & APhase_HTRANS[1])
	 begin
		if(byte0)
			ADC_CFG_MEM[(APhase_HADDR[MEMWIDTH:2]+1)*32-24-1-:8] <= HWDATA[7:0];
		if(byte1)
			ADC_CFG_MEM[(APhase_HADDR[MEMWIDTH:2]+1)*32-16-1-:8] <= HWDATA[15:8];
		if(byte2)
			ADC_CFG_MEM[(APhase_HADDR[MEMWIDTH:2]+1)*32-8-1-:8] <= HWDATA[23:16];
		if(byte3)
			ADC_CFG_MEM[(APhase_HADDR[MEMWIDTH:2]+1)*32-1-:8] <= HWDATA[31:24];
	  end
  end

  // Reading from memory 
  assign HRDATA = APhase_HSEL ? ADC_CFG_MEM[(APhase_HADDR[MEMWIDTH:2]+1)*32-1-:32]:HRDATA;
  // Diagnostic Signal out
  wire          zeroth_location = 0;
  assign LED =  ADC_CFG_MEM[(zeroth_location+1)*32-24-1-:8];


  wire                                  sync_adc_fifo_module_frame_finish_flag_h;
  wire  [ADC_Daisy_chain_M-1:0]         read_fifo_to_module_ren_hp;
  wire  [ADC_Daisy_chain_M-1:0]         read_fifo_to_module_data_valid_hp;
  wire  [ADC_Daisy_chain_M *32 -1:0]    read_fifo_to_module_datain;
  wire  [ADC_Daisy_chain_M-1:0]         fifo_state_empty;

  genvar i;
  generate 
    for(i = 0; i < ADC_Daisy_chain_M; i = i + 1) begin: adc_loop
    adc_chain #(
        .ADC_DCN(ADC_DCN),
        .ADC_CFGMEM_N(ADC_CFGMEM_N),
        .WDRCR_N(WDRCR_N), //数据速率控制寄存器 0x0000 16
        .WSICR_N(WSICR_N),  // 采样及时控制寄存器 MAX11040_WSICR_PHI0 32*n // 写配置ADC寄存器 MAX11040_WCR_OPEN  8*n
        .WRCR_N(WRCR_N))   
    ADC_U(
      .sys_clk(HCLK),
      .sys_rst_n(HRESETn),
      .ADC_WCFG_STATE(ADC_CFG_MEM[0]), 
      .ADC_RCFG_STATE(ADC_CFG_MEM[1]),
      .ADC_CFG(ADC_CFG_MEM[32 + ADC_CFGMEM_N * (i+1) -1 : 32 +  ADC_CFGMEM_N *i]), 
      .DRDYOUT_l(DRDYOUT[i]),
      .SCLK(SCLK[i]),
      .MOSI(MOSI[i]),
      .MISO(MISO[i]),
      .CS_l(CS[i]),
      .adc_to_fifo_wen_hp(adc_to_fifo_wen_hp[i]),
      .adc_to_fifo_wdata(adc_to_fifo_wdata[(i+1)*8 -1: i*8]),
      .fifo_frame_dep_cnt_time_andfremecnt(fifo_frame_dep_cnt_time_andfremecnt[(i+1)*8 -1: i*8]),
      .adc_fifo_module_frame_finish_flag_h(sync_adc_fifo_module_frame_finish_flag_h),
      .adc_frame_flag_h(adc_frame_flag_h[i])
      
    );


    fifo_async#(
        .read_data_width(32),
        .wirte_data_width(8),
        .data_depth(512),
        .addr_width(9))
    fifo_async_u
    (
        .sys_rst_n (HRESETn                                         ),
        .wr_clk    (HCLK                                            ),
        .wr_en     (adc_to_fifo_wen_hp[i]                           ),
        .din       (adc_to_fifo_wdata[(i+1)*8 -1: i*8]              ),      
        .rd_clk    (external_module_rd_clk                          ),  
        .rd_en     (read_fifo_to_module_ren_hp[i]                   ),
        .valid     (read_fifo_to_module_data_valid_hp[i]            ),
        .dout      (read_fifo_to_module_datain[(i+1)*32 -1 :i*32]   ),  
        .empty     (fifo_state_empty[i]                             ),
        .full      (                                                )
    );
    end
  endgenerate 


  read_fifo_to_external_module#(
    .ADC_Daisy_chain_M(ADC_Daisy_chain_M)
  ) 
  read_fifo_to_external_module_u(
     .sys_rst_n(HRESETn),
     .wd_clk(HCLK),
     .rd_clk(external_module_rd_clk),

     .fifo_frame_dep_cnt_time_andfremecnt(fifo_frame_dep_cnt_time_andfremecnt),
     .adc_frame_flag_h(adc_frame_flag_h),

     .read_fifo_to_module_ren_hp(read_fifo_to_module_ren_hp),           // read more one fifo en_hp
     .read_fifo_to_module_data_valid_hp(read_fifo_to_module_data_valid_hp),
     .read_fifo_to_module_datain(read_fifo_to_module_datain),           // read in [31:0] data out from some fifo
     
     .adc_fifo_module_data_valid_hp(adc_fifo_module_data_valid_hp),     //  data valid hp
     .adc_fifo_module_dataout(adc_fifo_module_dataout),                 // take out data to external_module
     .fifo_state_empty(fifo_state_empty),
     .adc_fifo_module_data_state_empty(), //adc_fifo_module_data_state_empty
     .adc_fifo_module_data_state_full(), //adc_fifo_module_data_state_full
     .sync_adc_fifo_module_frame_finish_flag_h(sync_adc_fifo_module_frame_finish_flag_h)
  );
 
endmodule
