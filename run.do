if [file exists "work"] {vdel -all}
vlib work

vlog -work "work" -lint=full -pedanticerrors -warning error "src/*"

#vlog -work "work" -lint=full -pedanticerrors -warning error "tb/directed_tb.sv"
#vsim top_directed

vlog -f tb.f
vsim top -coverage +UVM_TESTNAME=counter_test
set NoQuitOnFinish 1
onbreak {resume}
run -all

quit
