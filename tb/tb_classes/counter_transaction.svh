class counter_transaction extends uvm_transaction;
    `uvm_object_utils(counter_transaction)

    rand bit rst, load, enb, dir, one_shot;
    rand [7:0] bit load_val, count_to_value, count_from_value;
    rand [3:0] bit step_value;

    // constraint

    function new(string name = "");
        super.new(name);
    endfunction: new

    function string convert2string();
        super.convert2string();
    endfunction: convert2string

    function do_copy(uvm_object rhs);
        counter transaction copy_h;

        assert(rhs != null);
        assert($cast(copy_h, rhs));

        super.do_copy(rhs);

        // TODO copy behavior
    endfunction: do_copy

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        counter_transaction compared_h;

        assert(rhs != null);
        assert($cast(compared_h, rhs));

        super.do_compare(rhs, comparer);

        // TODO compare behavior
    endfunction: do_compare

endclass: counter_transaction

