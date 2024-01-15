`timescale 1ns/1ps
//负责cfg写入内容
module adc_chain_regcfg_r_max11040 #(
    parameter DATA_WIDTH = 8,
    parameter ADC_DCN = 8,
    parameter WRCR_N = 64,   // 写配置ADC寄存器 MAX11040_WCR_OPEN  8*n
    parameter WDRCR_N = 16,   // 数据速率控制寄存器 0x0000 16 bit
    parameter RSICR_N = 256   // 采样及时控制寄存器 MAX11040_RSICR_PHI0 32*n
)(
    //系统信号：
    input   wire                    sys_clk,
    input   wire                    sys_rst_n,
    input   wire [15:0]             ADC_SAMPLE_NUMBER,  
    input   wire [15:0]             adc_frame_cnt,   
    //控制信号
    input   wire                    cfg_r_en_h,
    input   wire                    DRDYOUT_hp,
    output  reg                     rreg_to_spi_en_hp,
    output  reg  [DATA_WIDTH -1:0]  rreh_to_spi_data,
    output  reg                     CS_l,
    input   wire                    spi_to_rreg_finsh_h,
    input   wire [7:0]              spi_to_rreg_datain,
    output  reg                     rreg_busy_h,  
    output  reg                     adc_to_fifo_wen_hp,
    output  reg  [31:0]             adc_to_fifo_wdata,
    output  reg                     adc_frame_flag_h,
    output  reg  [7:0]              fifo_frame_dep_cnt_time_andfremecnt,
    input   wire                    clk_cnt_tick_hp,
    input   wire                    adc_fifo_module_frame_finish_flag_h,
    output  reg                     cfg_r_finsh_h
);

    //spi_cs片选下降沿cnt开始byte_cnt计数
    reg CS_l_d0,CS_l_d1;
    wire CS_hp,CS_lp;
    reg  adc_frame_flag_hp;
    reg [7:0] state_cnt_to_fifo_frame;
    reg [7:0] rreg_to_fifo_cnt_data;
    wire [2:0] fifo_frame_dep_cnt_suppliment;
    //spi_to_wreg_finsh_h打两拍换脉冲用于计数
    reg spi_to_rreg_finsh_h_d0,spi_to_rreg_finsh_h_d1;
    wire spi_to_rreg_finsh_h_flag_hp;
    always@(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            spi_to_rreg_finsh_h_d0 <= 1'b0;
            spi_to_rreg_finsh_h_d1 <= 1'b0;
        end
        else begin
            if(cfg_r_en_h) begin
                spi_to_rreg_finsh_h_d0 <= spi_to_rreg_finsh_h;
                spi_to_rreg_finsh_h_d1 <= spi_to_rreg_finsh_h_d0;
            end
        end
    end
    assign spi_to_rreg_finsh_h_flag_hp = (spi_to_rreg_finsh_h_d0)&&(~spi_to_rreg_finsh_h_d1);

    //状态机(1)
    reg [9:0] current_state;
    reg [9:0] next_state;
    localparam     IDEL         = 10'b00_0000_0001;
    localparam IDELtoRRCR       = 10'b00_0000_0010;
    localparam     RRCR         = 10'b00_0000_0100;  //8*n
    localparam RRCRtoRDRCR      = 10'b00_0000_1000;
    localparam     RDRCR        = 10'b00_0001_0000; //32*n
    localparam RDRCRtoRSICR     = 10'b00_0010_0000;
    localparam     RSICR        = 10'b00_0100_0000; //16
    localparam RSICRtoRDRDATA   = 10'b00_1000_0000;
    localparam    RDRDATA       = 10'b01_0000_0000;
    localparam   RDRDATAtoIDEL  = 10'b10_0000_0000;
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
                if(cfg_r_en_h & (!cfg_r_finsh_h)) begin
                    next_state <= IDELtoRRCR;
                end
                else begin
                    next_state <= IDEL;
                end
            end
            IDELtoRRCR:   begin
                if(DRDYOUT_hp)begin
                    next_state <= RRCR; 
                end
                else begin
                    next_state <= IDELtoRRCR;
                end
            end
            RRCR:    begin
                if(byte_cnt<=REG_BYTE) begin
                    next_state <= RRCR;
                end
                else begin
                    next_state <= RRCRtoRDRCR;
                end
            end
            RRCRtoRDRCR: begin  
                if(DRDYOUT_hp)begin
                    next_state <= RDRCR;
                end
                else begin
                    next_state <= RRCRtoRDRCR;
                end
            end
            RDRCR: begin
                if(byte_cnt<=REG_BYTE) begin
                    next_state <= RDRCR;
                end
                else begin
                    next_state <= RDRCRtoRSICR;
                end
            end
            RDRCRtoRSICR:   begin
                if(DRDYOUT_hp)begin
                    next_state <= RSICR; 
                end
                else begin
                    next_state <= RDRCRtoRSICR;
                end
            end
            RSICR:  begin
                if(byte_cnt<=REG_BYTE) begin
                    next_state <= RSICR;
                end
                else begin
                    next_state <=  RSICRtoRDRDATA;
                end
            end
            RSICRtoRDRDATA: begin
                if(DRDYOUT_hp && (!adc_frame_flag_h))begin
                    next_state <= RDRDATA; 
                end
                else begin
                    next_state <= RSICRtoRDRDATA;
                end
            end
            RDRDATA:begin
                if(byte_cnt<=REG_BYTE ) begin
                    next_state <= RDRDATA;
                end
                else begin
                    next_state <=RDRDATAtoIDEL;
                end    
            end
            RDRDATAtoIDEL:   begin
                if(DRDYOUT_hp && (!adc_frame_flag_h) ) begin
                    next_state <= RDRDATA;
                end
                else if((adc_frame_cnt < ADC_SAMPLE_NUMBER[14:0]) || ADC_SAMPLE_NUMBER[15])begin
                    next_state <=  RDRDATAtoIDEL;
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

    //给全读完标志
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            cfg_r_finsh_h <='d0;
        end
        else if((current_state == RDRDATAtoIDEL) && (next_state == IDEL)) begin 
            cfg_r_finsh_h <='d1;
        end
        else if(!cfg_r_en_h) begin
            cfg_r_finsh_h <='d0;
        end
        else begin
            cfg_r_finsh_h <= cfg_r_finsh_h;
        end
    end
    //给帧读完脉冲
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            adc_frame_flag_hp <='d0;
        end
        // else if((current_state == RSICR RSICRtoRDRDATA) && (next_state == RDRDATA )|| 
        //         (current_state == RDRDATAtoIDEL)   && (next_state == RDRDATA)) begin 
        else if(state_cnt_to_fifo_frame == 'd19 + fifo_frame_dep_cnt_suppliment) begin 
            adc_frame_flag_hp <='d1;
        end
        else  begin
            adc_frame_flag_hp <='d0;
        end
    end

    reg adc_fifo_module_frame_finish_flag_hp_r0;
    wire adc_fifo_module_frame_finish_flag_hp;
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            adc_fifo_module_frame_finish_flag_hp_r0 <='d0;
        end
        else begin
            adc_fifo_module_frame_finish_flag_hp_r0 <= adc_fifo_module_frame_finish_flag_h;
        end
    end
    assign adc_fifo_module_frame_finish_flag_hp = (adc_fifo_module_frame_finish_flag_hp_r0) &&(~adc_fifo_module_frame_finish_flag_h);

    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            adc_frame_flag_h <='d0;
        end
        else  if(adc_frame_flag_hp) begin
            adc_frame_flag_h <= 1'b1;
        end
        else if(adc_fifo_module_frame_finish_flag_hp ) begin
            adc_frame_flag_h <= 1'b0;
        end
        else begin
            adc_frame_flag_h <= adc_frame_flag_h ;
        end
    end

    //用于给fifo_cnt读取时要读取多少个
    reg [7:0] fifo_dep_cnt; 
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            fifo_dep_cnt<='d0;
        end
        else if(adc_frame_flag_hp) begin
            fifo_dep_cnt<='d0;
        end
        else if(!CS_l & spi_to_rreg_finsh_h_flag_hp) begin 
            fifo_dep_cnt<= fifo_dep_cnt +1'b1;
        end
    end
    reg [7:0] fifo_frame_dep_cnt;
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            fifo_frame_dep_cnt<='d0;
        end
        else if(fifo_frame_dep_cnt <= fifo_dep_cnt) begin
            fifo_frame_dep_cnt<=fifo_dep_cnt;
        end
        else begin
            fifo_frame_dep_cnt<=fifo_frame_dep_cnt;
            if(CS_lp && (next_state > RSICR)) begin 
                fifo_frame_dep_cnt<= 'd0;
            end
        end
    end
    // reg [7:0] fifo_frame_dep_cnt; 4*8bit time and 2*8 framecnt
    assign fifo_frame_dep_cnt_time_andfremecnt  = fifo_frame_dep_cnt + 8'd6 + 4 - (fifo_frame_dep_cnt + 8'd6)%4;
   
    assign fifo_frame_dep_cnt_suppliment = fifo_frame_dep_cnt_time_andfremecnt - (fifo_frame_dep_cnt + 8'd6);
    reg [31:0] clk_cnt_time;
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            clk_cnt_time <= 'd0;
        end
        else begin 
            clk_cnt_time <= clk_cnt_time + 1'b1;
        end
    end

    reg [31:0] clk_cnt_time_to_fifo;
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            clk_cnt_time_to_fifo <= 'd0;
        end
        else if(CS_hp)begin 
            clk_cnt_time_to_fifo <= clk_cnt_time;
        end
    end

    // CS拉高且状态到了next_state >RSICR 写入帧数
    
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            adc_to_fifo_wdata <= 'd0;
            adc_to_fifo_wen_hp <= 'd0;
            state_cnt_to_fifo_frame <= 'd0;
        end
        else if(!CS_l) begin
            adc_to_fifo_wdata <= spi_to_rreg_datain;
            adc_to_fifo_wen_hp <= spi_to_rreg_finsh_h_flag_hp;
            state_cnt_to_fifo_frame <= 'd0;
        end
        else if(next_state >= RSICR) begin
            adc_to_fifo_wdata <= spi_to_rreg_datain;
            adc_to_fifo_wen_hp <= 'd0;
            if(state_cnt_to_fifo_frame <= 'd19 + fifo_frame_dep_cnt_suppliment)begin
                state_cnt_to_fifo_frame <= state_cnt_to_fifo_frame + 1'b1;
                case (state_cnt_to_fifo_frame)
                    'd1:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;           adc_to_fifo_wen_hp <= 'd0;end
                    'd2:begin adc_to_fifo_wdata <= clk_cnt_time_to_fifo[7:0];   adc_to_fifo_wen_hp <= 'd0;end
                    'd3:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;           adc_to_fifo_wen_hp <= 'd1;end
                    'd4:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;           adc_to_fifo_wen_hp <= 'd0;end
                    'd5:begin adc_to_fifo_wdata <= clk_cnt_time_to_fifo[15:8];  adc_to_fifo_wen_hp <= 'd0;end
                    'd6:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;           adc_to_fifo_wen_hp <= 'd1;end

                    'd7:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;           adc_to_fifo_wen_hp <= 'd0;end
                    'd8:begin adc_to_fifo_wdata <= clk_cnt_time_to_fifo[23:16]; adc_to_fifo_wen_hp <= 'd0;end
                    'd9:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;           adc_to_fifo_wen_hp <= 'd1;end
                    'd10:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;          adc_to_fifo_wen_hp <= 'd0;end
                    'd11:begin adc_to_fifo_wdata <= clk_cnt_time_to_fifo[31:24];adc_to_fifo_wen_hp <= 'd0;end
                    'd12:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;          adc_to_fifo_wen_hp <= 'd1;end

                    'd13:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;          adc_to_fifo_wen_hp <= 'd0;end
                    'd14:begin adc_to_fifo_wdata <= adc_frame_cnt[7:0];         adc_to_fifo_wen_hp <= 'd0;end
                    'd15:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;          adc_to_fifo_wen_hp <= 'd1;end

                    'd16:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;          adc_to_fifo_wen_hp <= 'd0;end
                    'd17:begin adc_to_fifo_wdata <= adc_frame_cnt[15:8];        adc_to_fifo_wen_hp <= 'd0;end
                    'd18:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;          adc_to_fifo_wen_hp <= 'd1;end
                    'd19:begin adc_to_fifo_wdata <= adc_to_fifo_wdata;          adc_to_fifo_wen_hp <= 'd0;end

                    'd20:begin adc_to_fifo_wdata <= 'd0;                        adc_to_fifo_wen_hp <= 'd1;end
                    'd21:begin adc_to_fifo_wdata <= 'd0;                        adc_to_fifo_wen_hp <= 'd1;end
                    'd22:begin adc_to_fifo_wdata <= 'd0;                        adc_to_fifo_wen_hp <= 'd1;end
                    'd23:begin adc_to_fifo_wdata <= 'd0;                        adc_to_fifo_wen_hp <= 'd1;end
                    'd24:begin adc_to_fifo_wdata <= 'd0;                        adc_to_fifo_wen_hp <= 'd1;end
                    'd25:begin adc_to_fifo_wdata <= 'd0;                        adc_to_fifo_wen_hp <= 'd1;end
                    default :begin adc_to_fifo_wdata <= adc_to_fifo_wdata;      adc_to_fifo_wen_hp <= 'd0;end
                endcase
            end
            else begin
                state_cnt_to_fifo_frame <= state_cnt_to_fifo_frame ;
            end
        end
    end













    //是否处于ADC读忙中
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            rreg_busy_h <= 1'b0;
        end
        else if(cfg_r_en_h) begin
            case(next_state)
                IDELtoRRCR,RRCR,RRCRtoRDRCR,RDRCR,RDRCRtoRSICR,RSICR,RSICRtoRDRDATA,RDRDATA: rreg_busy_h <= 1'b1;
                default : rreg_busy_h <= 1'b0;      
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
                RRCR,RDRCR,RSICR,RDRDATA: begin 
                    CS_l <= 'd0;
                end
                default:CS_l <= 'd1;
            endcase
        end
    end


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
    assign CS_lp = (~CS_l_d0)&&(CS_l_d1);
    assign CS_hp = (CS_l_d0)&&(~CS_l_d1);

    //byte_cnt计数 和 spi数据有效
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            byte_cnt <='d0;
            rreg_to_spi_en_hp <='d0;
        end
        else begin 
            case(next_state)
                RRCR,RDRCR,RSICR,RDRDATA: begin 
                    if(CS_lp || spi_to_rreg_finsh_h_flag_hp && (byte_cnt <= REG_BYTE)) begin
                        byte_cnt <= byte_cnt + 1'd1;
                        rreg_to_spi_en_hp <='d1;
                        if(byte_cnt == REG_BYTE) begin
                            rreg_to_spi_en_hp <='d0;
                        end
                    end
                    else begin
                        byte_cnt <= byte_cnt; 
                        rreg_to_spi_en_hp <='d0;
                    end
                end
                default:begin 
                        byte_cnt <= 'd0;
                        rreg_to_spi_en_hp <='d0; 
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
            RRCR: begin
                REG_BYTE<=WRCR_N/8 +1;
            end
            RDRCR: begin
                REG_BYTE<=WDRCR_N/8 +1 ;
            end
            RSICR: begin
                REG_BYTE<=RSICR_N/8 + 1;
            end
            RDRDATA:begin
                REG_BYTE<=4*3*WRCR_N/8+1;
            end
            default: begin
                REG_BYTE<='d0;
            end
        endcase
    end

    //给spi数据
    always @ (posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n) begin
            rreh_to_spi_data<='d255;
        end
        else if(cfg_r_en_h) begin
            case(next_state)
                IDELtoRRCR,RRCR: begin
                    case(byte_cnt)
                        'd0: rreh_to_spi_data <= 8'b1110_0000; 
                        default: rreh_to_spi_data <= 8'd0; 
                    endcase
                end
                RRCRtoRDRCR,RDRCR: begin
                    case(byte_cnt)    
                        'd0: rreh_to_spi_data <= 8'b1101_0000; 
                        default: rreh_to_spi_data <= 8'd0;
                    endcase
                    end
                RDRCRtoRSICR,RSICR: begin
                    case(byte_cnt)    
                        'd0: rreh_to_spi_data <= 8'b1100_0000; 
                        default: rreh_to_spi_data <= 8'd0;
                    endcase
                end
                RDRDATAtoIDEL,RDRDATA:begin
                    case(byte_cnt)    
                        'd0: rreh_to_spi_data <= 8'b1111_0000; 
                        default: rreh_to_spi_data <= 8'd0;
                    endcase
                end 
                default: begin
                            rreh_to_spi_data <= 'd255;
                        end
            endcase
        end
    end
    
endmodule
