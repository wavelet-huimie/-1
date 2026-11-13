`timescale 1ns / 1ps

module wave_par (
    output reg sig
);

    initial fork
        sig = 1'b0;
        #10 sig = 1'b1;
        #20 sig = 1'b0;
        #30 sig = 1'b1;
        #40 sig = 1'b0;
        #50 sig = 1'b1;
    join

endmodule
