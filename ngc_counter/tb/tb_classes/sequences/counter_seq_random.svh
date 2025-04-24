class counter_seq_random extends uvm_sequence #(counter_seq_item);
    `uvm_object_utils(counter_seq_random)

    counter_seq_item_random random_item;
    counter_seq_item_reset reset_item;

    function new(string name = "");
        super.new(name);
    endfunction: new

    task body();
        repeat(1000) begin
            random_item = counter_seq_item_random::type_id::create("random_item");
            reset_item = counter_seq_item_reset::type_id::create("reset_item");

            this.start_item(reset_item);
            assert(reset_item.randomize());
            this.finish_item(reset_item);

            this.start_item(random_item);
            assert(random_item.randomize());
            this.finish_item(random_item);
        end
    endtask: body
endclass: counter_seq_random