`timescale 1ns / 1ps

module wave_gen_tb;

    wire sig_seq, sig_par;
    integer i;

    reg clk, rst;
    initial clk = 0;
    always #5 clk = ~clk;
    initial rst = 0;

    wave_gen dut (
        .clk     (clk),
        .rst     (rst),
        .sig_seq (sig_seq),
        .sig_par (sig_par)
    );

    initial begin
        for (i = 0; i <= 60; i = i + 1) begin
            #1;
        end
        $stop;
    end

endmodule
