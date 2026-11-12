`timescale 1ns / 1ps

module reg_trigger_tb;

    reg  clk, rst, d;
    wire q;

    integer i;

    reg_trigger dut (
        .clk (clk),
        .rst (rst),
        .d   (d),
        .q   (q)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        d   = 1'b1;
        #20;

        rst = 1'b0;
        for (i = 0; i < 10; i = i + 1) begin
            d = i[0];
            @(posedge clk);
            #1;
        end

        rst = 1'b1;
        d   = 1'b1;
        @(posedge clk);
        #1;

        $stop;
    end

endmodule
