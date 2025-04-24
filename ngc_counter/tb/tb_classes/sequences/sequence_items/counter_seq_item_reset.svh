class counter_seq_item_reset extends counter_seq_item;
    `uvm_object_utils(counter_seq_item_reset)

    constraint rst_con {
        this.rst == 1'b1;
    }

    function new(string name="");
        super.new(name);
    endfunction: new
endclass: counter_seq_item_reset