class counter_env extends uvm_env;
    `uvm_component_utils(counter_env);

    counter_agent agent_h;
    counter_coverage_sub coverage_sub_h;
    counter_scoreboard scoreboard_h;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        scoreboard_h = counter_scoreboard::type_id::create("scoreboard_h", this);
        agent_h = counter_agent::type_id::create("agent_h", this);
        coverage_sub_h = counter_coverage_sub::type_id::create("coverage_sub_h", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent_h.counter_ap.connect(coverage_sub_h.analysis_export);
        agent_h.counter_ap.connect(scoreboard_h.analysis_export);
    endfunction: connect_phase
endclass: counter_env