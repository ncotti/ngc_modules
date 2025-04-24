`ifndef __NGC_COUNTER_PKG_SV
`define __NGC_COUNTER_PKG_SV

package ngc_counter_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    parameter COUNTER_WIDTH = 8;

    `include "counter_cfg.svh"

    // Sequence items
    `include "counter_seq_item.svh"
    `include "counter_seq_item_free_running.svh"
    `include "counter_seq_item_reset.svh"
    `include "counter_seq_item_random.svh"

    // Sequences
    typedef uvm_sequencer#(counter_seq_item) counter_sequencer;
    `include "counter_seq_free_running.svh"
    `include "counter_seq_random.svh"

    // Testbench components
    `include "counter_driver.svh"
    `include "counter_monitor.svh"
    `include "counter_coverage_sub.svh"
    `include "counter_scoreboard.svh"

    // High level wrappers
    `include "counter_agent.svh"
    `include "counter_env.svh"

    // Tests
    `include "counter_test_free_running.svh"
    `include "counter_test_random.svh"

endpackage: ngc_counter_pkg

`endif // __NGC_COUNTER_PKG_SV