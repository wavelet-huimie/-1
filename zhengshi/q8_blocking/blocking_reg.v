// ============================================================================
//  blocking_reg.v  --  阻塞赋值 (=) 的延时特性
//
//  b = a;     // 立即生效
//  c = b;     // b 已经是本拍的 a，所以 c 也等于 a
//  结果：b 比 a 晚 1 拍，c 与 a 同一拍
//  ============================================================================

`timescale 1ns / 1ps

module blocking_reg (
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
            b = a;
            c = b;       // 上一条已经用 = 更新了 b，这里拿到的就是本拍 a
        end
    end

endmodule
