`timescale 1ns/1ps
`include "MatrixInput.v"
module MatrixInput_Test();


    // Declare signals for connecting to UUT
    reg [15:0] matrix_input[0:15];
    wire [15:0] matrix_output;


     integer i;
    // Initialize test inputs
    initial begin
        // Initialize matrix_input with example values
        for (i = 0; i < 15; i = i + 1) begin
            matrix_input[i] = i * 16'h1111; // Example input data
        end

        // Display test input values
        $display("matrix_input:");
        for (i = 0; i < 15; i = i + 1) begin
            $display("matrix_input[%0d] = %h", i, matrix_input[i]);
        end

        // Monitor the output
        $monitor("matrix_output = %h", matrix_output);
    end

    // Instantiate the MatrixInput module
    MatrixInput uut (
        .matrix_input(matrix_input), // Input to the UUT
        .matrix_output(matrix_output) // Output from the UUT
    );
endmodule
