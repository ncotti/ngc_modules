module top;
    timeunit 1ns/1ps;
    import tb_counter_pkg::*;
    import uvm_pkg::*;

    logic clk;
    localparam COUNT_WIDTH = 8;

    ngc_counter_if #(.COUNT_WIDTH(COUNT_WIDTH)) dif(clk);
    ngc_counter DUT (dif);

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        counter_cfg cfg_h;
        cfg_h = new("cfg_h", dif);
        uvm_config_db #(counter_cfg)::set(null, "", "cfg", cfg_h);
        run_test();
    end
endmodule: top