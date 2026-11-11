// ============================================================================
//  logic_bitwise_and_tb.v  --  题 6 自测 + 演示
//
//  核心：&& 只要 a、b 都"非零"就返回 1，否则返回 0；
//        &  逐位 AND，结果宽度跟输入一样。
//  ============================================================================

`timescale 1ns / 1ps

module logic_bitwise_and_tb;

    reg  [3:0] a, b;
    wire       logic_and;
    wire [3:0] bitwise_and;

    integer i, errors;

    logic_bitwise_and dut (
        .a           (a),
        .b           (b),
        .logic_and   (logic_and),
        .bitwise_and (bitwise_and)
    );

    initial begin
        errors = 0;
        $dumpfile("logic_bitwise_and.vcd");
        $dumpvars(0, logic_bitwise_and_tb);

        $display("  a    b   | a && b | a & b  ");
        $display("-----------+--------+---------");

        // 穷举 16x16 = 256 种组合
        for (i = 0; i < 256; i = i + 1) begin
            a = i[7:4];
            b = i[3:0];
            #1;

            // 参考模型
            if (logic_and !== ((|a) & (|b))) begin
                errors = errors + 1;
                $display("FAIL &&: a=%b b=%b got %b", a, b, logic_and);
            end
            if (bitwise_and !== (a & b)) begin
                errors = errors + 1;
                $display("FAIL & : a=%b b=%b got %b", a, b, bitwise_and);
            end

            // 每 32 组打印一行做直观观察
            if (i % 32 == 0)
                $display("  %b  %b  |   %b    | %b", a, b, logic_and, bitwise_and);
        end

        // 特别打印一个容易混淆的案例：
        $display("");
        $display("典型对比：");
        a = 4'b0011; b = 4'b1100; #1;
        $display("  a=0011 b=1100  ->  && = %b  & = %b  (&&: 都非零=1, &: 0000)",
                 logic_and, bitwise_and);

        a = 4'b0000; b = 4'b1111; #1;
        $display("  a=0000 b=1111  ->  && = %b  & = %b  (&&: a为零=0, &: 0000)",
                 logic_and, bitwise_and);

        if (errors == 0)
            $display("PASS  logic_bitwise_and : 256 cases OK");
        else
            $display("FAIL  logic_bitwise_and : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
