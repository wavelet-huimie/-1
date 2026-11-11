// ============================================================================
//  bcd60_tb.v  --  题 11 自测平台
//
//  跑 125 个时钟（覆盖完整循环 00-59-00，再跑 5 个），验证每一步。
//  ============================================================================

`timescale 1ns / 1ps

module bcd60_tb;

    reg clk, clr;
    wire [3:0] units;
    wire [2:0] tens;

    integer i, errors;
    integer decimal_val, exp_tens, exp_units;

    bcd60 dut (
        .clk   (clk),
        .clr   (clr),
        .units (units),
        .tens  (tens)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        errors = 0;
        $dumpfile("bcd60.vcd");
        $dumpvars(0, bcd60_tb);

        // 复位
        clr = 1'b1;
        #20;
        clr = 1'b0;

        // 复位后 tens/units=0，第 i 个时钟沿后十进制值应为 i mod 60
        for (i = 1; i <= 125; i = i + 1) begin
            @(posedge clk);
            #1;
            decimal_val = i % 60;
            exp_tens   = decimal_val / 10;
            exp_units  = decimal_val % 10;
            if (tens !== exp_tens[2:0] || units !== exp_units[3:0]) begin
                errors = errors + 1;
                $display("FAIL: after %0d clocks, tens=%0d units=%0d (expect tens=%0d units=%0d)",
                         i, tens, units, exp_tens, exp_units);
            end
        end

        // 中途再验一次清零
        clr = 1'b1;
        #1;
        if (tens !== 3'd0 || units !== 4'd0) begin
            errors = errors + 1;
            $display("FAIL: async clr, tens=%0d units=%0d", tens, units);
        end

        if (errors == 0)
            $display("PASS  bcd60 : all 125 steps OK");
        else
            $display("FAIL  bcd60 : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
