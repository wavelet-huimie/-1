`timescale 1ns / 1ps

module bubble_sort_tb;

    reg  [3:0] in0, in1, in2, in3;
    wire [3:0] out0, out1, out2, out3;

    integer i;

    bubble_sort dut (
        .in0  (in0), .in1  (in1), .in2  (in2), .in3  (in3),
        .out0 (out0), .out1 (out1), .out2 (out2), .out3 (out3)
    );

    initial begin
        for (i = 0; i < 2000; i = i + 1) begin
            in0 = (i * 7 + 3) & 4'hF;
            in1 = (i * 13 + 11) & 4'hF;
            in2 = (i * 5 + 17) & 4'hF;
            in3 = (i * 11 + 23) & 4'hF;
            #1;
        end

        in0 = 4'd15; in1 = 4'd10; in2 = 4'd5;  in3 = 4'd0;   #1;
        in0 = 4'd0;  in1 = 4'd0;  in2 = 4'd0;  in3 = 4'd0;   #1;

        $stop;
    end

endmodule
