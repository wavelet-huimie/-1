// ============================================================================
//  dff_reg.v  --  用 reg 型变量生成 D 触发器
//
//  上升沿触发，异步复位
// ============================================================================

`timescale 1ns / 1ps
`default_nettype none

module dff_reg (
    output reg q,      // 输出
    input  wire d,     // D 输入
    input  wire clk,   // 时钟
    input  wire rst_n  // 异步低电平复位
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule

`default_nettype wire
