`timescale 1ns / 1ps

module bit_counter_tb;

    reg  [7:0] data;
    wire [3:0] count;

    integer i;

    bit_counter dut (
        .data  (data),
        .count (count)
    );

    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            data = i[7:0];
            #1;
        end
        $stop;
    end

endmodule
