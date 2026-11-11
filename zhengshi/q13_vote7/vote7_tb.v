// ============================================================================
//  vote7_tb.v  --  题 13 自测平台
//
//  7 位输入共 128 种组合，全部穷举，用自写参考模型验证。
//  ============================================================================

`timescale 1ns / 1ps

module vote7_tb;

    reg  [6:0] vote;
    wire       pass;

    integer i, j, errors, ones_count;

    vote7 dut (
        .vote (vote),
        .pass (pass)
    );

    initial begin
        errors = 0;
        $dumpfile("vote7.vcd");
        $dumpvars(0, vote7_tb);

        for (i = 0; i < 128; i = i + 1) begin
            vote = i[6:0];
            #1;

            // 参考模型：自己数 1 的个数
            ones_count = 0;
            for (j = 0; j < 7; j = j + 1)
                if (vote[j]) ones_count = ones_count + 1;

            if (pass !== (ones_count >= 4)) begin
                errors = errors + 1;
                $display("FAIL: vote=%b (%0d ones) -> pass=%b",
                         vote, ones_count, pass);
            end
        end

        if (errors == 0)
            $display("PASS  vote7 : 128/128 cases OK");
        else
            $display("FAIL  vote7 : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
