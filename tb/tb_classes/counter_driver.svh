class counter_driver extends uvm_driver# (counter_sequence_item);
    `uvm_component_utils(counter_driver)

    virtual ngc_counter_if vif;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        counter_cfg cfg_h;
        assert(uvm_config_db #(counter_cfg)::get(this, "", "cfg", cfg_h));
        this.vif = cfg_h.vif;
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        counter_sequence_item counter_tx;
        @(vif.mcb);
        this.seq_item_port.get_next_item(counter_tx);
        vif.mcb.rst <= 1'b1;
        vif.mcb.load <= counter_tx.load;
        vif.mcb.enb <= counter_tx.enb;
        vif.mcb.dir <= counter_tx.dir;
        vif.mcb.one_shot <= counter_tx.one_shot;
        vif.mcb.load_value <= counter_tx.load_value;
        vif.mcb.count_from_value <= counter_tx.count_from_value;
        vif.mcb.count_to_value <= counter_tx.count_to_value;
        vif.mcb.step_value <= counter_tx.step_value;
        @(vif.mcb);
        vif.mcb.rst <= counter_tx.rst;
        repeat(25) @vif.mcb;
    endtask: run_phase

endclass: counter_driver