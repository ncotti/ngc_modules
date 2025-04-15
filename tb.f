-work "work"
-sv
-lint=full
-pedanticerrors
-warning error
+incdir+tb/tb_classes
-suppress 2286 // Implicit import of uvm_pkg
-suppress 13262 // A virtual interface element is not allowed in a sensitivity list (using @vif.cb)
"src/*.sv" 
tb/tb_counter_pkg.sv
tb/top.sv