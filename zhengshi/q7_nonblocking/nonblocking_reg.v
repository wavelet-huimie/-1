// ============================================================================
//  nonblocking_reg.v  --  非阻塞赋值 (<=) 的延时特性
//
//  b <= a;    // 本拍结束才更新，用的是"当前 a"
//  c <= b;    // 用的是"赋值前的 b 旧值"
//  结果：b 比 a 晚 1 拍，c 比 a 晚 2 拍
//  ============================================================================

`timescale 1ns / 1ps

module nonblocking_reg (
    input  wire       clk,
    input  wire       rst,
    input  wire [3:0] a,
    output reg  [3:0] b,
    output reg  [3:0] c
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            b <= 4'd0;
            c <= 4'd0;
        end
        else begin
            b <= a;
            c <= b;      // 右侧的 b 是这一拍还没更新的旧值
        end
    end

endmodule
