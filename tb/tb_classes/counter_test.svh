class counter_test extends uvm_test;
    `uvm_component_utils(counter_test)

    counter_env env_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        this.env_h = counter_env::type_id::create("counter_env", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        counter_sequence seq_h;

        phase.raise_objection(this);
        seq_h = counter_sequence::type_id::create("seq_h");
        `uvm_info("TEST", "Starting sequence...", UVM_LOW);
        seq_h.start(this.env_h.agent_h.sequencer_h);
        #10ns;

        `uvm_info("TEST", "Dropping objection...", UVM_LOW);
        phase.drop_objection(this);

        `uvm_info("TEST", "END of test...", UVM_LOW);
    endtask: run_phase
endclass: counter_test