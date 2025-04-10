module top_directed;
    timeunit 1ns/1ps;
    localparam COUNT_WIDTH = 8;
    logic clk;
    ngc_counter_if #(.COUNT_WIDTH(COUNT_WIDTH)) dif (clk);

    ngc_counter DUT (dif);
    directed_tb test(dif);

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk;
        end
    end

endmodule

program automatic directed_tb(ngc_counter_if.master_tb_mp dif);
    initial begin
        $monitor("count: %d; count_hit = %b",
            dif.mcb.count, dif.mcb.count_hit);
        @(dif.mcb);
        dif.mcb.rst <= 1'b1;
        dif.mcb.load <= 1'b0;
        dif.mcb.enb <= 1'b1;
        dif.mcb.dir <= 1'b0;
        dif.mcb.one_shot <= 1'b0;
        dif.mcb.load_value <= 'd0;
        dif.mcb.count_from_value <= 'd0;
        dif.mcb.count_to_value <= 'd10;
        dif.mcb.step_value <= 'd1;
        @(dif.mcb);
        dif.mcb.rst <= 1'b0;

        repeat(25) @dif.mcb;
        $finish;
    end
endprogram: directed_tb