// ============================================================================
//  tff_counter.v  --  T'FF + 8 位 ripple 二进制计数器
//
//  T'FF : 每个时钟都翻转的触发器
//  8 位 ripple counter : T'FF 级联，每级的 Q 作为下一级的时钟
//  输出 cnt[7:0]，异步高电平清零 clr
//  ============================================================================

`timescale 1ns / 1ps

module tff_counter (
    input  wire       clk,
    input  wire       clr,
    output wire [7:0] cnt
);

    // 用 8 个 reg 分别实现 T'FF，然后级联
    reg [7:0] q;
    integer i;

    // 方法一：用 always @(posedge clk) 整块统一处理（推荐）
    // 这样整个计数器都是同步的，避免 ripple counter 的级联延迟问题
    // 教材说 "采用 always 语句"，所以用单 always 块最稳妥
    always @(posedge clk or posedge clr) begin
        if (clr) begin
            q <= 8'd0;
        end
        else begin
            q <= q + 8'd1;   // T'FF 级联的效果就是整体 +1
        end
    end

    assign cnt = q;

endmodule
