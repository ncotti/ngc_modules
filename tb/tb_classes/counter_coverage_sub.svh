class counter_coverage_sub extends uvm_subscriber#(counter_seq_item);
    `uvm_component_utils(counter_coverage_sub)

    counter_seq_item item;

    // Counting up and down from and to different values
    covergroup count_direction_cg;
        to_cp: coverpoint item.count_to_value {
            bins any_to[] = {[$:$]};
            type_option.weight=0;
        }
        from_cp: coverpoint item.count_from_value {
            bins any_from[] = {[$:$]};
            type_option.weight=0;
        }
        dir_cp: coverpoint item.dir {
            bins any_dir[] = {[$:$]};
            type_option.weight=0;
        }

        to_from_cross: cross dir_cp, from_cp, to_cp {
            bins upwards_from_lt_to = binsof(dir_cp) intersect{0} && to_from_cross with(from_cp < to_cp);
            bins upwards_from_gt_to = binsof(dir_cp) intersect{0} && to_from_cross with(from_cp > to_cp);
            bins downwards_from_lt_to = binsof(dir_cp) intersect{1} && to_from_cross with(from_cp < to_cp);
            bins downwards_from_gt_to = binsof(dir_cp) intersect{1} && to_from_cross with(from_cp > to_cp);
            bins from_eq_to = to_from_cross with(from_cp == to_cp);
        }
    endgroup: count_direction_cg

    covergroup options_cg;
        rst_cp: coverpoint item.rst;
        dir_cp: coverpoint item.dir;
        load_cp: coverpoint item.load;
        enb_cp: coverpoint item.enb;
        one_shot_cp: coverpoint item.one_shot;

        all_options: cross rst_cp, dir_cp, load_cp, enb_cp, one_shot_cp;
    endgroup: options_cg

    covergroup step_value_cg;
        step_value_cp: coverpoint item.step_value {
            bins zero = {0};
            bins one = {1};
            bins gt_one = {[2:$]};
        }
    endgroup: step_value_cg

    function new(string name="", uvm_component parent);
        super.new(name, parent);
        this.count_direction_cg = new();
        this.options_cg = new();
        this.step_value_cg = new();
    endfunction: new

    function void write(counter_seq_item t);
        this.item = t;
        this.count_direction_cg.sample();
        this.options_cg.sample();
        this.step_value_cg.sample();
    endfunction: write
endclass: counter_coverage_sub
