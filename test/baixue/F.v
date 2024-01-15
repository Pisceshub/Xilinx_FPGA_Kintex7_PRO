module CountTime(
    input InClk,//1M
    input InReset,
    output reg [5:0] OutSecond,
    output reg [5:0] OutMinute
);
    localparam cnt_MAX = 1000_000;
    localparam S_MAX = 59;
    reg [19:0] S_cnt ;
    always@(posedge InClk or negedge InReset) begin
        if(!InReset)
            S_cnt <= 'd0;
        else if( S_cnt< cnt_MAX)begin
            S_cnt <= S_cnt + 1'd1;
        end
        else begin
            S_cnt <= 'd0;
        end
    end
    always@(posedge InClk or negedge InReset) begin
        if(!InReset)
            OutSecond <= 'd0;
        else if( OutSecond < S_MAX)begin
            if(S_cnt == cnt_MAX)
                OutSecond <= OutSecond + 1'd1;
            else
                OutSecond <= OutSecond;
        end
        else begin
            OutSecond <= 'd0;
        end
    end 
    always@(posedge InClk or negedge InReset) begin
        if(!InReset)
            OutMinute <= 'd0;
        else if( OutMinute < 59)begin
            if((OutSecond == S_MAX) && (S_cnt == cnt_MAX))
                OutMinute <= OutMinute + 1'd1;
            else 
                OutMinute <= OutMinute; 
        end
        else begin
            OutMinute <= 'd0;
        end
    end 
endmodule 