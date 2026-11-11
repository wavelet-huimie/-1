// ============================================================================
//  bit_counter_tb.v  --  题 15 自测平台
//
//  8 位输入共 256 种组合，全部穷举，用自写参考模型验证。
//  ============================================================================

`timescale 1ns / 1ps

module bit_counter_tb;

    reg  [7:0] data;
    wire [3:0] count;

    integer i, j, errors, exp_count;

    bit_counter dut (
        .data  (data),
        .count (count)
    );

    initial begin
        errors = 0;
        $dumpfile("bit_counter.vcd");
        $dumpvars(0, bit_counter_tb);

        for (i = 0; i < 256; i = i + 1) begin
            data = i[7:0];
            #1;

            exp_count = 0;
            for (j = 0; j < 8; j = j + 1)
                if (data[j]) exp_count = exp_count + 1;

            if (count !== exp_count[3:0]) begin
                errors = errors + 1;
                $display("FAIL: data=%b -> count=%0d (expect %0d)",
                         data, count, exp_count);
            end
        end

        if (errors == 0)
            $display("PASS  bit_counter : 256/256 cases OK");
        else
            $display("FAIL  bit_counter : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
