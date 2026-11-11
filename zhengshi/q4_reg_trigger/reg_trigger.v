// ============================================================================
//  reg_trigger.v  --  带异步复位的 D 触发器
//
//  使用 reg 型变量，always @(posedge clk or posedge rst) 实现。
//  reset 高电平清零，否则 clk 上升沿 Q <= D。
//  ============================================================================

`timescale 1ns / 1ps

module reg_trigger (
    input  wire clk,    // 时钟
    input  wire rst,    // 异步高电平复位
    input  wire d,      // D 输入
    output reg  q       // Q 输出（reg 型）
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule
