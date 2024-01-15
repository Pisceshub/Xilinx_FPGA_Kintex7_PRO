module key_filter #(
    parameter       KEY_N  =  1                      //要消除的按键的数量
)(
    input                       clk,
    input                       rst_n,
    input   [KEY_N-1:0]         key_in,
    output  wire  [KEY_N-1:0]   key_pulse ,                 //按键动作产生的脉冲
    output  wire  [KEY_N-1:0]   key_flag
);

    //打两拍取下降延
    reg [KEY_N-1:0] key_rst;
    reg [KEY_N-1:0] key_rst_pre;
    wire [KEY_N-1:0] key_edge;
    always @(posedge clk  or  negedge rst_n) begin
        if (!rst_n) begin
            key_rst <= {KEY_N{1'b1}};  
            key_rst_pre <= {KEY_N{1'b1}};
        end
        else begin
            key_rst <= key_in;  
            key_rst_pre <= key_rst;  
        end
    end

    assign  key_edge = key_rst_pre & (~key_rst);//脉冲边沿检测。当key检测到下降沿时，key_edge产生一个时钟周期的高电平

    reg	[19:0]	  cnt; 

    //产生20ms延时，当检测到key_edge有效是计数器赋值开始计数
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt <= 20'd0;
        else if(key_edge)
            cnt <= 20'h0f;
        else if(cnt >= 18'h01)
            cnt <= cnt - 1'h1;
        else begin
            cnt <= cnt;
        end
    end

 
    //这两段代码就是来用实现取前后按键信号的
    reg [KEY_N-1:0] key_in_r;
    reg [KEY_N-1:0] key_in_r_next;
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            key_in_r_next <= {KEY_N{1'b1}};  
        else if(cnt == 18'h01)
                key_in_r_next <= key_in;
            else 
                key_in_r_next <= {KEY_N{1'b1}}; 
    end
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
            key_in_r <= {KEY_N{1'b1}};  
        else
            key_in_r <= key_in_r_next;
    end
    wire [KEY_N-1:0] key_out;
    assign key_out = key_in_r & (~key_in_r_next);
    
    assign key_pulse = key_out;
    //后面两个单元很简单，控制led翻转
    wire [KEY_N-1:0] key_flag_w;
    //led翻转
    genvar i;
    generate 
        for(i = 0; i< KEY_N; i= i+1) begin:loop
            change_flag change_flag_u(
                .clk(clk),
                .rst_n(rst_n),
                .key_in(key_pulse[i]),
                .key_out(key_flag_w[i]));
        end
    endgenerate

    assign key_flag = key_flag_w;
    endmodule

module change_flag(
        input clk,rst_n,
        input key_in,
        output key_out);
        reg key_flag_r;
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)
                key_flag_r <= 1'b0;  
            else begin
                if(key_in)
                    key_flag_r <= ~key_flag_r;
                else
                    key_flag_r <= key_flag_r;
            end 
        end 
        assign key_out = key_flag_r;
endmodule