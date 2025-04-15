interface ngc_counter_if #(
    parameter COUNT_WIDTH=8
)(
    input logic clk
);

logic rst, load, enb, dir, one_shot;
logic [COUNT_WIDTH-1:0] load_value, count_to_value, count_from_value;
logic [COUNT_WIDTH/2-1:0] step_value;
logic [COUNT_WIDTH-1:0] count;
logic count_hit;

clocking mcb @(posedge clk);
    output clk, rst, load, enb, dir, one_shot, load_value, count_to_value,
        count_from_value, step_value;
    input count, count_hit;
endclocking: mcb

clocking scb @(posedge clk);
    input clk, rst, load, enb, dir, one_shot, load_value, count_to_value,
        count_from_value, step_value;
    output count;
endclocking: scb

modport slave_mp (
    input clk, rst, load, enb, dir, one_shot, load_value, count_to_value,
        count_from_value, step_value,
    output count, count_hit
);

modport master_mp (
    output clk, rst, load, enb, dir, one_shot, load_value, count_to_value,
        count_from_value, step_value,
    input count, count_hit
);

modport master_tb_mp (clocking mcb);
modport slave_tb_mp (clocking scb, output count_hit);

endinterface: ngc_counter_if