`timescale 1ns / 1ps

module vote7_tb;

    reg  [6:0] vote;
    wire       pass;

    integer i;

    vote7 dut (
        .vote (vote),
        .pass (pass)
    );

    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            vote = i[6:0];
            #1;
        end
        $stop;
    end

endmodule
