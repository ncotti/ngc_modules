class counter_seq_item_random extends counter_seq_item;
    `uvm_object_utils(counter_seq_item_random)

    constraint rst_con {
        this.rst dist {0 := 90, 1 := 10};
    }

    constraint enb_con {
        this.enb dist {0 := 10, 1 := 90};
    }

    constraint load_con {
        this.load dist {0 := 80, 1 := 20};
    }

    function new(string name="");
        super.new();
    endfunction: new
endclass: counter_seq_item_random