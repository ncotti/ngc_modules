class counter_sequence extends uvm_sequence #(counter_sequence_item);
    `uvm_object_utils(counter_sequence)

    counter_sequence_item item;

    function new(string name = "");
        super.new(name);
    endfunction: new

    task body();
        repeat (1000) begin
            this.item = counter_sequence_item::type_id::create("item");
            this.start_item(this.item);
            assert(this.item.randomize());
            this.finish_item(this.item);
        end
    endtask: body
endclass: counter_sequence