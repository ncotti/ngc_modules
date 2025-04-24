module ngc_counter (
    ngc_counter_if.slave_mp dif
);
timeunit 1ns/1ps;

logic [5:0] control;
logic [$bits(dif.count_to_value)-1:0] reg_count_to_value;
logic count_hit_async;

// Register the "count_to_value" input to avoid "count_hit" output being asynchronous (if the value
// of "count_to_value" changes in the middle of a clock cycle, count_hit would change aswell)
assign dif.count_hit = (dif.count == reg_count_to_value);

// The "count" should be updated in the next clock cycle, regardless of
// the "count_hit" output in the next cycle. Therefore, predict the "count_hit"
// asynchronously to make a decision.
assign count_hit_async = (dif.count == dif.count_to_value);

assign control = {dif.rst, dif.load, dif.enb, dif.dir,
    dif.one_shot, count_hit_async};

always_ff @(posedge dif.clk) begin
    reg_count_to_value <= dif.count_to_value;
    case (control) inside
        6'b1?????: dif.count <= dif.count_from_value;       // reset
        6'b01????: dif.count <= dif.load_value;             // load
        6'b000???: dif.count <= dif.count;                  // not enabled
        6'b0010?0: dif.count <= dif.count + dif.step_value; // count forward, enabled
        6'b0011?0: dif.count <= dif.count - dif.step_value; // count backwards, enabled
        6'b001?01: dif.count <= dif.count_from_value;       // loopback, enabled
        6'b00??11: dif.count <= dif.count;                  // one_shot mode
        default: dif.count <= dif.count;
    endcase
end

endmodule