`timescale 1ns/1ps
//负责cfg写入内容
module adc_chain_regcfg_w_max11040 #(
    parameter DATA_WIDTH = 8,
    parameter ADC_DCN = 8,
    parameter WRCR_N = 64,   // 写配置ADC寄存器 MAX11040_WCR_OPEN  8*n
    parameter WDRCR_N = 16,   // 数据速率控制寄存器 0x0000 16 bit
    parameter WSICR_N = 256   // 采样及时控制寄存器 MAX11040_WSICR_PHI0 32*n
)(
    //系统信号：
    input   wire                    sys_clk,
    input   wire                    sys_rst_n,
    //配置信号：
    input   wire [WRCR_N -1:0]      WRCR_DATA,
    input   wire [WDRCR_N-1:0]      WDRCR_DATA,
    input   wire [WSICR_N -1:0]     WSICR_DATA,
    //控制信号
    input   wire                    cfg_w_en_h,
    output  reg                     wreg_busy_h,  
    input   wire                    DRDYOUT_hp,
    output  reg                     wreg_to_spi_en_hp,
    output  reg  [DATA_WIDTH -1:0]  wreg_to_spi_data,

    output  reg                     CS_l,
    input   wire                    spi_to_wreg_finsh_h,
    input   wire                    spi_to_wreg_datain,  //暂时没用
    output  reg                     cfg_w_finsh_h
);

    // wire [WRCR_N -1:0]  MAX11040_WCR_OPEN ;
    // assign MAX11040_WCR_OPEN = WRCR_DATA;

    // wire [WDRCR_N-1:0] MAX11040_WDRCR_FSAMPC_A ;
    // assign MAX11040_WDRCR_FSAMPC_A = WDRCR_DATA;

    // wire [WSICR_N -1:0] MAX11040_WSICR_PHI ;
    // assign MAX11040_WSICR_PHI = WSICR_DATA;

    //WDRCR_//16 //RSICR_//32*n  //RCR_//8*n//WCR_//8*n
    // localparam     REG_NUMBER = WRCR_N + WDRCR_N + WSICR_N;   //寄存器写数据额度


    reg [7:0] start_init_cnt;
    wire cfg_w_start_h;
    localparam WRITE_TIME = 8'h1f; //等待时间
    //开始配置前等待一段时间
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            start_init_cnt      <=  8'd0;
        end
        else if(cfg_w_en_h)
            if(start_init_cnt  <   WRITE_TIME) begin  //cfgen_n    ->L,    start_init_cnt
                start_init_cnt      <=  start_init_cnt + 1'b1   ;
            end
            else begin
                start_init_cnt      <=  start_init_cnt;
            end
        else begin
            start_init_cnt      <=  8'd0;
        end
    end
    assign cfg_w_start_h = (start_init_cnt == WRITE_TIME)? 1'b1:1'b0;


    //spi_to_wreg_finsh_h打两拍换脉冲用于计数
    reg spi_to_wreg_finsh_h_d0,spi_to_wreg_finsh_h_d1;
    wire spi_to_wreg_finsh_h_flag_hp;
    always@(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            spi_to_wreg_finsh_h_d0 <= 1'b0;
            spi_to_wreg_finsh_h_d1 <= 1'b0;
        end
        else begin
            spi_to_wreg_finsh_h_d0 <= spi_to_wreg_finsh_h;
            spi_to_wreg_finsh_h_d1 <= spi_to_wreg_finsh_h_d0;
        end
    end
    assign spi_to_wreg_finsh_h_flag_hp = (spi_to_wreg_finsh_h_d0)&&(~spi_to_wreg_finsh_h_d1);


    //状态机(1)
    reg [7:0] current_state;
    reg [7:0] next_state;
    localparam     IDEL     = 8'b0000_0001;
    localparam IDELtoWRCR   = 8'b0000_0010;
    localparam     WRCR     = 8'b0000_0100;  //8*n
    localparam WRCRtoWDRCR  = 8'b0000_1000;
    localparam     WDRCR    = 8'b0001_0000; //32*n
    localparam WDRCRtoWSICR = 8'b0010_0000;
    localparam     WSICR    = 8'b0100_0000; //16
    localparam WSICRtoIDEL  = 8'b1000_0000;


    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            current_state <= IDEL;
        end
        else begin
            current_state <= next_state;
        end
    end
    //状态机
    reg [7:0] byte_cnt;
    reg [7:0] REG_BYTE;
    always @(*) begin
        case(current_state)
            IDEL:   begin
                if(cfg_w_start_h & (! cfg_w_finsh_h)) begin
                    next_state <= IDELtoWRCR;
                end
                else begin
                    next_state <= IDEL;
                end
            end
            IDELtoWRCR:   begin
                if(DRDYOUT_hp)begin
                    next_state <= WRCR; //没有中断时无条件跳转
                end
                else begin
                    next_state <= IDELtoWRCR;
                end
            end
            WRCR:    begin
                if(byte_cnt<=REG_BYTE) begin
                    next_state <= WRCR;
                end
                else begin
                    next_state <= WRCRtoWDRCR;
                end
            end
            WRCRtoWDRCR:  begin
                if(DRDYOUT_hp)begin
                    next_state <= WDRCR; //没有中断时无条件跳转
                end
                else begin
                    next_state <= WRCRtoWDRCR;
                end
            end
            WDRCR: begin
                if(byte_cnt<=REG_BYTE) begin
                    next_state <= WDRCR;
                end
                else begin
                    next_state <= WDRCRtoWSICR;
                end
            end
            WDRCRtoWSICR:   begin
                if(DRDYOUT_hp)begin
                    next_state <= WSICR; //没有中断时无条件跳转
                end
                else begin
                    next_state <= WDRCRtoWSICR;
                end
            end
            WSICR:  begin
                if(byte_cnt<=REG_BYTE) begin
                    next_state <= WSICR;
                end
                else begin
                    next_state <=  WSICRtoIDEL;
                end
            end
            WSICRtoIDEL:   begin
                if(cfg_w_start_h & cfg_w_finsh_h) begin
                    next_state <= WSICRtoIDEL;
                end
                else begin
                    next_state <= IDEL;
                end    
            end
            default: begin
                next_state <= IDEL;
            end
        endcase
    end
    //给标志
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            cfg_w_finsh_h <='d0;
        end
        else if((current_state == WSICR) &&(next_state == WSICRtoIDEL)) begin 
            cfg_w_finsh_h <='d1;
        end
        else if(start_init_cnt=='d0) begin
            cfg_w_finsh_h <='d0;
        end
        else begin
            cfg_w_finsh_h <= cfg_w_finsh_h;
        end
    end
    //是否处于配置ADC写忙中
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            wreg_busy_h <= 1'b0;
        end
        else if(cfg_w_start_h) begin
            case(next_state)
                IDEL,IDELtoWRCR,WRCR,WRCRtoWDRCR,WDRCR,WDRCRtoWSICR,WSICR: wreg_busy_h <= 1'b1;
                default : wreg_busy_h <= 1'b0;      
            endcase
        end
    end


    //给SPI片选
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            CS_l <='d1;
        end
        else begin 
            case(next_state)
                WRCR,WDRCR,WSICR: begin 
                    CS_l <= 'd0;
                end
                default:CS_l <= 'd1;
            endcase
        end
    end

    //spi_cs片选下降沿cnt开始byte_cnt计数
    reg CS_l_d0,CS_l_d1;
    wire CS_hp;
    always@(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            CS_l_d0 <= 1'b0;
            CS_l_d1 <= 1'b0;
        end
        else begin
            CS_l_d0 <= CS_l;
            CS_l_d1 <= CS_l_d0;
        end
    end
    assign CS_hp = (~CS_l_d0)&&(CS_l_d1);

    //byte_cnt计数 和 spi数据有效
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            byte_cnt <='d0;
            wreg_to_spi_en_hp <='d0;
        end
        else begin 
            case(next_state)
                WRCR,WDRCR,WSICR: begin 
                    if(CS_hp || spi_to_wreg_finsh_h_flag_hp && (byte_cnt <= REG_BYTE)) begin
                        byte_cnt <= byte_cnt + 1'd1;
                        wreg_to_spi_en_hp <='d1;
                        if(byte_cnt==REG_BYTE) begin
                            wreg_to_spi_en_hp <='d0;
                        end
                    end
                    else begin
                        byte_cnt <= byte_cnt; 
                        wreg_to_spi_en_hp <='d0;
                    end
                end
                default:begin 
                        byte_cnt <= 'd0;
                        wreg_to_spi_en_hp <='d0; 
                    end
            endcase
        end
    end

    //WDRCR_//16 //RSICR_//32*n  //RCR_//8*n//WCR_//8*n
    //给REG_BYTE范围:
    always @ (*) begin
        case(next_state)
            IDEL: begin
                REG_BYTE<='d0;
            end
            WRCR: begin
                REG_BYTE<=WRCR_N/8+1;
            end
            WDRCR: begin
                REG_BYTE<=WDRCR_N/8 +1 ;
            end
            WSICR: begin
                REG_BYTE<=WSICR_N/8+1;
            end
            default: begin
                REG_BYTE<='d0;
            end
        endcase
    end

    //给数据
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            wreg_to_spi_data<='d255;
        end
        else if(cfg_w_start_h) begin
            case(next_state)
                IDELtoWRCR,WRCR: begin
                    case(byte_cnt)
                        'd0: wreg_to_spi_data <= 8'b0110_0000; 
                        default: wreg_to_spi_data <= WRCR_DATA[ 8-1: 0]; 
                    endcase
                end
                WRCRtoWDRCR,WDRCR: begin
                        case(byte_cnt)    
                            'd0: wreg_to_spi_data <= 8'b0101_0000; 
                            'd1: wreg_to_spi_data <= WDRCR_DATA[7:0];
                            'd2: wreg_to_spi_data <= WDRCR_DATA[15:8];
                            default: wreg_to_spi_data <= WDRCR_DATA[7:0];
                        endcase
                    end
                WDRCRtoWSICR,WSICR: begin
                        case(byte_cnt)    
                            'd0: wreg_to_spi_data <= 8'b0100_0000; 
                            default: wreg_to_spi_data <= WSICR_DATA[7:0];
                        endcase
                end
                default: begin
                            wreg_to_spi_data <= 'd255;
                        end
            endcase
        end
    end
endmodule
