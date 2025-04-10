if [file exists "work"] {vdel -all}
vlib work

vlog -work "work" -lint=full -pedanticerrors "src/*"


vlog -work "work" -lint=full -pedanticerrors "tb/*.sv"

vsim top_directed
set NoQuitOnFinish 1
onbreak {resume}
run -all

quit
