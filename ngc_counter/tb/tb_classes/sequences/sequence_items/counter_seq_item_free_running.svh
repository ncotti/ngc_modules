class counter_seq_item_free_running extends counter_seq_item;
    `uvm_object_utils(counter_seq_item_free_running)

    constraint step_value_mostly_one_never_zero_dist {
        this.step_value dist {1 :/ 90, [2:4] :/ 8, 0 :/2};
    }

    constraint always_enabled_con {
        this.enb == 1'b1;
    }

    constraint no_reset_con {
        this.rst == 1'b0;
    }

    constraint no_load_con {
        this.load == 1'b0;
    }

    function new(string name="");
        super.new();
    endfunction: new

endclass: counter_seq_item_free_running