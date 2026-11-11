// ============================================================================
//  adder8.v  --  8 位二进制并行加法器（带进位输入 / 进位输出）
//
//  sum  = a + b + cin      (8 位，丢弃高位溢出)
//  cout = 第 9 位的进位
//
//  端口顺序沿用原始工程的 (cout, sum, a, b, cin)，方便已有例化代码继续使用。
// ============================================================================

`timescale 1ns / 1ps
`default_nettype none

module adder8 (
    output wire [7:0] sum,   // 和
    output wire       cout,  // 进位输出
    input  wire [7:0] a,     // 加数 A
    input  wire [7:0] b,     // 加数 B
    input  wire       cin    // 进位输入
);

    // 左侧拼接 {cout, sum} 为 9 位，Verilog 会按上下文宽度把 a、b、cin
    // 一并扩展到 9 位再相加，因此进位不会被截断（这一点容易误判为 bug）。
    assign {cout, sum} = a + b + cin;

endmodule

`default_nettype wire
