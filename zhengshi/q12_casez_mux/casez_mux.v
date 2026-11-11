// ============================================================================
//  casez_mux.v  --  用 casez 实现的数据选择器
//
//  sel  = 2'b00  -> y = a
//  sel  = 2'b01  -> y = b
//  sel  = 2'b10  -> y = c
//  sel  = 2'b11  -> y = d
//  sel  = 2'b0z, 2'bz0 ... 等  -> y = a (default 含 'z' 或 'x')
//  casez 把 'z' 视为"不关心"，可用来匹配多位输入的某些位。
//  ============================================================================

`timescale 1ns / 1ps

module casez_mux (
    input  wire [3:0] a, b, c, d,
    input  wire [1:0] sel,
    output reg  [3:0] y
);

    always @(*) begin
        casez (sel)
            2'b00: y = a;
            2'b01: y = b;
            2'b10: y = c;
            2'b11: y = d;
            default: y = 4'b0000;
        endcase
    end

endmodule
