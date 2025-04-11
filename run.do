if [file exists "work"] {vdel -all}
vlib work

vlog -work "work" -lint=full -pedanticerrors -warning error "src/*"


vlog -work "work" -lint=full -pedanticerrors -warning error "tb/*.sv"

vsim top_directed
set NoQuitOnFinish 1
onbreak {resume}
run -all

quit
