`timescale 1ns / 1ps

module factorial_tb;

    reg  [3:0]  n;
    wire [31:0] fact;

    integer i;

    factorial dut (
        .n    (n),
        .fact (fact)
    );

    initial begin
        for (i = 0; i <= 12; i = i + 1) begin
            n = i[3:0];
            #1;
        end
        $stop;
    end

endmodule
