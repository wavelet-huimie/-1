`timescale 1ns / 1ps

module wave_seq_tb;

    wire sig;

    wave_seq dut (
        .sig (sig)
    );

    initial begin
        #60;
        $stop;
    end

endmodule
