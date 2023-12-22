module moduleName #(
    parameter NUM_INPUT =8
)(
    input [NUM_INPUT*8-1:0] in,
    output [12-1:0] out
);
    
    genvar i;
    generate
        for(i=1;i<NUM_INPUT;i=i+1)
            assign out = out + [NUM_INPUT*i-1:NUM_INPUT*i-8]in;
    endgenerate
    
endmodule
module moduleName #(
    input clk,
    input rstn,

    input data_in,
    input valid_in,
    output [3:0] data_out,
    output valid_out
);
l











    
endmodule