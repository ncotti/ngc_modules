class counter_cfg extends uvm_object;
    `uvm_object_utils(counter_cfg)

    virtual ngc_counter_if vif;

    function new(string name="", virtual ngc_counter_if vif=null);
        super.new(name);
        this.vif = vif;
    endfunction: new
endclass: counter_cfg
