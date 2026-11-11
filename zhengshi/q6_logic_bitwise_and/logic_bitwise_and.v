// ============================================================================
//  logic_bitwise_and.v  --  逻辑与 && vs 按位与 & 对比
//
//  输入 a、b 各 4 位，同时给出两种运算的结果：
//    logic_and  = a && b   (1 位，整体逻辑与)
//    bitwise_and = a & b   (4 位，逐位相与)
//  ============================================================================

`timescale 1ns / 1ps

module logic_bitwise_and (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire       logic_and,    // 1 位
    output wire [3:0] bitwise_and   // 4 位
);

    assign logic_and  = a && b;
    assign bitwise_and = a & b;

endmodule
