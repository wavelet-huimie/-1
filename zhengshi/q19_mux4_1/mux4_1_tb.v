`timescale 1ns / 1ps

module mux4_1_tb;

    reg  [3:0] d0, d1, d2, d3;
    reg  [1:0] sel;
    wire [3:0] y;

    integer i0, i1, i2, i3, isel;

    mux4_1 dut (
        .d0  (d0), .d1  (d1), .d2  (d2), .d3  (d3),
        .sel (sel),
        .y   (y)
    );

    initial begin
        for (isel = 0; isel < 4; isel = isel + 1) begin
            sel = isel[1:0];
            for (i0 = 0; i0 < 16; i0 = i0 + 1) begin
                for (i1 = 0; i1 < 16; i1 = i1 + 1) begin
                    for (i2 = 0; i2 < 16; i2 = i2 + 1) begin
                        for (i3 = 0; i3 < 16; i3 = i3 + 1) begin
                            d0 = i0[3:0];
                            d1 = i1[3:0];
                            d2 = i2[3:0];
                            d3 = i3[3:0];
                            #1;
                        end
                    end
                end
            end
        end

        $stop;
    end

endmodule
