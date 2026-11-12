// ============================================================================
//  wave_par.v  --  题10：用并行块和延迟控制产生与题9相同的时序波形
//
//  仿真版本：initial + fork/join 内的 #N 绝对延迟（从 fork 时刻起算）
//  综合版本：clk 驱动的状态机，产生同样的 10ns 翻转波形
// ============================================================================

`timescale 1ns / 1ps

module wave_par (
    input  wire clk,
    input  wire rst,
    output reg  sig
);

`ifdef SYNTHESIS

    // Quartus 综合版本：用计数器产生 0/1 交替波形
    reg [2:0] cnt;

    always @(posedge clk or posedge rst) begin
        if (rst)
            cnt <= 3'd0;
        else
            cnt <= cnt + 3'd1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            sig <= 1'b0;
        else
            sig <= (cnt < 3) ? 1'b0 : 1'b1;
    end

`else

    // ModelSim 仿真版本：并行块，每条 #N 都从 fork 时刻起算
    // 要得到与顺序块相同的波形，延迟值必须写成 10/20/30/40/50
    initial fork
        sig = 1'b0;
        #10 sig = 1'b1;
        #20 sig = 1'b0;
        #30 sig = 1'b1;
        #40 sig = 1'b0;
        #50 sig = 1'b1;
    join

`endif

endmodule
