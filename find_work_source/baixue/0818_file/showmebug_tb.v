
`timescale 1ns/1ps
`include "your_module.v"
module showmebug_tb();

    // Parameters
    parameter W = 8;
    parameter n = 8;
    
    // Inputs
    reg [W-1:0] a [0:n-1];
    
    // Output
    wire [W-1:0] c;
    
    // Instantiate your_module
    your_module dut (
        .a(a),
        .c(c)
    );

    integer i;
    initial begin
        for( i=0; i<n; i=i+1 ) 
            a[i] = i+1;
    end

    initial begin
        $dumpfile("showmebug_tb.vcd");
        $dumpvars(0,showmebug_tb);
    end
endmodule
