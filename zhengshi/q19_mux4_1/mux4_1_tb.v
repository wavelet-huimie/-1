`timescale 1ns / 1ps

module mux4_1_tb;

    reg  [3:0] d0, d1, d2, d3;
    reg  [1:0] sel;
    wire [3:0] y;

    integer i, j;

    mux4_1 dut (
        .d0  (d0), .d1  (d1), .d2  (d2), .d3  (d3),
        .sel (sel),
        .y   (y)
    );

    initial begin
        for (sel = 2'b00; sel < 2'b11; sel = sel + 1) begin
            for (i = 0; i < 256; i = i + 1) begin
                d0 = i[3:0]; d1 = i[7:4];
                d2 = (i * 3) & 4'hF; d3 = (i * 7 + 1) & 4'hF;
                for (j = 0; j < 2; j = j + 1) begin
                    #1;
                end
            end
        end
        sel = 2'b11;
        for (i = 0; i < 256; i = i + 1) begin
            d0 = i[3:0]; d1 = i[7:4];
            d2 = (i * 3) & 4'hF; d3 = (i * 7 + 1) & 4'hF;
            #1;
        end

        $stop;
    end

endmodule
