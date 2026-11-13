`timescale 1ns / 1ps

module nonblocking_reg_tb;

    reg clk, rst;
    reg [3:0] a;
    wire [3:0] b, c;

    integer i;

    nonblocking_reg dut (
        .clk (clk),
        .rst (rst),
        .a   (a),
        .b   (b),
        .c   (c)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        a   = 4'd0;
        #20;
        rst = 1'b0;

        $display("time  a   b   c");
        $display("---- ---- --- ---");

        for (i = 0; i < 12; i = i + 1) begin
            a = i[3:0];
            @(posedge clk);
            #1;
            $display("%4t  %h   %h   %h", $time, a, b, c);
        end

        $display("");
        $display("Key observations:");
        $display("  b lags a by 1 clock  (b <= a at posedge)");
        $display("  c lags a by 2 clocks (c <= b uses the old b)");

        $stop;
    end

endmodule
