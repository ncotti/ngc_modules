if [file exists "work"] {vdel -all}
vlib work

vlog -work "work" -lint=full -pedanticerrors -warning error "src/*"

#vlog -work "work" -lint=full -pedanticerrors -warning error "tb/directed_tb.sv"
#vsim top_directed

vlog -f tb.f

vopt top -o top_opt +acc +cover=sbfec+top

vsim top_opt -coverage +UVM_NO_RELNOTES +UVM_TESTNAME=counter_test

set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all

coverage save tmp/cover_file.ucdb
vcover report tmp/cover_file.ucdb -cvg -details

quit
