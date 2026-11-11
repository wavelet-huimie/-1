// ============================================================================
//  div_mod.v  --  8 位除法 / 求模运算（仅仿真，不建议综合）
//
//  quotient = a / b   （整数除法，截断小数部分）
//  modulus  = a % b   （a 对 b 取余）
//
//  注：ASIC/FPGA 上直接用 / 和 % 会推导出复杂的除法器树，
//  这里只为了满足"仿真"题意。Quartus 综合时会警告。
//  ============================================================================

`timescale 1ns / 1ps

module div_mod (
    input  wire [7:0] a,
    input  wire [7:0] b,
    output wire [7:0] quotient,
    output wire [7:0] modulus
);

    assign quotient = a / b;
    assign modulus  = a % b;

endmodule
