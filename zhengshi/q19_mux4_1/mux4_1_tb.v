// ============================================================================
//  mux4_1_tb.v  --  题 19 自测平台
//  ============================================================================

`timescale 1ns / 1ps

module mux4_1_tb;

    reg  [3:0] d0, d1, d2, d3;
    reg  [1:0] sel;
    wire [3:0] y;

    integer i, j, errors;
    reg [3:0] exp;

    mux4_1 dut (
        .d0  (d0), .d1  (d1), .d2  (d2), .d3  (d3),
        .sel (sel),
        .y   (y)
    );

    initial begin
        errors = 0;
        $dumpfile("mux4_1.vcd");
        $dumpvars(0, mux4_1_tb);

        // 穷举 sel x (d0,d1,d2,d3) 全组合 (4 x 16^4)
        for (sel = 2'b00; sel < 2'b11; sel = sel + 1) begin
            for (i = 0; i < 256; i = i + 1) begin
                d0 = i[3:0]; d1 = i[7:4];
                d2 = (i * 3) & 4'hF; d3 = (i * 7 + 1) & 4'hF;
                for (j = 0; j < 2; j = j + 1) begin
                    #1;
                    case (sel)
                        2'b00: exp = d0;
                        2'b01: exp = d1;
                        2'b10: exp = d2;
                        2'b11: exp = d3;
                    endcase
                    if (y !== exp) begin
                        errors = errors + 1;
                        $display("FAIL: sel=%b d0=%h d1=%h d2=%h d3=%h -> y=%h",
                                 sel, d0, d1, d2, d3, y);
                    end
                end
            end
        end
        // sel=11 单独跑一次（循环没包含，因为 11+1=00 回绕）
        sel = 2'b11;
        for (i = 0; i < 256; i = i + 1) begin
            d0 = i[3:0]; d1 = i[7:4];
            d2 = (i * 3) & 4'hF; d3 = (i * 7 + 1) & 4'hF;
            #1;
            exp = d3;
            if (y !== exp) begin
                errors = errors + 1;
                $display("FAIL: sel=11 d0=%h d1=%h d2=%h d3=%h -> y=%h",
                         d0, d1, d2, d3, y);
            end
        end

        if (errors == 0)
            $display("PASS  mux4_1 : all cases OK");
        else
            $display("FAIL  mux4_1 : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
