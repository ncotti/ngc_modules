module top_directed;
    localparam WIDTH = 8;
    localparam SIZE = 5;

    logic clk, rst;

    ngc_fifo_if #(.DATA_WIDTH(WIDTH), .SIZE(SIZE)) dif (.clk(clk), .rst(rst));
    ngc_fifo dut (dif);

    // Clock generation
    forever begin
        clk = 1'b0;
        clk ~= clk;
    end


endmodule: top_directed;


program automatic directed_tb_master(ngc_fifo_if.master_tb_mp mif);
    initial begin
        @mif.mcb;
        mif.rst <= 1'b0;
        mif.mcb.push <= 1'b0;
        mif.mcb.pop <= 1'b0;
        mif.mcb.din <= 'd0;

        @mif.mcb;
        assert(mif.mcb.empty)
        mif.rst <= 1'b0;
        mif.mcb.push <= 1'b1;
        mif.mcb.din <= 'd1;
        

    end
endprogram: directed_tb_master
