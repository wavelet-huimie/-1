// ============================================================================
//  mult8.v  --  8 位二进制乘法器
//
//  product[15:0] = a[7:0] * b[7:0]
//  Cyclone V 有内嵌乘法器块，Quartus 会自动推断使用。
//  ============================================================================

`timescale 1ns / 1ps

module mult8 (
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    output wire [15:0] product
);

    assign product = a * b;

endmodule
