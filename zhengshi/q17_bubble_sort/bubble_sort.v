// ============================================================================
//  bubble_sort.v  --  通过 task 调用完成 4 个 4 位数据的冒泡排序
//
//  输入 in0-in3 (4-bit each)，输出 out0-out3 (升序)
//  核心：定义一个 task sort_4，在 always @(*) 里调用
//  注意：task 不能有 # 延迟，否则不可综合
//  ============================================================================

`timescale 1ns / 1ps

module bubble_sort (
    input  wire [3:0] in0, in1, in2, in3,
    output wire [3:0] out0, out1, out2, out3
);

    // 内部暂存寄存器
    reg [3:0] a, b, c, d;

    // task：对 4 个输入冒泡排序，结果放在 a,b,c,d 里
    task sort_4;
        input  [3:0] x0, x1, x2, x3;
        output [3:0] y0, y1, y2, y3;

        reg [3:0] t0, t1, t2, t3;
        reg [3:0] tmp;
        integer j;

        begin
            t0 = x0; t1 = x1; t2 = x2; t3 = x3;

            // 共 4 轮冒泡
            for (j = 0; j < 3; j = j + 1) begin
                // 比较相邻两对
                if (t0 > t1) begin tmp = t0; t0 = t1; t1 = tmp; end
                if (t1 > t2) begin tmp = t1; t1 = t2; t2 = tmp; end
                if (t2 > t3) begin tmp = t2; t2 = t3; t3 = tmp; end
            end

            y0 = t0; y1 = t1; y2 = t2; y3 = t3;
        end
    endtask

    always @(*) begin
        sort_4(in0, in1, in2, in3, a, b, c, d);
    end

    assign out0 = a;
    assign out1 = b;
    assign out2 = c;
    assign out3 = d;

endmodule
