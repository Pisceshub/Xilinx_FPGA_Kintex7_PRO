module prescaler(
    input       sys_clk,
    input       sys_rst_n,
    output  reg outclk
);
    reg [3:0] cnt;
    always@(posedge sys_clk) begin
        if(!sys_rst_n) begin
            cnt <= 'd0;
            outclk <= 'd0;
        end
        else if(cnt < 4'hF)begin
            cnt <= cnt + 1'b1;
        end
        else begin
            cnt <= 'd0;
            outclk<=~outclk;
        end
    end

endmodule //prescaler
