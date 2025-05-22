interface ngc_fifo_if #(
    parameter DATA_WIDTH,
    parameter SIZE
)(
    input logic clk,
    input logic rst
);

    logic push, pop;
    logic [DATA_WIDTH-1:0] din;
    logic [DATA_WIDTH-1:0] dout;
    logic empty, full;
    logic [$clog2(SIZE):0] num;

    clocking mcb @(posedge clk);
        output push, pop, din;
        input empty, full, num, dout;
    endclocking: mcb

    clocking scb @(posedge clk);
        input push, pop, din;
        output empty, full, num, dout;
    endclocking: scb

    modport master_mp {
        output push, pop, din;
        input empty, full, num dout;
    };

    modport slave_mp {
        input push, pop, din;
        output empty, full, num, dout;
    };

    modport master_tb_mp (clocking mcb);
    modport slave_tb_mp (clocking scb);

endinterface: ngc_fifo_if