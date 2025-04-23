`ifndef __TB_COUNTER_PKG_SV
`define __TB_COUNTER_PKG_SV

package tb_counter_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "counter_cfg.svh"

    `include "counter_sequence_item.svh"
    `include "counter_sequence_item_free_running.svh"
    `include "counter_sequence_item_reset.svh"
    `include "counter_seq_loaded.svh"

    typedef uvm_sequencer#(counter_sequence_item) counter_sequencer;
    `include "counter_sequence.svh"
    `include "counter_sequence_free_running.svh"

    `include "counter_driver.svh"
    `include "counter_monitor.svh"
    `include "counter_coverage_sub.svh"
    `include "counter_scoreboard.svh"

    `include "counter_agent.svh"
    `include "counter_env.svh"
    `include "counter_test.svh"

endpackage: tb_counter_pkg

`endif // __TB_COUNTER_PKG_SV