`timescale 1ns / 1ps

module bcd60_tb;

    reg clk, clr;
    wire [3:0] units;
    wire [2:0] tens;

    integer i;

    bcd60 dut (
        .clk   (clk),
        .clr   (clr),
        .units (units),
        .tens  (tens)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        clr = 1'b1;
        #20;
        clr = 1'b0;

        for (i = 1; i <= 125; i = i + 1) begin
            @(posedge clk);
            #1;
        end

        clr = 1'b1;
        #1;

        $stop;
    end

endmodule
