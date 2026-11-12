`timescale 1ns / 1ps

module div_mod_tb;

    reg  [7:0] a, b;
    wire [7:0] quotient, modulus;

    integer ia, ib;

    div_mod dut (
        .a        (a),
        .b        (b),
        .quotient (quotient),
        .modulus  (modulus)
    );

    initial begin
        for (ia = 0; ia < 256; ia = ia + 1) begin
            for (ib = 1; ib < 16; ib = ib + 1) begin
                a = ia[7:0];
                b = ib[7:0];
                #1;
            end
        end
        $stop;
    end

endmodule
