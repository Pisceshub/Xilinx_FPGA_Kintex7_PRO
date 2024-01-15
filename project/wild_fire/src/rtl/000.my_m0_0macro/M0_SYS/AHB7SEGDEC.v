module AHB7SEGDEC (
    //从设备选择信号
        input wire HSEL             ,
    //全局信号
        input wire HCLK             ,
        input wire HRESETn          ,
    //地址、控制和写信号
        input wire HREADY           ,
        input wire [31:0]HADDR      ,
        input wire [1:0]HTRANS      ,
        input wire HWRITE           ,
        input wire [2:0] HSIZE      ,   
        
        input wire [31:0]HWDATA      ,
    //传输响应和读数据
        output wire HREADYOUT       ,
        output wire [31:0] HRADTA   ,

    //七段数码管接口信号
        output reg [6:0]seg,
        output [7:0] an,
        output dp
);
//地址周期采样寄存器
    reg rHSEL;
    reg [31:0] rHADDR;
    reg [1:0] rHTRANS;
    reg rHWRITE;
    reg [2:0] rHSIZE;
//地址周期采样
    always @(posedge HCLK or negedge HRESETn) begin
        if(!HRESETn) begin
            rHSEL       <= 'd0  ;
            rHADDR      <= 'd0  ;
            rHTRANS     <= 'd0  ;
            rHWRITE     <= 'd0  ;
            rHSIZE      <= 'd0  ;
        end
        else begin
            rHSEL       <= HSEL  ;
            rHADDR      <= HADDR ;
            rHTRANS     <= HTRANS;
            rHWRITE     <= HWRITE;
            rHSIZE      <= HSIZE ;
        end       
    end
    
//数据周期数据传输
    reg [31:0] DATA;
    always @(posedge HCLK or negedge HRESETn) begin
        if(!HRESETn) begin
            DATA <= 'd0;
        end
        else begin
            if(rHSEL & rHWRITE & rHTRANS[1]) begin
                DATA <= HWDATA[31:0];
            end
        end
    end
//传输响应
    assign HREADYOUT = 1'b1;

//读数据
    wire [31:0] HRDATA;
    assign HRDATA = DATA;

    reg [15:0]counter;
    reg [7:0]ring=8'd1;

    wire [3:0] code;
    wire [6:0] seg_out;

    reg scan_clk;
    assign an = ring;
    assign dp = 1'b1;

    //扫描时钟生成模块
    always @(posedge HCLK or negedge HRESETn) begin
        if(!HRESETn) begin
            counter <= 16'd0;
            scan_clk <=1'b0;
        end
        else begin
            if(counter == 16'h0070)begin
                scan_clk <= ~scan_clk;
                counter <= 16'd0;
            end
            else begin
                counter <= counter + 1'b1;
            end
        end
    end

    //数码管选信号生成模块
    always @(posedge scan_clk or negedge HRESETn) begin
        if(!HRESETn) begin
            ring <= 8'd1;
        end
        else begin
            ring <= {ring[6:0],ring[7]};
        end
    end

    //数据和7段数码管中每个数码管的对应关系,每位给每位数据
    assign code = 
        (ring == 8'd1   ) ? DATA[3:0]       :
        (ring == 8'd2   ) ? DATA[7:4]       :
        (ring == 8'd4   ) ? DATA[11:8]      :
        (ring == 8'd8   ) ? DATA[15:12]     :
        (ring == 8'd16  ) ? DATA[19:16]     :
        (ring == 8'd32  ) ? DATA[23:20]     :
        (ring == 8'd64  ) ? DATA[27:24]     :
        (ring == 8'd128 ) ? DATA[31:28]     :
        4'hA;
//h->seg
    always @( *) begin
        case(code)
            4'd0 :    seg = 7'h3f;//40
            4'd1 :    seg = 7'h06;//79
            4'd2 :    seg = 7'h5b;//24
            4'd3 :    seg = 7'h4f;//30
            4'd4 :    seg = 7'h66;//19
            4'd5 :    seg = 7'h6d;//12
            4'd6 :    seg = 7'h7d;//02
            4'd7 :    seg = 7'h07;//78
            4'd8 :    seg = 7'h7f;//20
            4'd9 :    seg = 7'h6f;//10
            4'd10:    seg = 7'h77;//08
            4'd11:    seg = 7'h7c;//03
            4'd12:    seg = 7'h39;//46
            4'd13:    seg = 7'h5e;//21
            4'd14:    seg = 7'h79;//06
            4'd15:    seg = 7'h71;//0e
            default : seg = 7'h00;//00
        endcase
    end
endmodule