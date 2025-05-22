if [file exists "work"] {vdel -all}
vlib work

vlog -work "work" -lint=full -pedanticerrors -warning error "src/*"

##### Directed TB ######
#vlog -work "work" -lint=full -pedanticerrors -warning error "tb/directed_tb.sv"
#vsim top_directed
quit

##### UVM TB #######
vlog -f tb.f

vopt top -o top_opt +acc +cover=sbfec+top

vsim top_opt -coverage +UVM_NO_RELNOTES +UVM_TESTNAME=counter_test_free_running
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save tmp/test_free_running.ucdb

vsim top_opt -coverage +UVM_NO_RELNOTES +UVM_TESTNAME=counter_test_random
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save tmp/test_random.ucdb

vcover merge tmp/test_all.ucdb tmp/test_free_running.ucdb tmp/test_random.ucdb
vcover report tmp/test_all.ucdb -cvg

quit
