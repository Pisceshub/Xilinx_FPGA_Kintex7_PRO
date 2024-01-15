//功能描述：ENSPI_in使能上升沿刷新寄存器数据，下降沿时开始传送数据并表示为忙状态。
// ENSPI_in下降沿开始传送数据，MISO在SCLK上升沿接收数据，接收完成后为dout寄存器。finish拉高状态时随时可以读取该数据；
// 				若再使能，对MISO无干扰，MOSI将会继续传送新的din剩余bit位数据。
// 只有在finish拉高才能传输新数据，读取收集的数据。

module spi_drive#(
    parameter CLOCK_FREQ    = 50000000,               //时钟频率
    parameter SPI_BPS       = 12500000,               //SPI速率12.5M
	parameter DATA_WIDTH	= 8							    //数据位宽
)(
	//系统接口
	input 								sys_clk	    ,	
	input 								sys_rst_n	,

	//数据接口
	input 			[DATA_WIDTH-1:0]	spi_datain	,				//内部总线输入进来，要通过SPI发送出去的数据
	input 		 		 				en_spi_hp   ,   			//用于使能数据有效，低脉冲使能，使能后刷新传输数据
	output 	reg 	[DATA_WIDTH-1:0]	spi_dataout	,				//把通过SPI接受到的数据发送给内部总线
	output 	reg  						spi_finsh_h	,				//传输数据标志
	//SPI通信接口
    output 	reg    						SCLK		,
	input 								MISO		,   
	output 	wire 						MOSI			
);
	//定义时钟分频上限
    parameter SPI_BPS_CNT_MAX = CLOCK_FREQ/ SPI_BPS -1;   //接收的比特计数器最大值=50个clk   4       
	
	reg MOSI_reg;
    reg [7:0]              	spi_bps_cnt;    //对时钟的计数
    reg [3:0]               bit_cnt;        //对数据计数(最多16bit)
    reg [DATA_WIDTH-1:0]    spi_rx_data;    //接收的数据寄存
	reg [DATA_WIDTH-1:0] 	spi_tx_data; 	//发送数据寄存

	//en_spi_hp为1刷新传输数据的en_spi_hp，spi_tx_data寄存器并开始传输
	always@(posedge sys_clk or negedge sys_rst_n)begin
		if(!sys_rst_n)begin
			spi_finsh_h <= 1'd1;					//保持完成状态
			spi_tx_data <= 'd0;						//不传输数据给0
		end
		else begin
			if(en_spi_hp) begin
				spi_finsh_h  <= 1'd0;				//en拉低就保持低状态	
				spi_tx_data  <= spi_datain;			//en拉低就刷新寄存器		
			end
			else if((bit_cnt == DATA_WIDTH - 1)&&(spi_bps_cnt == SPI_BPS_CNT_MAX - 1)) begin	 // #############
				spi_finsh_h  <= 1'd1;					//传输位计数到了就拉高
			end
			else begin
				spi_finsh_h  <= spi_finsh_h;				//其他情况保持
				spi_tx_data  <= spi_tx_data;		//其他情况保持
			end
		end
	end

	// spi_bps_cnt 波特率计数
    always@(posedge sys_clk or negedge sys_rst_n)begin
        if(!sys_rst_n)begin
            spi_bps_cnt <= 'd0;
        end
        else if(!spi_finsh_h) begin
            if(spi_bps_cnt <= SPI_BPS_CNT_MAX - 1) begin   //没有加到波特率就一直加
                spi_bps_cnt <= spi_bps_cnt + 1'b1;
            end
            else begin
                spi_bps_cnt <= 'd0;
            end
        end
        else begin
            spi_bps_cnt <= 'd0;
        end
    end

	// 发送数据bit计数
    always@(posedge sys_clk or negedge sys_rst_n)begin
        if(!sys_rst_n)begin
            bit_cnt  <= 4'b0;
        end
        else if(!spi_finsh_h) begin
            if(spi_bps_cnt == SPI_BPS_CNT_MAX - 1) begin   //没有加到波特率就一直加
                bit_cnt <= bit_cnt + 1'b1;           //加到了就计一位
            end
			else begin
				bit_cnt <= bit_cnt;
			end
        end
        else begin
            bit_cnt <=4'd0;
        end
    end

	//产生SCLK
    always@(posedge sys_clk or negedge sys_rst_n)begin
        if(!sys_rst_n) begin
            SCLK <= 1'b1;
        end
        else if((!spi_finsh_h))begin    
			//计数到一半反转低电平，计数完成翻转高电平
			if((spi_bps_cnt == SPI_BPS_CNT_MAX/2 ) || (spi_bps_cnt == SPI_BPS_CNT_MAX ))begin
				SCLK <= ~SCLK;
			end
			else begin
				SCLK <= SCLK;
			end
		end
		else begin
			SCLK <= 1'b1;
		end
    end
	
	//=====下降沿读=====CS低有效SCLK常高，DIN随机，DOUT高阻
    //接收数据 ,转为时钟上升沿再读
	wire SCLK_n;
	assign SCLK_n = ~SCLK;
    always@(posedge	SCLK_n	or	negedge	sys_rst_n)begin
    	if(!sys_rst_n)begin		
			spi_rx_data <= 8'b0;
    	end
    	else if(!spi_finsh_h)begin
    			case(bit_cnt)
    				4'd0	:	begin	spi_rx_data[7] <= MISO; end
    				4'd1	:	begin	spi_rx_data[6] <= MISO; end
    				4'd2	:	begin	spi_rx_data[5] <= MISO; end
    				4'd3	:	begin	spi_rx_data[4] <= MISO; end
    				4'd4	:	begin	spi_rx_data[3] <= MISO; end
    				4'd5	:	begin	spi_rx_data[2] <= MISO; end
    				4'd6	:	begin	spi_rx_data[1] <= MISO; end
    				4'd7	:	begin	spi_rx_data[0] <= MISO; end
    				default	:   begin	spi_rx_data    <= spi_rx_data; end
    			endcase
    		end
    		else begin		//非传输情况复位
				spi_rx_data <= spi_rx_data;	
    		end
    	end

	always @(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n)begin
			spi_dataout <= 'd0;
		end
		else if (spi_finsh_h)begin
			spi_dataout <= spi_rx_data;
		end
		else begin
			spi_dataout <= spi_dataout;
		end
	end

	//发送数据,下降准备数据
	always@(posedge	sys_clk or	negedge	sys_rst_n)begin
	   	if(!sys_rst_n)begin
	       	MOSI_reg	<= 1'b1;		//空闲状态，发送端为高电平
	   	end
	   	else if(!spi_finsh_h)begin 
	       	case(bit_cnt)					//先放数据
				4'd0	:	begin	MOSI_reg	<=	spi_tx_data[7]; end
    			4'd1	:	begin	MOSI_reg	<=	spi_tx_data[6]; end
    			4'd2	:	begin	MOSI_reg	<=	spi_tx_data[5]; end
    			4'd3	:	begin	MOSI_reg	<=	spi_tx_data[4]; end
    			4'd4	:	begin	MOSI_reg	<=	spi_tx_data[3]; end
    			4'd5	:	begin	MOSI_reg	<=	spi_tx_data[2]; end
    			4'd6	:	begin	MOSI_reg	<=	spi_tx_data[1]; end
    			4'd7	:	begin	MOSI_reg	<=	spi_tx_data[0]; end
    			default	:   begin	MOSI_reg	<=	MOSI_reg; 		end
    		endcase
		end
		else begin
			MOSI_reg	<=  1'b0;
		end
	end
	assign MOSI  = (!spi_finsh_h)? MOSI_reg:1'bz;	//发送完成保持低电平
endmodule


		












