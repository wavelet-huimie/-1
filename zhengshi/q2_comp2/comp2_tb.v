// ============================================================================
//  comp2_tb.v  --  题 2 自测平台
//
//  2 位输入共 4x4=16 种组合，全部穷举，与自写参考模型比对。
//  ============================================================================

`timescale 1ns / 1ps

module comp2_tb;

    reg  [1:0] a, b;
    wire       a_gt_b, a_eq_b, a_lt_b;

    integer    ia, ib;
    integer    errors;
    reg        exp_gt, exp_eq, exp_lt;

    comp2 dut (
        .a      (a),
        .b      (b),
        .a_gt_b (a_gt_b),
        .a_eq_b (a_eq_b),
        .a_lt_b (a_lt_b)
    );

    initial begin
        errors = 0;
        $dumpfile("comp2.vcd");
        $dumpvars(0, comp2_tb);

        for (ia = 0; ia < 4; ia = ia + 1) begin
            for (ib = 0; ib < 4; ib = ib + 1) begin
                a = ia[1:0];
                b = ib[1:0];
                #1;

                exp_gt = (a > b);
                exp_eq = (a == b);
                exp_lt = (a < b);

                if ({a_gt_b, a_eq_b, a_lt_b} !== {exp_gt, exp_eq, exp_lt}) begin
                    errors = errors + 1;
                    $display("FAIL: a=%0d b=%0d -> gt=%b eq=%b lt=%b (expect gt=%b eq=%b lt=%b)",
                             a, b, a_gt_b, a_eq_b, a_lt_b, exp_gt, exp_eq, exp_lt);
                end
            end
        end

        if (errors == 0)
            $display("PASS  comp2 : 16/16 cases OK");
        else
            $display("FAIL  comp2 : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
