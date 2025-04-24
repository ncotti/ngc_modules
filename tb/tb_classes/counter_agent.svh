class counter_agent extends uvm_agent;
    `uvm_component_utils(counter_agent)

    uvm_analysis_port#(counter_seq_item) counter_ap;

    counter_seqr sequencer_h;
    counter_driver driver_h;
    counter_monitor monitor_h;

    function new(string name="", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        counter_ap = new("counter_ap", this);
        sequencer_h = counter_seqr::type_id::create("sequencer_h", this);
        driver_h = counter_driver::type_id::create("driver_h", this);
        monitor_h = counter_monitor::type_id::create("monitor_h", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
        monitor_h.counter_ap.connect(this.counter_ap);
    endfunction: connect_phase
endclass: counter_agent
