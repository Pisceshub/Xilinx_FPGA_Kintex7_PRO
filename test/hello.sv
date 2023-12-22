
`timescale 1ns/1ps

`include "/home/ICer/my_ic/uvm/uvm_lib/uvm-1.1a/src/uvm_macros.svh"
import uvm_pkg::*;

class hello_test extends uvm_test;
    `uvm_component_utils(hello_test)

    function new(string name = "hello_test", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("hello_test", "new is called", UVM_LOW);
    endfunction

    virtual task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info("hello_test", "main_phase is called", UVM_LOW);
        #100;
        `uvm_info("hello_test", "main_phase is finish", UVM_LOW);
        phase.drop_objection(this);
    endtask

endclass


module tb;

    initial begin;
        $display("HELLO_TEST");
        $display("HELLO_TEST");
        $display("HELLO_TEST");
        $display("HELLO_TEST");
        $display("HELLO_TEST");
        run_test("hello_test");

    end

endmodule
