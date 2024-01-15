//////////////////////////////////////////////////////////////////////////////////
//END USER LICENCE AGREEMENT                                                    //
//                                                                              //
//Copyright (c) 2012, ARM All rights reserved.                                  //
//                                                                              //
//THIS END USER LICENCE AGREEMENT (鎻旾CENCE?) IS A LEGAL AGREEMENT BETWEEN      //
//YOU AND ARM LIMITED ("ARM") FOR THE USE OF THE SOFTWARE EXAMPLE ACCOMPANYING  //
//THIS LICENCE. ARM IS ONLY WILLING TO LICENSE THE SOFTWARE EXAMPLE TO YOU ON   //
//CONDITION THAT YOU ACCEPT ALL OF THE TERMS IN THIS LICENCE. BY INSTALLING OR  //
//OTHERWISE USING OR COPYING THE SOFTWARE EXAMPLE YOU INDICATE THAT YOU AGREE   //
//TO BE BOUND BY ALL OF THE TERMS OF THIS LICENCE. IF YOU DO NOT AGREE TO THE   //
//TERMS OF THIS LICENCE, ARM IS UNWILLING TO LICENSE THE SOFTWARE EXAMPLE TO    //
//YOU AND YOU MAY NOT INSTALL, USE OR COPY THE SOFTWARE EXAMPLE.                //
//                                                                              //
//ARM hereby grants to you, subject to the terms and conditions of this Licence,//
//a non-exclusive, worldwide, non-transferable, copyright licence only to       //
//redistribute and use in source and binary forms, with or without modification,//
//for academic purposes provided the following conditions are met:              //
//a) Redistributions of source code must retain the above copyright notice, this//
//list of conditions and the following disclaimer.                              //
//b) Redistributions in binary form must reproduce the above copyright notice,  //
//this list of conditions and the following disclaimer in the documentation     //
//and/or other materials provided with the distribution.                        //
//                                                                              //
//THIS SOFTWARE EXAMPLE IS PROVIDED BY THE COPYRIGHT HOLDER "AS IS" AND ARM     //
//EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING     //
//WITHOUT LIMITATION WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR //
//PURPOSE, WITH RESPECT TO THIS SOFTWARE EXAMPLE. IN NO EVENT SHALL ARM BE LIABLE/
//FOR ANY DIRECT, INDIRECT, INCIDENTAL, PUNITIVE, OR CONSEQUENTIAL DAMAGES OF ANY/
//KIND WHATSOEVER WITH RESPECT TO THE SOFTWARE EXAMPLE. ARM SHALL NOT BE LIABLE //
//FOR ANY CLAIMS, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, //
//TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE    //
//EXAMPLE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE EXAMPLE. FOR THE AVOIDANCE/
// OF DOUBT, NO PATENT LICENSES ARE BEING LICENSED UNDER THIS LICENSE AGREEMENT.//
//////////////////////////////////////////////////////////////////////////////////

