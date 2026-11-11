// ============================================================================
//  blocking_cmp.v  --  非阻塞 vs 阻塞赋值对比
//
//  两个 always @(posedge clk)，输入都是 a：
//
//  非阻塞 (<=)：
//      b_n <= a;    // 先把"当前 a"记下来
//      c_n <= b_n;  // 把"上一拍的 b_n"记下来（因为这一拍 b_n 还没真的变）
//      等价于：c_n 延迟 2 个时钟得到 a
//
//  阻塞 (=)：
//      b_b = a;     // 立即更新 b_b
//      c_b = b_b;   // b_b 已经是"当前 a"，所以 c_b = a
//      等价于：c_b 延迟 1 个时钟得到 a（c_b 相当于直接接 a）
//  ============================================================================

`timescale 1ns / 1ps

module blocking_cmp (
    input  wire       clk,
    input  wire       rst,
    input  wire [3:0] a,
    output reg  [3:0] b_n,   // non-blocking: b
    output reg  [3:0] c_n,   // non-blocking: c
    output reg  [3:0] b_b,   // blocking: b
    output reg  [3:0] c_b    // blocking: c
);

    // 非阻塞赋值
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            b_n <= 4'd0;
            c_n <= 4'd0;
        end
        else begin
            b_n <= a;
            c_n <= b_n;    // 注意：这里用的是"赋值前"的 b_n 旧值
        end
    end

    // 阻塞赋值
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            b_b <= 4'd0;
            c_b <= 4'd0;
        end
        else begin
            b_b = a;
            c_b = b_b;     // 注意：b_b 刚刚被 = a 覆盖了，所以 c_b = a
        end
    end

endmodule
