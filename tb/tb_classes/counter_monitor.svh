class counter_monitor extends uvm_monitor;
    `uvm_component_utils(counter_monitor)

    uvm_analysis_port# (counter_sequence_item) counter_ap;
    virtual ngc_counter_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        counter_cfg cfg_h;
        assert(uvm_config_db #(counter_cfg)::get(this, "", "cfg", cfg_h));
        this.vif = cfg_h.vif;
        this.counter_ap = new("counter_ap", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        counter_sequence_item counter_tx;
        forever begin
            @vif.scb;
            counter_tx = counter_sequence_item::type_id::create("counter_tx");

            counter_tx.load = vif.scb.load;
            counter_tx.enb = vif.scb.enb;
            counter_tx.dir = vif.scb.dir;
            counter_tx.one_shot = vif.scb.one_shot;
            counter_tx.load_value = vif.scb.load_value;
            counter_tx.count_from_value = vif.scb.count_from_value;
            counter_tx.count_to_value = vif.scb.count_to_value;
            counter_tx.step_value = vif.scb.step_value;
            counter_tx.count = vif.mcb.count;
            counter_tx.count_hit = vif.mcb.count_hit;

            this.counter_ap.write(counter_tx);
        end
    endtask: run_phase
endclass: counter_monitor