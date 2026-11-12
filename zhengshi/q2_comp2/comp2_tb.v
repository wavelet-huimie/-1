`timescale 1ns / 1ps

module comp2_tb;

    reg  [1:0] a, b;
    wire       a_gt_b, a_eq_b, a_lt_b;

    integer    ia, ib;

    comp2 dut (
        .a      (a),
        .b      (b),
        .a_gt_b (a_gt_b),
        .a_eq_b (a_eq_b),
        .a_lt_b (a_lt_b)
    );

    initial begin
        for (ia = 0; ia < 4; ia = ia + 1) begin
            for (ib = 0; ib < 4; ib = ib + 1) begin
                a = ia[1:0];
                b = ib[1:0];
                #1;
            end
        end
        $stop;
    end

endmodule
