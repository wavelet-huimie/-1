// ============================================================================
//  mux4_1.v  --  4 选 1 数据选择器
//
//  sel = 00 -> y = d0
//  sel = 01 -> y = d1
//  sel = 10 -> y = d2
//  sel = 11 -> y = d3
//  ============================================================================

`timescale 1ns / 1ps

module mux4_1 (
    input  wire [3:0] d0, d1, d2, d3,
    input  wire [1:0] sel,
    output reg  [3:0] y
);

    always @(*) begin
        case (sel)
            2'b00: y = d0;
            2'b01: y = d1;
            2'b10: y = d2;
            2'b11: y = d3;
            default: y = 4'b0000;
        endcase
    end

endmodule
