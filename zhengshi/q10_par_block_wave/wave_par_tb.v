`timescale 1ns / 1ps

module wave_par_tb;

    wire sig;

    wave_par dut (
        .sig (sig)
    );

    initial begin
        #60;
        $stop;
    end

endmodule
