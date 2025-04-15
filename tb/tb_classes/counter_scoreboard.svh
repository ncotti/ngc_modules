class counter_scoreboard extends uvm_subscriber#(counter_sequence_item);
    `uvm_component_utils(counter_scoreboard)

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    function void write(counter_sequence_item t);
        `uvm_info("scoreboard", t.convert2string(), UVM_HIGH);
    endfunction: write

endclass: counter_scoreboard