// `include "vcs_define_macro.v"
// `include "/home/ICer/my_ic/project/wild_fire/src/rtl/000.my_m0_0macro/vcs_define_macro.v"
`include "/home/ICer/my_ic/project/wild_fire/src/rtl/000.my_m0_0macro/bord_define_macro.v"
module AHBLITE_SYS#( 
	parameter  ADC_Daisy_chain_M = 1,
	parameter ADC_DCN = 8
)(
	//CLOCKS & RESET
	input		wire				    sys_clk,
	input		wire				    sys_rst_n,  

	output 		reg 	    [7:0] 		led,
	input		wire	    [3:0]		key,

	// SEG
	`ifdef SEG_MODULE
		//TO BOARD SEG
		output  	wire    [6:0]   	seg,
		output 		wire 	[7:0]   	an,
		output  	wire 				dp,
	`endif 
	
	`ifdef ETH_MDIO_MODULE
		output         eth1_rst_n, //以太网芯片复位信号，低电平有效  
		output         eth1_mdc  , //PHY管理接口的时钟信号
    	inout          eth1_mdio , //PHY管理接口的双向数据信号
	`endif 
	`ifdef ETH_UDP_LOOP_MODULE
	    //PL以太网RGMII接口 
    	input              eth1_rxc   , //RGMII接收数据时钟
    	input              eth1_rxc_ctl, //RGMII输入数据有效信号
    	input       [3:0]  eth1_rxd   ,  //RGMII输入数据
    	output             eth1_txc   ,  //RGMII发送数据时钟        
    	output             eth1_txc_ctl, //RGMII输出数据有效信号
    	output      [3:0]  eth1_txd   ,  //RGMII输出数据        
	`endif

	`ifdef ADC_MODULE
	  	// input  	wire         		DRDYOUT,
      	// output 	wire         		SCLK,
      	// output 	wire         		MOSI,
      	// input  	wire         		MISO,
      	// output 	wire         		CS,
      	// output 	wire         		adc_to_fifo_wen_hp, 
      	// output 	wire  [32-1:0]  	adc_to_fifo_wdata, 
      	// output 	wire         		adc_frame_flag_hp,  
		input  wire [ADC_Daisy_chain_M-1:0]       DRDYOUT,
		output wire [ADC_Daisy_chain_M-1:0]       SCLK,
		output wire [ADC_Daisy_chain_M-1:0]       MOSI,
		input  wire [ADC_Daisy_chain_M-1:0]       MISO,
		output wire [ADC_Daisy_chain_M-1:0]       CS,
		output wire [ADC_Daisy_chain_M-1:0]       adc_to_fifo_wen_hp, 
		output wire [ADC_Daisy_chain_M * 8-1:0]  adc_to_fifo_wdata,
		output wire [ADC_Daisy_chain_M * 8-1:0]   fifo_frame_dep_cnt_time_andfremecnt, 
		input  wire                               external_module_rd_clk,
		output wire [ADC_Daisy_chain_M-1:0]       adc_frame_flag_h,   
	`endif
	//TO BOARD UART
	`ifdef UART_MODULE
		input	wire				rx,
		output	wire				tx
	`endif

);

	//AHB-LITE SIGNALS 
	//Gloal Signals
	wire 			HCLK;
	wire 			HRESETn;
	//Address, Control & Write Data Signals
	wire [31:0]		HADDR;
	wire [31:0]		HWDATA;
	wire 			HWRITE;
	wire [1:0] 		HTRANS;
	wire [2:0] 		HBURST;
	wire 			HMASTLOCK;
	wire [3:0] 		HPROT;
	wire [2:0] 		HSIZE;
	//Transfer Response & Read Data Signals
	wire [31:0] 	HRDATA;
	wire 			HRESP;
	wire 			HREADY;

	//SELECT SIGNALS
	wire [3:0] 		MUX_SEL;

	wire 			HSEL_MEM;
	wire            HSEL_NOMAP;
	//SLAVE READ DATA
	wire [31:0] 	HRDATA_MEM;

	//SLAVE HREADYOUT
	wire 			HREADYOUT_MEM;

	//CM0-DS Sideband signals
	wire 			LOCKUP;
	wire 			TXEV;
	wire 			SLEEPING;
	wire [15:0]		IRQ;
	
	//SYSTEM GENERATES NO ERROR RESPONSE
	assign 			HRESP = 1'b0;

	//CM0-DS INTERRUPT SIGNALS  
	wire   			KEY_Int;
	wire            TIMER_Int; 
	wire            UART_Int;
	assign 			IRQ = 
						{	13'b0000_0000_0000_0,
							UART_Int,
							TIMER_Int,
							KEY_Int};

	// 1 led
	`ifdef LED_MODULE
		(*mark_debug="true"*) wire [7:0] LED;
		assign led = LED;
		//SELECT SIGNALS
		wire 			HSEL_LED;
		//SLAVE READ DATA
		wire [31:0] 	HRDATA_LED;
		//SLAVE HREADYOUT
		wire 			HREADYOUT_LED;
	`endif 
	// 2 SEG
	`ifdef SEG_MODULE 
		wire [6:0] SEG;
		assign seg  = SEG; 
		wire [7:0] AN;
		assign an  = AN; 
		wire     DP;
		assign dp  = DP;

		//SELECT SIGNALS
		wire            HSEL_SEG7;
		//SLAVE READ DATA
		wire [31:0] 	HRDATA_SEG7;
		//SLAVE HREADYOUT
		wire 			HREADYOUT_SEG7;
	`else
		assign seg = 'd0; 
		assign an  = 'd0;
		assign dp  = 'd0;
	`endif 
	//3 BTN
	`ifdef BTN_NVIC_MODULE
		wire [3:0] 		KEY;
		assign 			KEY = key; 
		wire 			key_pulse;
		assign KEY_Int = key_pulse;
	`else 
		assign KEY_Int = 1'b0;
	`endif  

	//4 TIMER
	`ifdef TIMER_NVIC_MODULE 

		wire 			timer_pulse;
		assign TIMER_Int = timer_pulse;
	
		//SELECT SIGNALS
		wire            HSEL_TIMER;
		//SLAVE READ DATA
		wire [31:0] 	HRDATA_TIMER;
		//SLAVE HREADYOUT
		wire 			HREADYOUT_TIMER;

	`else 
		assign TIMER_Int = 1'b0;
	`endif 

	//5_UART
	`ifdef UART_MODULE 
		//SELECT SIGNALS
		wire            HSEL_UART;
		//SLAVE READ DATA
		wire [31:0] 	HRDATA_UART;
		//SLAVE HREADYOUT
		wire 			HREADYOUT_UART;

		wire 			uart_pulse;	
		assign UART_Int = uart_pulse;
	`else 
		assign UART_Int = 1'b0;
	`endif	
	//ADC
	`ifdef ADC_MODULE
		wire            HSEL_ADC;
		//SLAVE READ DATA
		wire [31:0] 	HRDATA_ADC;
		//SLAVE HREADYOUT
		wire 			HREADYOUT_ADC;
	`endif	
	
	//CLK_WIZ
	`ifdef SYS_CLK_WIZ
		wire eth_delay_200m_clk;
		sys_clk_wiz0 sys_clk_wiz_u
   		(
    		// Clock out ports
    		.clk_out2(eth_delay_200m_clk),     // output clk_out1
			.clk_out1(HCLK),
    		// Status and control signals
    		.reset(~sys_rst_n), // input reset
    		.locked(HRESETn),       // output locked
   			// Clock in ports
    		.clk_in1(sys_clk)   // input clk_in1
		);  
	`else
		assign HCLK = sys_clk;
		assign HRESETn = sys_rst_n;
	`endif	
	

	//AHBLite MASTER --> CM0-DS
	`ifdef M0_MODULE 
		CORTEXM0DS u_cortexm0ds (
			//Global Signals
			.HCLK        (HCLK),
			.HRESETn     (HRESETn),
			//Address, Control & Write Data	
			.HADDR       (HADDR[31:0]),
			.HBURST      (HBURST[2:0]),
			.HMASTLOCK   (HMASTLOCK),
			.HPROT       (HPROT[3:0]),
			.HSIZE       (HSIZE[2:0]),
			.HTRANS      (HTRANS[1:0]),
			.HWDATA      (HWDATA[31:0]),
			.HWRITE      (HWRITE),
			//Transfer Response & Read Data	
			.HRDATA      (HRDATA[31:0]),			
			.HREADY      (HREADY),					
			.HRESP       (HRESP),					

			//CM0 Sideband Signals
			.NMI         (1'b0),
			.IRQ         (IRQ[15:0]),
			.TXEV        (),
			.RXEV        (1'b0),
			.LOCKUP      (LOCKUP),
			.SYSRESETREQ (),
			.SLEEPING    ()
		);

		//Address Decoder 

		AHBDCD uAHBDCD (
			.HADDR(HADDR[31:0]),
			.HSEL_S0(HSEL_MEM),
			// led
			`ifdef LED_MODULE
				.HSEL_S1(HSEL_LED),
			`else
				.HSEL_S1(),
			`endif

			//seg
			`ifdef SEG_MODULE 
				.HSEL_S2(HSEL_SEG7),
			`else
				.HSEL_S2(),
			`endif

			//timer
			`ifdef TIMER_NVIC_MODULE 
				.HSEL_S3(HSEL_TIMER),
			`else
				.HSEL_S3(),
			`endif	

			//uart
			`ifdef UART_MODULE
				.HSEL_S4(HSEL_UART),
			`else
				.HSEL_S4(),
			`endif	

			//ADC
			`ifdef ADC_MODULE
				.HSEL_S5(HSEL_ADC),
			`else
				.HSEL_S5(),
			`endif 
			.HSEL_S6(),
			.HSEL_S7(),
			.HSEL_S8(),
			.HSEL_S9(),
			.HSEL_NOMAP(HSEL_NOMAP),

			.MUX_SEL(MUX_SEL[3:0])
		);

		//Slave to Master Mulitplexor

		AHBMUX uAHBMUX (
			.HCLK(HCLK),
			.HRESETn(HRESETn),
			.MUX_SEL(MUX_SEL[3:0]),
			.HRDATA_S0(HRDATA_MEM),
			// led
			`ifdef LED_MODULE
				.HRDATA_S1(HRDATA_LED),
			`else
				.HRDATA_S1(),
			`endif
			//seg
			`ifdef SEG_MODULE 
				.HRDATA_S2(HRDATA_SEG7),
			`else
				.HRDATA_S2(),
			`endif

			//timer
			`ifdef TIMER_NVIC_MODULE 
				.HRDATA_S3(HRDATA_TIMER),
			`else
				.HRDATA_S3(),
			`endif

			//uart
			`ifdef UART_MODULE
				.HRDATA_S4(HRDATA_UART),
			`else
				.HRDATA_S4(),
			`endif	
			//ADC
			`ifdef ADC_MODULE
				.HRDATA_S5(HRDATA_ADC),
			`else
				.HRDATA_S5(),
			`endif
		
			.HRDATA_S6(),
			.HRDATA_S7(),
			.HRDATA_S8(),
			.HRDATA_S9(),
			.HRDATA_NOMAP(32'hDEADBEEF),


			.HREADYOUT_S0(HREADYOUT_MEM),
			// led
			`ifdef LED_MODULE
				.HREADYOUT_S1(HREADYOUT_LED),
			`else
				.HREADYOUT_S1(1'b1),
			`endif
			//seg
			`ifdef SEG_MODULE 
				.HREADYOUT_S2(HREADYOUT_SEG7),
			`else
				.HREADYOUT_S2(1'b1),
			`endif


			//timer
			`ifdef TIMER_NVIC_MODULE 
				.HREADYOUT_S3(HREADYOUT_TIMER),
			`else
				.HREADYOUT_S3(1'b1),
			`endif

			//uart
			`ifdef UART_MODULE
				.HREADYOUT_S4(HREADYOUT_UART),
			`else
				.HREADYOUT_S4(1'b1),
			`endif	
			
			//ADC
			`ifdef ADC_MODULE
				.HREADYOUT_S5(HREADYOUT_ADC),
			`else
				.HREADYOUT_S5(1'b1),
			`endif
			.HREADYOUT_S6(1'b1),
			.HREADYOUT_S7(1'b1),
			.HREADYOUT_S8(1'b1),
			.HREADYOUT_S9(1'b1),
			.HREADYOUT_NOMAP(1'b1),

			.HRDATA(HRDATA[31:0]),
			.HREADY(HREADY)
		);

		// AHBLite Peripherals


		//AHBLite Slave 
		AHB2MEM uAHB2MEM (
			//AHBLITE Signals
			.HSEL(HSEL_MEM),
			.HCLK(HCLK), 
			.HRESETn(HRESETn), 
			.HREADY(HREADY),     
			.HADDR(HADDR),
			.HTRANS(HTRANS[1:0]), 
			.HWRITE(HWRITE),
			.HSIZE(HSIZE),
			.HWDATA(HWDATA[31:0]), 

			.HRDATA(HRDATA_MEM), 
			.HREADYOUT(HREADYOUT_MEM)
			//Sideband Signals
		);
	`endif

	`ifdef LED_MODULE 
		//AHBLite Slave 
		AHB2LED uAHB2LED (
			//AHBLITE Signals
			.HSEL(HSEL_LED),
			.HCLK(HCLK), 
			.HRESETn(HRESETn), 
			.HREADY(HREADY),     
			.HADDR(HADDR),
			.HTRANS(HTRANS[1:0]), 
			.HWRITE(HWRITE),
			.HSIZE(HSIZE),
			.HWDATA(HWDATA[31:0]), 
			.HRDATA(HRDATA_LED), 
			.HREADYOUT(HREADYOUT_LED),
			//Sideband Signals
			.HLED(LED)
		);
	`endif

	`ifdef SEG_MODULE 
		AHB7SEGDEC AHB7SEGDEC_u1(
		    .HSEL     	(HSEL_SEG7)			,
		    .HCLK     	(HCLK)				,
		    .HRESETn  	(HRESETn)			,

		    .HREADY   	(HREADY)			,
		    .HADDR    	(HADDR)				,
		    .HTRANS   	(HTRANS[1:0])		,
		    .HWRITE   	(HWRITE)			,
		    .HSIZE    	(HSIZE)				,

		    .HWDATA   	(HWDATA[31:0])		,

		    .HREADYOUT	(HREADYOUT_SEG7)	,	
		    .HRADTA   	(HRDATA_SEG7)		,

		    .seg		(SEG)				,		
		    .an			(AN)				,		
		    .dp			(DP)					
		);
	`endif
	`ifdef BTN_NVIC_MODULE 
		key_filter#(.KEY_N(1)) 
		key_filter_u1(	
			.clk(HCLK),
			.rst_n(HRESETn),
			.key_in(KEY[0]),
			.key_pulse(key_pulse)
		);
	`endif
	`ifdef TIMER_NVIC_MODULE 
		AHBTIMER AHBTIMER_u(
    	  .HCLK(HCLK),
    	  .HRESETn(HRESETn),
    	  .HADDR(HADDR),
    	  .HWDATA(HWDATA),
    	  .HTRANS(HTRANS[1:0]),
    	  .HWRITE(HWRITE),
    	  .HSEL(HSEL_TIMER),
    	  .HREADY(HREADY),
    	  .HRDATA(HRDATA_TIMER),
    	  .HREADYOUT(HREADYOUT_TIMER),
    	  .timer_irq(timer_pulse)
  		);
  	`endif

	//uart
	`ifdef UART_MODULE
		AHBUART AHBUART_u(
			.HCLK(HCLK),
			.HRESETn(HRESETn),
			.HADDR(HADDR),
			.HTRANS(HTRANS),
			.HWDATA(HWDATA),
			.HWRITE(HWRITE),
			.HREADY(HREADY),
			.HREADYOUT(HREADYOUT_UART),
			.HRDATA(HRDATA_UART),
			.HSEL(HSEL_UART),
			.RsRx(rx), 
			.RsTx(tx), 
			.uart_irq(uart_pulse)
			); 
	`endif	
	//uart
	`ifdef ADC_MODULE
		AHB2ADC #(
    		.MEMWIDTH (10),// SIZE = 1KB = 256 Words
    		.ADC_Daisy_chain_M(ADC_Daisy_chain_M),
    		.ADC_DCN(ADC_DCN)
		)
		AHB2ADC_u(
			.HCLK(HCLK),
			.HRESETn(HRESETn),
			.HSEL(HSEL_ADC),
			.HREADY(HREADY),
			.HADDR(HADDR),
			.HTRANS(HTRANS),
			.HWRITE(HWRITE),
			.HSIZE(HSIZE),
			.HWDATA(HWDATA),
			.HREADYOUT(HREADYOUT_ADC),
			.HRDATA(HRDATA_ADC),
			.LED(),
			.DRDYOUT(DRDYOUT),
			.SCLK(SCLK),
			.MOSI(MOSI),
			.MISO(MISO),
			.CS(CS),
			.adc_to_fifo_wen_hp(adc_to_fifo_wen_hp),
			.adc_to_fifo_wdata(adc_to_fifo_wdata),
			.fifo_frame_dep_cnt_time_andfremecnt(fifo_frame_dep_cnt_time_andfremecnt), 
			.external_module_rd_clk(external_module_rd_clk),
			.adc_frame_flag_h(adc_frame_flag_h) 
			
		);
	`endif
			
	//mdio_test
	`ifdef ETH_MDIO_MODULE
		mdio_rw_test mdio_rw_test_u(
    		.sys_clk(HCLK)  ,
    		.sys_rst_n(HRESETn),
    		//MDIO接口
    		.eth_mdc(eth1_mdc)  , 	//PHY管理接口的时钟信号
    		.eth_mdio(eth1_mdio) , 	//PHY管理接口的双向数据信号
    		.eth_rst_n(eth1_rst_n), //以太网复位信号

    		.touch_key(key[1]), 	//触摸按键
    		.led(led[1:0])        	//LED连接速率指示
    	);
	`endif 


	//mdio_arp
	`ifdef ETH_ARP_MODULE
		eth_arp_test eth_arp_test_u(
    		.sys_clk(HCLK)   , 		//系统时钟
    		.sys_rst_n(HRESETn) , 	//系统复位信号。低电平有效 
    		.touch_key(key[2]) , 	//触摸按键。用于出发开发板ARP请求

			.eth_delay_200m_clk(eth_delay_200m_clk),
    		.eth_rxc(eth1_rxc)   , 	//RGMII接收数据时钟
    		.eth_rx_ctl(eth1_rx_ctl), //RGMII输入数据有效信号
    		.eth_rxd(eth1_rxd)   , //RGMII输入数据
    		.eth_txc(eth1_txc)   , //RGMII发送数据时钟      
    		.eth_tx_ctl(eth1_tx_ctl), //RGMII输出数据有效信号
    		.eth_txd(eth1_txd)   , 	  //RGMII输出数据          
    		.eth_rst_n(eth1_rst_n)    //以太网芯片复位信号，低电平有效  
    );
	`endif

	`ifdef ETH_UDP_LOOP_MODULE
		eth_udp_loop eth_udp_loop_u(
    		// .sys_clk(HCLK)   , //系统时钟
    		.sys_rst_n(HRESETn) , //系统复位信号，低电平有效 
			.eth_delayclk_200m(eth_delay_200m_clk),
    		.eth_rxc   (eth1_rxc   ), //RGMII接收数据时钟
    		.eth_rx_ctl(eth1_rxc_ctl), //RGMII输入数据有效信号
    		.eth_rxd   (eth1_rxd   ), //RGMII输入数据
    		.eth_txc   (eth1_txc   ), //RGMII发送数据时钟    
    		.eth_tx_ctl(eth1_txc_ctl), //RGMII输出数据有效信号
    		.eth_txd   (eth1_txd   ), //RGMII输出数据          
    		.eth_rst_n (eth1_rst_n ),  //以太网芯片复位信号，低电平有效  
			.udp_tx_done(led[2])
    	);
	`endif

endmodule
