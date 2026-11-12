`timescale 1ns / 1ps

module tristate_tb;

    reg  [7:0] in;
    reg        en;
    wire [7:0] out;

    integer    i;

    tristate dut (
        .in  (in),
        .en  (en),
        .out (out)
    );

    initial begin
        en = 1'b1;
        for (i = 0; i < 256; i = i + 1) begin
            in = i[7:0];
            #1;
        end

        en = 1'b0;
        for (i = 0; i < 8; i = i + 1) begin
            in = i[7:0];
            #1;
        end

        $stop;
    end

endmodule
