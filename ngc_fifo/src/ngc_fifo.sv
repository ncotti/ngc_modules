module ngc_fifo (ngc_fifo_if.slave_mp dif);

    // Circular buffer
    logic [DATA_WIDTH-1:0] circular_buffer [SIZE-1:0];
    logic [$clog2(SIZE)-1:0] read_index, write_index;
    logic read_ok, write_ok;

    assign empty = (dout == 'd0);
    assign full = (dout == SIZE);

    assign read_ok = (pop && !empty);
    assign write_ok = (push && !full);


    always_ff @(posedge clk) begin
        if (rst) begin
            empty <= 1'b1;
            full <= 1'b0;
            num <= 'd0;
            read_index <= 'd0;
            write_index <= 'd0;
            dout <= 'd0;
        end else begin

            // Reading
            if (read_ok) begin
                dout <= circular_buffer[read_index];

                if (read_index == SIZE-1)
                    read_index <= 'd0;
                else
                    read_index <= read_index + 1;
            end else begin
                dout <= dout;
                read_index <= read_index;
            end

            // Writing
            if (write_ok) begin
                circular_buffer[write_index] <= din;

                if (write_index == SIZE-1)
                    write_index <= 'd0;
                else
                    write_index <= write_index + 1;
            end else begin
                write_index <= write_index;
            end

            case ({read_ok, write_ok})
                2'b00: num <= num;
                2'b01: num <= num + 1;
                2'b10: num <= num - 1;
                2'b11: num <= num;
            endcase
        end
    end

endmodule: ngc_fifo