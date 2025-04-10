module ngc_counter (
    ngc_counter_if.slave_mp dif
);
timeunit 1ns/1ps;

logic [5:0] control;

assign dif.count_hit = (dif.count == dif.count_to_value);

assign control = {dif.rst, dif.load, dif.enb, dif.dir,
    dif.one_shot, dif.count_hit};

always_ff @(posedge dif.clk) begin
    case (control) inside
        6'b1?????: dif.count <= dif.count_from_value;   // reset
        6'b01????: dif.count <= dif.load_value;           // load
        6'b000???: dif.count <= dif.count;              // not enabled
        6'b0010?0: dif.count <= dif.count + dif.step_value; // count forward, enabled
        6'b0011?0: dif.count <= dif.count - dif.step_value; // count backwards, enabled
        6'b001?01: dif.count <= dif.count_from_value;   // loopback, enabled
        6'b00??11: dif.count <= dif.count;              // one_shot mode
        default: dif.count <= dif.count;
    endcase
end

endmodule