module fifo_async#(
    parameter   read_data_width = 32,
    parameter   wirte_data_width = 8,

    parameter   data_depth = 512,
    parameter   addr_width = 9
)
(
    input                                   sys_rst_n,
    input                                   wr_clk,
    input                                   wr_en,
    input      [wirte_data_width-1:0]       din,         
    input                                   rd_clk,
    input                                   rd_en,
    output reg                              valid,
    output reg [read_data_width-1:0]        dout,
    output                                  empty,
    output                                  full
);
    reg    [addr_width:0]    wr_addr_ptr;//地址指针，比地址多一位，MSB用于检测在同一圈
    reg    [addr_width:0]    rd_addr_ptr;
    wire   [addr_width-1:0]  wr_addr;//RAM 地址
    wire   [addr_width-1:0]  rd_addr;

    wire   [addr_width:0]    wr_addr_gray;//地址指针对应的格雷码
    reg    [addr_width:0]    wr_addr_gray_d1;
    reg    [addr_width:0]    wr_addr_gray_d2;
    wire   [addr_width:0]    rd_addr_gray;
    reg    [addr_width:0]    rd_addr_gray_d1;
    reg    [addr_width:0]    rd_addr_gray_d2;

    reg    [wirte_data_width-1:0]  fifo_ram [data_depth-1:0];

    //=========================================================write fifo 
    genvar i;
    generate 
    for(i = 0; i < data_depth; i = i + 1 )
    begin:fifo_init
    always@(posedge wr_clk or posedge sys_rst_n)
        begin
           if(!sys_rst_n)
              fifo_ram[i] <= 'h0;//fifo复位后输出总线上是0，并非ram中真的复位。可无
           else if(wr_en && (~full))
              fifo_ram[wr_addr] <= din;
           else
              fifo_ram[wr_addr] <= fifo_ram[wr_addr];
        end   
    end    
    endgenerate    
    //========================================================read_fifo
    always@(posedge rd_clk or posedge sys_rst_n)
       begin
          if(!sys_rst_n)
             begin
                dout <= 'h0;
                valid <= 1'b0;
             end
          else if(rd_en && (~empty))
             begin
                dout <= {fifo_ram[rd_addr+3],fifo_ram[rd_addr+2],fifo_ram[rd_addr+1],fifo_ram[rd_addr]};
                valid <= 1'b1;
             end
          else
             begin
                dout <=  'h0;//fifo复位后输出总线上是0，并非ram中真的复位，只是让总线为0；
                valid <= 1'b0;
             end
       end

    assign wr_addr = wr_addr_ptr[addr_width-1-:addr_width];
    assign rd_addr = rd_addr_ptr[addr_width-1-:addr_width];
    //=============================================================格雷码同步化
    always@(posedge wr_clk )
       begin
          rd_addr_gray_d1 <= rd_addr_gray;
          rd_addr_gray_d2 <= rd_addr_gray_d1;
       end
    always@(posedge wr_clk or posedge sys_rst_n)
       begin
          if(!sys_rst_n)
             wr_addr_ptr <= 'h0;
          else if(wr_en && (~full))
             wr_addr_ptr <= wr_addr_ptr + 1;
          else 
             wr_addr_ptr <= wr_addr_ptr;
       end
    //=========================================================rd_clk
    always@(posedge rd_clk )
          begin
             wr_addr_gray_d1 <= wr_addr_gray;
             wr_addr_gray_d2 <= wr_addr_gray_d1;
          end
    always@(posedge rd_clk or posedge sys_rst_n)
       begin
          if(!sys_rst_n)
             rd_addr_ptr <= 'h0;
          else if(rd_en && (~empty))
             rd_addr_ptr <= rd_addr_ptr + 4;
          else 
             rd_addr_ptr <= rd_addr_ptr;
       end

    //========================================================== translation gary code
    assign wr_addr_gray = (wr_addr_ptr >> 1) ^ wr_addr_ptr;
    assign rd_addr_gray = (rd_addr_ptr >> 1) ^ rd_addr_ptr;

    assign full = (wr_addr_gray == {~(rd_addr_gray_d2[addr_width-:2]),rd_addr_gray_d2[addr_width-2:0]}) ;//高两位不同
    assign empty = ( rd_addr_gray == wr_addr_gray_d2 );

endmodule