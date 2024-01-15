`timescale 1ns/1ps
module fsdb();

initial begin
        #1000000;
        $finish;
end


`ifdef FSDB
initial begin
        $fsdbDumpfile("simv.fsdb");
        $fsdbDumpvars;

end
`endif
`ifdef VCD
initial begin
        $dumpfile("simv.vcd");
        $dumpvars;
end
`endif

endmodule