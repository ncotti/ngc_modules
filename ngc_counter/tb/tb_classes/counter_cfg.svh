class counter_cfg extends uvm_object;
    `uvm_object_utils(counter_cfg)

    virtual ngc_counter_if vif;
    int unsigned clock_cycles_simulated_per_transaction;

    function new(string name="", virtual ngc_counter_if vif=null);
        super.new(name);
        this.vif = vif;
        this.clock_cycles_simulated_per_transaction = 1000;
    endfunction: new
endclass: counter_cfg
