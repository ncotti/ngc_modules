-work "work"
-sv
-lint=full
-pedanticerrors
-warning error
+incdir+tb/tb_classes
+incdir+tb/tb_classes/sequences
+incdir+tb/tb_classes/sequences/sequence_items
+incdir+tb/tb_classes/tests
-suppress 2286 // Implicit import of uvm_pkg
-suppress 13262 // A virtual interface element is not allowed in a sensitivity list (using @vif.cb)
"src/*.sv"
tb/ngc_counter_pkg.sv
tb/top.sv