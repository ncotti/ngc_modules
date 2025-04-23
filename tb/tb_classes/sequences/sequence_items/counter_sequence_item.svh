class counter_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(counter_sequence_item)

    // Inputs of the DUT
    rand bit rst, load, enb, dir, one_shot;
    rand bit [7:0] load_value, count_from_value;
    rand bit [7:0] count_to_value;
    rand bit [3:0] step_value;

    bit [7:0] prev_count;

    // Outputs of the DUT
    bit [7:0] count;
    bit count_hit;

    function new(string name = "");
        super.new(name);
    endfunction: new

    function string convert2string();
        string s;
        s = super.convert2string();
        return {s, $sformatf("control = %b count_to_value = %d count_from_value = %d", {rst, load, enb, dir, one_shot}, count_to_value, count_from_value)};
    endfunction: convert2string

    function void do_copy(uvm_object rhs);
        counter_sequence_item copy_h;

        assert(rhs != null);
        assert($cast(copy_h, rhs));

        super.do_copy(rhs);
        this.rst = copy_h.rst;
        this.load = copy_h.load;
        this.enb = copy_h.enb;
        this.dir = copy_h.dir;
        this.load_value = copy_h.load_value;
        this.count_from_value = copy_h.count_from_value;
        this.count_to_value = copy_h.count_to_value;
        this.step_value = copy_h.step_value;
    endfunction: do_copy

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        counter_sequence_item compared_h;

        if (
            (rhs == null) ||
            (!$cast(compared_h, rhs))
        )
            return 1'b0;
        else
            return (
                super.do_compare(rhs, comparer) &&
                (this.rst == compared_h.rst) &&
                (this.load == compared_h.load) &&
                (this.enb == compared_h.enb) &&
                (this.dir == compared_h.dir) &&
                (this.load_value == compared_h.load_value) &&
                (this.count_from_value == compared_h.count_from_value) &&
                (this.count_to_value == compared_h.count_to_value) &&
                (this.step_value == this.step_value)
            );
    endfunction: do_compare

endclass: counter_sequence_item
