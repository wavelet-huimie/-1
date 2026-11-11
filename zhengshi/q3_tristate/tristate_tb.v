// ============================================================================
//  tristate_tb.v  --  题 3 自测平台
//  ============================================================================

`timescale 1ns / 1ps

module tristate_tb;

    reg  [7:0] in;
    reg        en;
    wire [7:0] out;

    integer    i;
    integer    errors;

    tristate dut (
        .in (in),
        .en (en),
        .out (out)
    );

    initial begin
        errors = 0;
        $dumpfile("tristate.vcd");
        $dumpvars(0, tristate_tb);

        // en=1 时，out 应等于 in
        en = 1'b1;
        for (i = 0; i < 256; i = i + 1) begin
            in = i[7:0];
            #1;
            if (out !== in) begin
                errors = errors + 1;
                $display("FAIL: en=1 in=%b out=%b", in, out);
            end
        end

        // en=0 时，out 应为高阻
        en = 1'b0;
        for (i = 0; i < 8; i = i + 1) begin
            in = i[7:0];
            #1;
            if (out !== 8'bzzzz_zzzz) begin
                errors = errors + 1;
                $display("FAIL: en=0 in=%b out=%b (expect zzzz_zzzz)", in, out);
            end
        end

        if (errors == 0)
            $display("PASS  tristate : all cases OK");
        else
            $display("FAIL  tristate : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
