module fsdb ();
parameter finishtime = 100000; 

initial begin
        $display("**************** Simulation Start! ****************");
        # finishtime;
        $display("**************** Simulation Finish! ****************");
        $finish;
end

`ifdef FSDB
initial begin
        $fsdbDumpfile("/home/ICer/my_ic/project/wild_fire/vcs/work/simv.fsdb");
        $fsdbDumpvars(0,M0_tb,"+mda");

end

`endif
`ifdef VCD
initial begin
        $dumpfile("/home/ICer/my_ic/project/wild_fire/vcs/work/simv.vcd");
        $dumpvars;
end
`endif

endmodule