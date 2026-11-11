// ============================================================================
//  adder8_tb.v  --  adder8 的自检测试平台（仅用于仿真，不加入 Quartus 工程）
//
//  使用方法（ModelSim）：
//      vlib work
//      vlog adder8.v adder8_tb.v
//      vsim -c adder8_tb -do "run -all; quit -f"
//
//  采用穷举法：遍历 a(0~255) x b(0~255) x cin(0~1) 共 131072 种输入组合，
//  与参考模型逐项比对，出错立即打印。
// ============================================================================

`timescale 1ns / 1ps

module adder8_tb;

    reg  [7:0] a, b;
    reg        cin;
    wire [7:0] sum;
    wire       cout;

    integer    ia, ib, ic;
    integer    errors;
    reg [8:0]  expect;   // 参考模型：9 位无符号结果

    // 被测模块
    adder8 dut (
        .cout (cout),
        .sum  (sum),
        .a    (a),
        .b    (b),
        .cin  (cin)
    );

    initial begin
        errors = 0;

        for (ia = 0; ia < 256; ia = ia + 1) begin
            for (ib = 0; ib < 256; ib = ib + 1) begin
                for (ic = 0; ic < 2; ic = ic + 1) begin
                    a   = ia[7:0];
                    b   = ib[7:0];
                    cin = ic[0];
                    #1;                       // 组合逻辑，1ns 后即可观察

                    expect = a + b + cin;     // 9 位，天然带进位

                    if ({cout, sum} !== expect) begin
                        errors = errors + 1;
                        $display("FAIL: a=%0d b=%0d cin=%0d -> {cout,sum}=%b_%b (expect %b)",
                                 a, b, cin, cout, sum, expect);
                    end
                end
            end
        end

        if (errors == 0) begin
            $display("========================================");
            $display("  PASS  adder8 : 131072 / 131072 cases OK");
            $display("========================================");
        end
        else begin
            $display("========================================");
            $display("  FAIL  adder8 : %0d mismatch(es)", errors);
            $display("========================================");
        end

        $finish;
    end

endmodule
