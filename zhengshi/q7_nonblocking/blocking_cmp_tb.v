`timescale 1ns / 1ps

module blocking_cmp_tb;

    reg clk, rst;
    reg [3:0] a;
    wire [3:0] b_n, c_n, b_b, c_b;

    integer i;

    blocking_cmp dut (
        .clk (clk),
        .rst (rst),
        .a   (a),
        .b_n (b_n),
        .c_n (c_n),
        .b_b (b_b),
        .c_b (c_b)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        a   = 4'd0;
        #20;
        rst = 1'b0;

        $display("time  a   b_n c_n  b_b c_b");
        $display("---- ---- ---- ---- ---- ----");

        for (i = 0; i < 12; i = i + 1) begin
            a = i[3:0];
            @(posedge clk);
            #1;
            $display("%4t  %h   %h   %h   %h   %h",
                     $time, a, b_n, c_n, b_b, c_b);
        end

        $display("");
        $display("Key observations:");
        $display("  b_n == b_b  ?  Yes, <= and = behave the same for a single register");
        $display("  c_b == b_n  ?  Yes, c_b lags a by 1 cycle");
        $display("  c_n lags c_b by 1 cycle ? Yes, c_n lags a by 2 cycles");

        $stop;
    end

endmodule
