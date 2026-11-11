// ============================================================================
//  div_mod_tb.v  --  题 5 自测平台
//
//  穷举 a=0..255，b=1..15（避开 b=0 非法），用自写参考模型验证。
//  ============================================================================

`timescale 1ns / 1ps

module div_mod_tb;

    reg  [7:0] a, b;
    wire [7:0] quotient, modulus;

    integer ia, ib, errors;
    reg  [7:0] exp_q, exp_m;

    div_mod dut (
        .a        (a),
        .b        (b),
        .quotient (quotient),
        .modulus  (modulus)
    );

    initial begin
        errors = 0;
        $dumpfile("div_mod.vcd");
        $dumpvars(0, div_mod_tb);

        for (ia = 0; ia < 256; ia = ia + 1) begin
            for (ib = 1; ib < 16; ib = ib + 1) begin
                a = ia[7:0];
                b = ib[7:0];
                #1;

                exp_q = a / b;
                exp_m = a % b;

                if ({quotient, modulus} !== {exp_q, exp_m}) begin
                    errors = errors + 1;
                    $display("FAIL: a=%0d b=%0d -> q=%0d m=%0d (expect q=%0d m=%0d)",
                             a, b, quotient, modulus, exp_q, exp_m);
                end
            end
        end

        // 打印几个典型值做直观确认
        $display("a=20 b=4 -> q=%0d m=%0d (expect q=5 m=0)", 20/4, 20%4);
        $display("a=17 b=5 -> q=%0d m=%0d (expect q=3 m=2)", 17/5, 17%5);
        $display("a= 7 b=3 -> q=%0d m=%0d (expect q=2 m=1)",  7/3,  7%3);

        if (errors == 0)
            $display("PASS  div_mod : %0d cases OK", 256 * 15);
        else
            $display("FAIL  div_mod : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
