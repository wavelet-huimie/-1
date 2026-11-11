// ============================================================================
//  blocking_cmp_tb.v  --  题 7/8 共用测试平台
//
//  关键现象：
//    c_n 比 a 晚 2 拍    (c_n[t] = a[t-2])
//    c_b 比 a 晚 1 拍    (c_b[t] = a[t-1])
//    b_n 和 b_b 完全一样 (都是 a 晚 1 拍)
//  ============================================================================

`timescale 1ns / 1ps

module blocking_cmp_tb;

    reg clk, rst;
    reg [3:0] a;
    wire [3:0] b_n, c_n, b_b, c_b;

    integer i;

    blocking_cmp dut (
        .clk (clk),
        .rst (rst),
        .a   (a),
        .b_n (b_n),
        .c_n (c_n),
        .b_b (b_b),
        .c_b (c_b)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("blocking_cmp.vcd");
        $dumpvars(0, blocking_cmp_tb);

        rst = 1'b1;
        a   = 4'd0;
        #20;
        rst = 1'b0;

        $display("time  a   b_n c_n  b_b c_b");
        $display("---- ---- ---- ---- ---- ----");

        // 给一串递增的 a，方便肉眼对齐
        for (i = 0; i < 12; i = i + 1) begin
            a = i[3:0];
            @(posedge clk);
            #1;
            $display("%4t  %h   %h   %h   %h   %h",
                     $time, a, b_n, c_n, b_b, c_b);
        end

        // 关键验证：
        //   1) b_n == b_b  （阻塞非阻塞对单个赋值没区别）
        //   2) c_b == b_n == b_b （c_b 比 a 晚 1 拍，和 b 一样）
        //   3) c_n == "上一个时钟的 b_n"  （c_n 比 a 晚 2 拍）
        $display("");
        $display("观察要点：");
        $display("  b_n == b_b  ?  是的，对单个寄存器 <= 和 = 效果相同");
        $display("  c_b == b_n  ?  是的，c_b 只比 a 晚 1 拍");
        $display("  c_n 比 c_b 晚 1 拍  ?  是的，c_n 比 a 晚 2 拍");

        $stop;
    end

endmodule
