# ============================================================
#  run_gui.do -- ModelSim one-click simulation script
#
#  Usage:
#    A) Double-click open_sim.bat in this folder (easiest)
#    B) Command line: vsim -gui -do run_gui.do
#    C) In GUI: File -> Change Directory to this folder,
#            then File -> Open and select run_gui.do
# ============================================================

onerror {resume}

# 1) Rebuild work library
if {[file exists work]} { quietly vdel -all -lib work }
quietly vlib work

# 2) Compile DUT and testbench
quietly vlog *.v

# 3) Load testbench
vsim -voptargs=+acc wave_par_tb

# 4) Add testbench-level signals to waveform
add wave /wave_par_tb/*

# 5) Run
run -all
