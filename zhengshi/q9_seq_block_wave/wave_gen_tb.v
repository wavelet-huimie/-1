// ============================================================================
//  wave_gen_tb.v  --  题 9/10 自测平台（默认走 simulation 路径）
//
//  在 0~60ns 范围内逐 ns 比对 sig_seq 和 sig_par，应该任何时刻都相同。
//  ============================================================================

`timescale 1ns / 1ps

module wave_gen_tb;

    wire sig_seq, sig_par;
    integer i, errors;

    // SYNTHESIS 版本需要 clk/rst，这里给个最小时钟（仿真不会走这条路）
    reg clk, rst;
    initial clk = 0;
    always #5 clk = ~clk;
    initial rst = 0;

    wave_gen dut (
        .clk     (clk),
        .rst     (rst),
        .sig_seq (sig_seq),
        .sig_par (sig_par)
    );

    initial begin
        errors = 0;
        $dumpfile("wave_gen.vcd");
        $dumpvars(0, wave_gen_tb);

        $display("time  sig_seq  sig_par   match?");
        $display("----  -------  -------   ------");

        for (i = 0; i <= 60; i = i + 1) begin
            #1;
            $display("%2dns   %b        %b       %s",
                     i, sig_seq, sig_par,
                     (sig_seq === sig_par) ? "YES" : "NO");
            if (sig_seq !== sig_par)
                errors = errors + 1;
        end

        if (errors == 0)
            $display("PASS  wave_gen : seq_block vs par_block match 61/61");
        else
            $display("FAIL  wave_gen : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
