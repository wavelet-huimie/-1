// ============================================================================
//  wave_gen.v  --  顺序块 vs 并行块 产生相同时序波形
//
//  题目：
//    题9：用顺序块和延迟控制产生一个时序波形
//    题10：用并行块和延迟控制产生一个与题9相同的时序波形
//
//  编译策略：
//    SYNTHESIS 宏由 Quartus 自动定义 → 走 clk 驱动的可综合版本
//    ModelSim 默认不定义 SYNTHESIS → 走 initial + #N 延迟的仿真版本
//  ============================================================================

`timescale 1ns / 1ps

module wave_gen (
    input  wire clk,        // 仅综合版本使用
    input  wire rst,        // 仅综合版本使用
    output reg  sig_seq,    // 顺序块驱动的信号
    output reg  sig_par     // 并行块驱动的信号
);

// ---------------------------------------------------------------------------
// SYNTHESIS 版本：Quartus 走这条路，可综合
// 用 clk 驱动状态机产生相同的 50% 占空比波形
// ---------------------------------------------------------------------------
`ifdef SYNTHESIS

    reg [2:0] cnt;   // 0~5 循环

    always @(posedge clk or posedge rst) begin
        if (rst)
            cnt <= 3'd0;
        else
            cnt <= cnt + 3'd1;
    end

    // 波形：前半周期 sig=0，后半周期 sig=1
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sig_seq <= 1'b0;
            sig_par <= 1'b0;
        end
        else begin
            sig_seq <= (cnt < 3) ? 1'b0 : 1'b1;
            sig_par <= (cnt < 3) ? 1'b0 : 1'b1;
        end
    end

// ---------------------------------------------------------------------------
// SIMULATION 版本：ModelSim 走这条路，initial + #N 延迟
// ---------------------------------------------------------------------------
`else

    // ---- 题9：顺序块 ----
    // begin...end 内部 #N 是相对延迟，会累加
    initial begin
        sig_seq = 1'b0;
        #10 sig_seq = 1'b1;   // 10ns
        #10 sig_seq = 1'b0;   // 20ns
        #10 sig_seq = 1'b1;   // 30ns
        #10 sig_seq = 1'b0;   // 40ns
        #10 sig_seq = 1'b1;   // 50ns
    end

    // ---- 题10：并行块 ----
    // fork...join 内部每条 #N 都是从 fork 时刻起算的绝对延迟
    // 要产生和顺序块相同的波形，延迟值必须是 10,20,30,40,50
    initial fork
        sig_par = 1'b0;
        #10 sig_par = 1'b1;   // 10ns
        #20 sig_par = 1'b0;   // 20ns
        #30 sig_par = 1'b1;   // 30ns
        #40 sig_par = 1'b0;   // 40ns
        #50 sig_par = 1'b1;   // 50ns
    join

`endif

endmodule
