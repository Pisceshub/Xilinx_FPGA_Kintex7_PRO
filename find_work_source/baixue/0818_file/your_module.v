`timescale 1ns/1ps
module your_module #(
    parameter W = 8,
    parameter n = 8)
(
    input   [W-1:0][0:n-1] a,
    output  [W-1:0] c
);

    wire [W-1:0] or_cell = {W{1'b0}};
    genvar i;
    generate
        for(i = 0; i <n;i=i+1)
        begin:cell1 
            assign or_cell = or_cell | a[i];
        end 
    endgenerate

    assign c = or_cell;
endmodule

