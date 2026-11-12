`timescale 1ns / 1ps

module logic_bitwise_and_tb;

    reg  [3:0] a, b;
    wire       logic_and;
    wire [3:0] bitwise_and;

    integer i;

    logic_bitwise_and dut (
        .a           (a),
        .b           (b),
        .logic_and   (logic_and),
        .bitwise_and (bitwise_and)
    );

    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            a = i[7:4];
            b = i[3:0];
            #1;
        end
        $stop;
    end

endmodule
