`timescale 1ns / 1ps

module wave_seq (
    output reg sig
);

    initial begin
        sig = 1'b0;
        #10 sig = 1'b1;
        #10 sig = 1'b0;
        #10 sig = 1'b1;
        #10 sig = 1'b0;
        #10 sig = 1'b1;
    end

endmodule
