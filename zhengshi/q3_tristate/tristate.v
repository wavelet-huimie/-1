// ============================================================================
//  tristate.v  --  8 位三态驱动器
//
//  en=1 : out = in
//  en=0 : out = 8'bzzzz_zzzz
//  ============================================================================

`timescale 1ns / 1ps

module tristate (
    input  wire [7:0] in,
    input  wire       en,
    output wire [7:0] out      // tri-state output
);

    assign out = en ? in : 8'bz;

endmodule
