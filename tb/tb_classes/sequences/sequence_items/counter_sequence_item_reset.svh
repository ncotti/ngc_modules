class counter_sequence_item_reset extends counter_sequence_item;
    `uvm_object_utils(counter_sequence_item_reset)

    constraint rst_con {
        this.rst == 1'b1;
    }

    function new(string name="");
        super.new(name);
    endfunction: new
endclass: counter_sequence_item_reset