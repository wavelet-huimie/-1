# ============================================================
#  run_gui.do -- ModelSim 一键仿真脚本
#
#  打开方式：
#    A) 双击本目录的 open_sim.bat（最省事）
#    B) 命令行：vsim -gui -do run_gui.do
#    C) GUI：File -> Change Directory 选本目录，
#            再 File -> Open 选 run_gui.do
#
#  说明：
#    -voptargs=+acc  保留所有信号，波形窗口才看得到
#    tb 结尾用 $stop 暂停，信号保留，可继续 run
# ============================================================

onerror {resume}

# 1) 重建工作库
quietly vdel -all -lib work
quietly vlib work

# 2) 编译 DUT 与 testbench
quietly vlog *.v

# 3) 加载 testbench
vsim -voptargs=+acc vote7_tb

# 4) 全部信号加入波形
add wave -r /vote7_tb/*

# 5) 运行
run -all