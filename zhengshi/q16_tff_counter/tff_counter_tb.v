// ============================================================================
//  tff_counter_tb.v  --  题 16 自测平台
//  ============================================================================

`timescale 1ns / 1ps

module tff_counter_tb;

    reg clk, clr;
    wire [7:0] cnt;

    integer i, errors;

    tff_counter dut (
        .clk (clk),
        .clr (clr),
        .cnt (cnt)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        errors = 0;
        $dumpfile("tff_counter.vcd");
        $dumpvars(0, tff_counter_tb);

        // 复位
        clr = 1'b1;
        #20;
        clr = 1'b0;

        // 跑 515 个时钟，确保覆盖 0-255 回绕两次
        for (i = 1; i <= 515; i = i + 1) begin
            @(posedge clk);
            #1;
            if (cnt !== i[7:0]) begin   // 自动取低 8 位，天然模 256
                errors = errors + 1;
                $display("FAIL: after %0d clocks, cnt=%0d (expect %0d)",
                         i, cnt, i[7:0]);
            end
        end

        // 再验一次复位
        clr = 1'b1;
        #1;
        if (cnt !== 8'd0) begin
            errors = errors + 1;
            $display("FAIL: async clr, cnt=%0d", cnt);
        end

        if (errors == 0)
            $display("PASS  tff_counter : all 515 steps OK");
        else
            $display("FAIL  tff_counter : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
