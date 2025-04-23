class counter_scoreboard extends uvm_subscriber#(counter_sequence_item);
    `uvm_component_utils(counter_scoreboard)

    string prev_tx_string;

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    function bit check_count(counter_sequence_item t);
        bit pass;

        if (t.rst)
            pass = (t.count == t.count_from_value);
        else if (t.load)
            pass = (t.count == t.load_value);
        else if (!t.enb)
            pass = (t.count == t.prev_count);
        else if ((t.count != t.count_to_value) && (t.count != t.count_from_value)) begin
            // Check for normal upwards or downwards counting
            if (t.dir == 1'b0)
                pass = (t.count == t.prev_count + t.step_value);
            else
                pass = (t.count == t.prev_count - t.step_value);
        end else begin
            // End of the counter
            if (t.count == t.count_to_value) begin
                if (t.one_shot)
                    pass = (
                        (t.prev_count == t.count_to_value) ||
                        (t.prev_count == t.count_to_value - t.step_value) ||
                        (t.prev_count == t.count_to_value + t.step_value));
                else
                    pass = ((t.prev_count == t.count_to_value - t.step_value) ||
                            (t.prev_count == t.count_to_value + t.step_value));

            // Start of the counter
            end else if (t.count == t.count_from_value) begin
                pass = 1'b1;
            end
        end

        return pass;
    endfunction: check_count

    function void write(counter_sequence_item t);
        bit pass_count, pass_count_hit;

        pass_count = this.check_count(t);
        pass_count_hit = ((t.count == t.count_to_value) == t.count_hit);

        if (pass_count && pass_count_hit)
            `uvm_info("SCOREBOARD", {"\n\tPASS: ", t.convert2string()}, UVM_HIGH)
        else
            `uvm_error("SCOREBOARD", {"FAIL:\n\t",
                "Previous: ", this.prev_tx_string, "\n\tCurrent: ",
                t.convert2string(),
                $sformatf(" count = %d, prev_count = %d, count_hit = %b",
                    t.count, t.prev_count, t.count_hit)})

        this.prev_tx_string = {t.convert2string(),
            $sformatf(" count = %d, prev_count = %d, count_hit = %b",
                t.count, t.prev_count, t.count_hit)};
    endfunction: write

endclass: counter_scoreboard