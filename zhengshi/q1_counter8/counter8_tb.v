// ============================================================================
//  counter8_tb.v  --  题 1 自测平台
//
//  测试策略：
//    1) 先把 clr 拉高 2 个时钟，确认清零功能；
//    2) 释放 clr，连续跑 260 个时钟，期望 cnt 从 0 计到 255 后回绕到 0；
//    3) 中途再触发一次异步清零，验证 clr 与时钟无关。
//  ============================================================================

`timescale 1ns / 1ps

module counter8_tb;

    reg       clk;
    reg       clr;
    wire [7:0] cnt;

    // 被测模块
    counter8 dut (
        .clk (clk),
        .clr (clr),
        .cnt (cnt)
    );

    // 10ns 周期时钟
    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer i;
    integer errors;

    initial begin
        errors = 0;
        $dumpfile("counter8.vcd");
        $dumpvars(0, counter8_tb);

        // ---- 阶段 1：异步清零 ----
        clr = 1'b1;
        #20;               // 2 个时钟
        if (cnt !== 8'd0) begin
            errors = errors + 1;
            $display("FAIL: after clr cnt=%0d (expect 0)", cnt);
        end

        // ---- 阶段 2：连续计数 260 拍 ----
        // clr 释放后 cnt=0。第 1 个时钟后 cnt=1，第 2 个后 cnt=2……
        // 所以第 i 个时钟沿后，cnt 应该等于 i mod 256。
        clr = 1'b0;

        for (i = 1; i <= 260; i = i + 1) begin
            @(posedge clk);
            #1;             // 等非阻塞赋值生效
            if (cnt !== i[7:0]) begin
                errors = errors + 1;
                $display("FAIL: after %0d clocks, cnt=%0d (expect %0d)", i, cnt, i[7:0]);
            end
        end

        // ---- 阶段 3：中途再清零 ----
        @(posedge clk);
        clr = 1'b1;
        #1;
        if (cnt !== 8'd0) begin
            errors = errors + 1;
            $display("FAIL: async clr failed, cnt=%0d", cnt);
        end

        // ---- 汇总 ----
        if (errors == 0)
            $display("PASS  counter8 : all cases OK");
        else
            $display("FAIL  counter8 : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
