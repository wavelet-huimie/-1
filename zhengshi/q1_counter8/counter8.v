// ============================================================================
//  counter8.v  --  8 位二进制加法计数器
//
//  功能：时钟上升沿 cnt 自增 1，异步清零 clr 高电平有效。
//  ============================================================================

`timescale 1ns / 1ps

module counter8 (
    input  wire       clk,    // 时钟，上升沿有效
    input  wire       clr,    // 异步清零，高电平有效
    output reg  [7:0] cnt     // 8 位计数输出
);

    always @(posedge clk or posedge clr) begin
        if (clr)
            cnt <= 8'd0;
        else
            cnt <= cnt + 8'd1;
    end

endmodule
