`timescale 1ns / 1ps

module counter8_tb;

    reg        clk;
    reg        clr;
    wire [7:0] cnt;

    counter8 dut (
        .clk (clk),
        .clr (clr),
        .cnt (cnt)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    integer i;

    initial begin
        clr = 1'b1;
        #20;

        clr = 1'b0;
        for (i = 1; i <= 260; i = i + 1) begin
            @(posedge clk);
            #1;
        end

        @(posedge clk);
        clr = 1'b1;
        #1;

        $stop;
    end

endmodule
