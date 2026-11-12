`timescale 1ns / 1ps

module tff_counter_tb;

    reg clk, clr;
    wire [7:0] cnt;

    integer i;

    tff_counter dut (
        .clk (clk),
        .clr (clr),
        .cnt (cnt)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        clr = 1'b1;
        #20;
        clr = 1'b0;

        for (i = 1; i <= 515; i = i + 1) begin
            @(posedge clk);
            #1;
        end

        clr = 1'b1;
        #1;

        $stop;
    end

endmodule
