`timescale 1ns / 1ps

module wave_par_tb;

    reg  clk;
    reg  rst;
    wire sig;

    wave_par dut (
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
