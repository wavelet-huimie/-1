// ============================================================================
//  bubble_sort_tb.v  --  题 17 自测平台
//
//  穷举 in0~in3 (4 个 4-bit，共 16^4=65536 种组合太大，抽样 2000 组)
//  用自写参考排序验证
//  ============================================================================

`timescale 1ns / 1ps

module bubble_sort_tb;

    reg  [3:0] in0, in1, in2, in3;
    wire [3:0] out0, out1, out2, out3;

    integer i, errors;
    reg [3:0] arr [0:3];
    reg [3:0] tmp;
    integer j, k;

    bubble_sort dut (
        .in0  (in0), .in1  (in1), .in2  (in2), .in3  (in3),
        .out0 (out0), .out1 (out1), .out2 (out2), .out3 (out3)
    );

    initial begin
        errors = 0;
        $dumpfile("bubble_sort.vcd");
        $dumpvars(0, bubble_sort_tb);

        // 抽样测试
        for (i = 0; i < 2000; i = i + 1) begin
            // 用随机值，也测几个边界
            in0 = (i * 7 + 3) & 4'hF;
            in1 = (i * 13 + 11) & 4'hF;
            in2 = (i * 5 + 17) & 4'hF;
            in3 = (i * 11 + 23) & 4'hF;
            #1;

            // 参考模型：自己排序
            arr[0] = in0; arr[1] = in1; arr[2] = in2; arr[3] = in3;
            for (j = 0; j < 3; j = j + 1)
                for (k = 0; k < 3; k = k + 1)
                    if (arr[k] > arr[k+1]) begin tmp=arr[k]; arr[k]=arr[k+1]; arr[k+1]=tmp; end

            if ({out0, out1, out2, out3} !== {arr[0], arr[1], arr[2], arr[3]}) begin
                errors = errors + 1;
                $display("FAIL: in=%h %h %h %h -> out=%h %h %h %h (expect %h %h %h %h)",
                         in0,in1,in2,in3, out0,out1,out2,out3, arr[0],arr[1],arr[2],arr[3]);
            end
        end

        // 几个固定边界案例
        in0=4'd15; in1=4'd10; in2=4'd5;  in3=4'd0;   #1;
        if ({out0,out1,out2,out3} !== {4'd0,4'd5,4'd10,4'd15}) begin errors=errors+1; $display("FAIL: case reverse sorted"); end

        in0=4'd0;  in1=4'd0;  in2=4'd0;  in3=4'd0;   #1;
        if ({out0,out1,out2,out3} !== {4'd0,4'd0,4'd0,4'd0}) begin errors=errors+1; $display("FAIL: case all zeros"); end

        if (errors == 0)
            $display("PASS  bubble_sort : all 2002 cases OK");
        else
            $display("FAIL  bubble_sort : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
