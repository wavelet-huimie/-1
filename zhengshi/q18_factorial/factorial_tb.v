// ============================================================================
//  factorial_tb.v  --  题 18 自测平台
//
//  验证 n=0~12 的阶乘值，与硬编码的参考表比对。
//  ============================================================================

`timescale 1ns / 1ps

module factorial_tb;

    reg  [3:0]  n;
    wire [31:0] fact;

    integer i, errors;

    // 参考表：0! ~ 12!
    // 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800, 39916800, 479001600
    reg [31:0] expect [0:12];

    factorial dut (
        .n    (n),
        .fact (fact)
    );

    initial begin
        expect[0]  = 32'd1;
        expect[1]  = 32'd1;
        expect[2]  = 32'd2;
        expect[3]  = 32'd6;
        expect[4]  = 32'd24;
        expect[5]  = 32'd120;
        expect[6]  = 32'd720;
        expect[7]  = 32'd5040;
        expect[8]  = 32'd40320;
        expect[9]  = 32'd362880;
        expect[10] = 32'd3628800;
        expect[11] = 32'd39916800;
        expect[12] = 32'd479001600;

        errors = 0;
        $dumpfile("factorial.vcd");
        $dumpvars(0, factorial_tb);

        for (i = 0; i <= 12; i = i + 1) begin
            n = i[3:0];
            #1;
            $display("n=%0d  n!=%0d  (expect %0d)", n, fact, expect[i]);
            if (fact !== expect[i]) begin
                errors = errors + 1;
                $display("^ FAIL");
            end
        end

        if (errors == 0)
            $display("PASS  factorial : 13/13 cases OK");
        else
            $display("FAIL  factorial : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
