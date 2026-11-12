`timescale 1ns / 1ps

module wave_seq_tb;

    reg  clk;
    reg  rst;
    wire sig;

    wave_seq dut (
        .clk (clk),
        .rst (rst),
        .sig (sig)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial rst = 1'b0;

    initial begin
        #60;
        $stop;
    end

endmodule
