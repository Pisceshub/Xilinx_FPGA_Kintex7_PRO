module MatrixInput (
    input wire [15:0][0:15] matrix_input,
    output wire [15:0] matrix_output
);
    // Connect matrix_input directly to matrix_output

    wire [15:0] matrix_input_r = {15{1'b0}};
    genvar i;
    generate
        for(i = 0; i <16;i=i+1)
        begin:cell1 
            assign matrix_input_r = matrix_input_r | matrix_input[i];
        end 
    endgenerate

    assign matrix_output = matrix_input_r;
    
endmodule