class counter_coverage_sub extends uvm_subscriber#(counter_sequence_item);
    `uvm_component_utils(counter_coverage_sub)

    counter_sequence_item item;

    covergroup count_to_cg;
        coverpoint item.count_to_value;
    endgroup: count_to_cg

    function new(string name="", uvm_component parent);
        super.new(name, parent);
        this.count_to_cg = new();
    endfunction: new

    function void write(counter_sequence_item t);
        this.item = t;
        this.count_to_cg.sample();
    endfunction: write
endclass: counter_coverage_sub
