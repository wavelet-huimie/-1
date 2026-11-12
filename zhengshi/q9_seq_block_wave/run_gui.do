# ============================================================
#  run_gui.do -- ModelSim one-click simulation script
#
#  Usage:
#    A) Double-click open_sim.bat in this folder (easiest)
#    B) Command line: vsim -gui -do run_gui.do
#    C) In GUI: File -> Change Directory to this folder,
#            then File -> Open and select run_gui.do
#
#  Notes:
#    -voptargs=+acc  keep all signals visible in waveform window
#    tb ends with $stop to pause and retain signal values
# ============================================================

onerror {resume}

# 1) Rebuild work library
quietly vdel -all -lib work
quietly vlib work

# 2) Compile DUT and testbench
quietly vlog *.v

# 3) Load testbench
vsim -voptargs=+acc wave_gen_tb

# 4) Add all signals to waveform
add wave -r /wave_gen_tb/*

# 5) Run
run -all