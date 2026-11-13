// ============================================================================
//  casez_mux.v  --  用 casez 实现的数据选择器（体现 ? 通配特性）
//
//  sel[1] = 0  -> y = a   (sel = 2'b00 / 2'b01，低位不关心)
//  sel    = 2'b10 -> y = b
//  sel    = 2'b11 -> y = c
//  sel 含 'z' 或 'x' -> y = 2'b00
//  ============================================================================

`timescale 1ns / 1ps

module casez_mux (
    input  wire [1:0] a, b, c,
    input  wire [1:0] sel,
    output reg  [1:0] y
);

    always @(*) begin
        casez (sel)
            2'b0?: y = a;  //sel[1] = 0  -> y = a(sel = 2'b00 / 2'b01，低位不关心)
            2'b10: y = b;
            2'b11: y = c;
            default: y = 2'b00;
        endcase
    end

endmodule
