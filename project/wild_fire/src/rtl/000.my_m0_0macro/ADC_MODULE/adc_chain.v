module adc_chain #(
    parameter ADC_DCN = 8,
    parameter DATA_WIDTH = 8,
    parameter ADC_CFGMEM_N = 352,
    parameter WRCR_N  = 64,      // 写配置ADC寄存器 MAX11040_WCR_OPEN  8bit * n
    parameter WDRCR_N = 16,     // 数据速率控制寄存器 0x0000 16
    parameter WSICR_N = 256    // 采样及时控制寄存器 MAX11040_WSICR_PHI0 32*n
)(
        //系统信号：
        input           wire                    sys_clk,
        input           wire                    sys_rst_n,
        input           wire                    ADC_WCFG_STATE,
        input           wire                    ADC_RCFG_STATE,
        input           wire   [351:0]          ADC_CFG,
        input           wire                    DRDYOUT_l,
        output          wire                    SCLK,
        output          wire                    MOSI,
        input           wire                    MISO,
        output          reg                     CS_l,
        output          wire                    adc_to_fifo_wen_hp, 
        output          wire  [31:0]            adc_to_fifo_wdata, 
        output          reg   [7:0]             fifo_frame_dep_cnt_time_andfremecnt,
        input           wire                    adc_fifo_module_frame_finish_flag_h,
        output          wire                    adc_frame_flag_h                 
);
        localparam CLK_TICK = 5_000;  //100us 一次
        // 分配数据 16bit采样数量 + 16 bit WDRCR速率控制  + 32*2bit 共 8bit * 8 WRCR 开关ADC + 8bit *4channel * ADCN WSICR_N每通道ADC偏移相位
        // 先WRCR开关ADC、再WDRCR速率控制、最后WSICR_N每通道ADC偏移相位
        // 15:0                      15:0
        wire [15:0] ADC_SAMPLE_NUMBER;
        assign ADC_SAMPLE_NUMBER    = ADC_CFG[15:0];
        // 15:0                      16+16-1:16       31:16
        wire [15:0] WDRCR_DATA;
        assign WDRCR_DATA           = ADC_CFG[31 : 16];

        // 63:0                      64+32-1:32       95:32
        wire [63:0] WRCR_DATA;
        assign WRCR_DATA            = ADC_CFG[95 : 32];
        
        // 255:0                     255 + 96-1       32 +64 + 256+ -1    :96   
        wire [255:0] WSICR_DATA;
        assign WSICR_DATA           = ADC_CFG[351 : 96];

        reg  whrl_reg_flag;
        wire cfg_r_start_h;
        wire rreg_busy_h;
        wire wreg_busy_h;
        //输入wr
        reg  wDRDYOUT_hp;
        reg  rDRDYOUT_hp;
        reg  wspi_finsh_h;
        reg  rspi_finsh_h;
        wire spi_finsh_h;
        //wr输出
        wire  wen_spi_hp;
        wire  ren_spi_hp;
        reg   en_spi_hp;
        wire  [7:0] wcfg_to_spi_datain;
        wire  [7:0] rcfg_to_spi_datain;
        reg  [7:0] cfg_to_spi_datain;
        wire  wCS_l;
        wire  rCS_l;
        wire [7:0] spi_dataout_to_rreg_datain;


        reg [15:0] clk_cnt_tick;
        reg clk_cnt_tick_hp;
        always @(posedge sys_clk or negedge sys_rst_n) begin
            if (!sys_rst_n) begin
                clk_cnt_tick <= 'd0;
                clk_cnt_tick_hp <= 'd0;
            end
            else if (clk_cnt_tick <= CLK_TICK - 1) begin
                clk_cnt_tick <= clk_cnt_tick +1'b1;
                clk_cnt_tick_hp <= 'd0;
            end
            else begin
                clk_cnt_tick_hp <= 'd1;
                clk_cnt_tick <= 'd0;
            end
        end
        // 写寄存器使能拉高、HSEL_ADC片选了ADC、帧计数为0、ADC_SAMPLE_NUMBER!=0
        reg ADC_WCFG_STATE_hl_r;
        reg cfg_w_start_h;
        always @(posedge sys_clk or negedge sys_rst_n) begin
            if (!sys_rst_n) begin
                ADC_WCFG_STATE_hl_r <= 1'b0;
                cfg_w_start_h <= 1'b0;
            end
            else  begin
                ADC_WCFG_STATE_hl_r <= ADC_WCFG_STATE;
                if(ADC_WCFG_STATE_hl_r ^ ADC_WCFG_STATE) begin
                   cfg_w_start_h <= ~cfg_w_start_h; 
                end
            end
        end
        
        reg adc_frame_flag_hp_r0;
        wire adc_frame_flag_hp;
        always @(posedge sys_clk or negedge sys_rst_n) begin
            if(!sys_rst_n) begin
                adc_frame_flag_hp_r0 <= 'd0;
            end
            else begin
                adc_frame_flag_hp_r0 <= adc_frame_flag_h;
            end  
        end
        assign adc_frame_flag_hp = (~adc_frame_flag_hp_r0)&&(adc_frame_flag_h);
        
        // 帧计数 ，复位、重新配置帧数复位
        reg [15:0] adc_frame_cnt;
        always @(posedge sys_clk or negedge sys_rst_n) begin
            if(!sys_rst_n || !cfg_r_start_h) begin
                adc_frame_cnt <= 'd0;
            end
            else if(adc_frame_flag_hp) begin
                adc_frame_cnt <= adc_frame_cnt + 1'b1;
            end  
        end
        
        //DRDYOUT_ln打两拍换脉冲用于配置控制
        reg  DRDYOUT_l_d0,DRDYOUT_l_d1;
        // reg  DRDYOUT_hp;
        always@(posedge sys_clk or negedge sys_rst_n) begin
            if(!sys_rst_n) begin
                DRDYOUT_l_d0 <= 1'b0;
                DRDYOUT_l_d1 <= 1'b0;
            end
            else begin
                DRDYOUT_l_d0 <= DRDYOUT_l;
                DRDYOUT_l_d1 <= DRDYOUT_l_d0;
            end
        end
        // assign DRDYOUT_hp = (~DRDYOUT_l_d0)&&(DRDYOUT_l_d1);
        
        always @(posedge sys_clk or negedge sys_rst_n) begin
            if(!sys_rst_n) begin
                whrl_reg_flag = 1'b1;
            end
            else if(cfg_r_start_h && !wreg_busy_h) begin
                whrl_reg_flag = 1'b0;
            end
            else begin
                whrl_reg_flag = 1'b1;
            end  
        end


        adc_chain_regcfg_w_max11040 #(.ADC_DCN(ADC_DCN))
        adc_chain_regcfg_w_max11040_u(
            .sys_clk(sys_clk),
            .sys_rst_n(sys_rst_n),
            .WRCR_DATA(WRCR_DATA),
            .WDRCR_DATA(WDRCR_DATA),
            .WSICR_DATA(WSICR_DATA),
            .cfg_w_en_h(cfg_w_start_h),
            .wreg_busy_h(wreg_busy_h),
            .DRDYOUT_hp(wDRDYOUT_hp),
            .wreg_to_spi_en_hp(wen_spi_hp),
            .wreg_to_spi_data(wcfg_to_spi_datain),
            .CS_l(wCS_l),
            .spi_to_wreg_finsh_h(wspi_finsh_h),
            .spi_to_wreg_datain(),
            .cfg_w_finsh_h(cfg_r_start_h)
        );

        adc_chain_regcfg_r_max11040 #(.ADC_DCN(ADC_DCN))
        adc_chain_regcfg_r_max11040_u(
            .sys_clk(sys_clk),
            .sys_rst_n(sys_rst_n),
            .ADC_SAMPLE_NUMBER(ADC_SAMPLE_NUMBER),
            .adc_frame_cnt(adc_frame_cnt),
            .cfg_r_en_h(cfg_r_start_h && ADC_RCFG_STATE),
            .DRDYOUT_hp(rDRDYOUT_hp),
            .rreg_to_spi_en_hp(ren_spi_hp),
            .rreh_to_spi_data(rcfg_to_spi_datain),
            .CS_l(rCS_l),
            .spi_to_rreg_finsh_h(rspi_finsh_h),
            .spi_to_rreg_datain(spi_dataout_to_rreg_datain),
            .rreg_busy_h(rreg_busy_h),
            .adc_to_fifo_wen_hp(adc_to_fifo_wen_hp),
            .adc_to_fifo_wdata(adc_to_fifo_wdata),
            .adc_frame_flag_h(adc_frame_flag_h),
            .fifo_frame_dep_cnt_time_andfremecnt(fifo_frame_dep_cnt_time_andfremecnt),
            .clk_cnt_tick_hp(clk_cnt_tick_hp),
            .adc_fifo_module_frame_finish_flag_h(adc_fifo_module_frame_finish_flag_h),
            .cfg_r_finsh_h()
        );

        spi_drive#(
            .CLOCK_FREQ(50000000), //时钟频率
            .SPI_BPS(12500000), //SPI速率12.5M
	        .DATA_WIDTH(DATA_WIDTH))
        spi_drive_u
        (
	        .sys_clk(sys_clk)	,	
	        .sys_rst_n(sys_rst_n)	,
	        .spi_datain(cfg_to_spi_datain)		,				//内部总线输入进
	        .en_spi_hp(en_spi_hp)     ,   	//用于使能数据有效，
	        .spi_dataout(spi_dataout_to_rreg_datain)	,				//把通过SPI接受到的数
	        .spi_finsh_h(spi_finsh_h)	,				//传输数据标志
            .SCLK(SCLK)		,
	        .MISO(MISO)		,   
	        .MOSI(MOSI)		
        );

        always @(*) begin
            if(whrl_reg_flag)begin
                wDRDYOUT_hp =  (~DRDYOUT_l_d0)&&(DRDYOUT_l_d1);;
                wspi_finsh_h = spi_finsh_h;
                en_spi_hp = wen_spi_hp;
                cfg_to_spi_datain = wcfg_to_spi_datain;
                CS_l = wCS_l;
            end
            else begin
                rDRDYOUT_hp =  (~DRDYOUT_l_d0)&&(DRDYOUT_l_d1);;
                rspi_finsh_h = spi_finsh_h;
                en_spi_hp = ren_spi_hp;
                cfg_to_spi_datain = rcfg_to_spi_datain;
                CS_l = rCS_l;
            end
        end
endmodule 