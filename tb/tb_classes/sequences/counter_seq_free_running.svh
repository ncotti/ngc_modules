class counter_seq_free_running extends uvm_sequence #(counter_seq_item);
    `uvm_object_utils(counter_seq_free_running)

    counter_seq_item_random random_item;
    counter_seq_item_free_running free_item;
    counter_seq_item_reset reset_item;

    function new(string name="");
        super.new(name);
    endfunction: new

    task body();
        repeat(100) begin
            reset_item = counter_seq_item_reset::type_id::create("reset_item");
            free_item = counter_seq_item_free_running::type_id::create("free_item");

            this.start_item(reset_item);
            assert(reset_item.randomize());
            this.finish_item(reset_item);

            this.start_item(free_item);
            assert(free_item.randomize());
            this.finish_item(free_item);
        end

        repeat(800) begin
            random_item = counter_seq_item_random::type_id::create("random_item");

            this.start_item(random_item);
            assert(random_item.randomize());
            this.finish_item(random_item);
        end
    endtask: body
endclass: counter_seq_free_running