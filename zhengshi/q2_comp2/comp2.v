// ============================================================================
//  comp2.v  --  2 位数值比较器
//
//  a_gt_b : a > b
//  a_eq_b : a == b
//  a_lt_b : a < b
//  ============================================================================

`timescale 1ns / 1ps

module comp2 (
    input  wire [1:0] a,
    input  wire [1:0] b,
    output wire       a_gt_b,
    output wire       a_eq_b,
    output wire       a_lt_b
);

    assign a_gt_b = (a > b);
    assign a_eq_b = (a == b);
    assign a_lt_b = (a < b);

endmodule
