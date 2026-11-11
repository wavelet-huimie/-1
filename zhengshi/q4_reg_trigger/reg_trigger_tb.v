// ============================================================================
//  reg_trigger_tb.v  --  题 4 自测平台
//
//  测试：复位功能、clk 上升沿采样 d→q、复位与 clk 异步关系。
//  ============================================================================

`timescale 1ns / 1ps

module reg_trigger_tb;

    reg  clk, rst, d;
    wire q;

    integer i, errors;

    reg_trigger dut (
        .clk (clk),
        .rst (rst),
        .d   (d),
        .q   (q)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        errors = 0;
        $dumpfile("reg_trigger.vcd");
        $dumpvars(0, reg_trigger_tb);

        // ---- 复位测试 ----
        rst = 1'b1;
        d   = 1'b1;
        #20;               // 无论 d=1 还是时钟，rst 优先级最高
        if (q !== 1'b0) begin
            errors = errors + 1;
            $display("FAIL: reset failed, q=%b", q);
        end

        // ---- 正常采样 ----
        rst = 1'b0;
        for (i = 0; i < 10; i = i + 1) begin
            d = i[0];          // 交替 0 和 1
            @(posedge clk);
            #1;
            if (q !== d) begin
                errors = errors + 1;
                $display("FAIL: after clk d=%b q=%b", d, q);
            end
        end

        // ---- 复位与 clk 异步：复位期间加一个 d=1，q 仍应 0 ----
        rst = 1'b1;
        d   = 1'b1;
        @(posedge clk);     // 上升沿来的时候 rst 还高
        #1;
        if (q !== 1'b0) begin
            errors = errors + 1;
            $display("FAIL: async reset over clk edge, q=%b", q);
        end

        if (errors == 0)
            $display("PASS  reg_trigger : all cases OK");
        else
            $display("FAIL  reg_trigger : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
