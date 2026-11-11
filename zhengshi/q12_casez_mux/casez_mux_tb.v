// ============================================================================
//  casez_mux_tb.v  --  题 12 自测平台
// ============================================================================

`timescale 1ns / 1ps

module casez_mux_tb;

    reg  [3:0] a, b, c, d;
    reg  [1:0] sel;
    wire [3:0] y;

    integer ia, ib, ic, id, isel, errors;
    reg  [3:0] exp;

    casez_mux dut (
        .a   (a),
        .b   (b),
        .c   (c),
        .d   (d),
        .sel (sel),
        .y   (y)
    );

    initial begin
        errors = 0;
        $dumpfile("casez_mux.vcd");
        $dumpvars(0, casez_mux_tb);

        // 穷举 sel=00/01/10/11，abcd 各取 1,2,3,4 方便观察
        a = 4'd1; b = 4'd2; c = 4'd3; d = 4'd4;

        sel = 2'b00; #1; if (y !== a) begin errors = errors + 1; $display("FAIL sel=00 y=%h", y); end
        sel = 2'b01; #1; if (y !== b) begin errors = errors + 1; $display("FAIL sel=01 y=%h", y); end
        sel = 2'b10; #1; if (y !== c) begin errors = errors + 1; $display("FAIL sel=10 y=%h", y); end
        sel = 2'b11; #1; if (y !== d) begin errors = errors + 1; $display("FAIL sel=11 y=%h", y); end

        // 再穷举 sel x (a,b,c,d) 全组合
        for (ia = 0; ia < 16; ia = ia + 1) begin
            for (ib = 0; ib < 16; ib = ib + 1) begin
                for (ic = 0; ic < 16; ic = ic + 1) begin
                    for (id = 0; id < 16; id = id + 1) begin
                        for (isel = 0; isel < 4; isel = isel + 1) begin
                            a = ia[3:0]; b = ib[3:0]; c = ic[3:0]; d = id[3:0];
                            sel = isel[1:0];
                            #1;
                            case (sel)
                                2'b00: exp = a;
                                2'b01: exp = b;
                                2'b10: exp = c;
                                2'b11: exp = d;
                            endcase
                            if (y !== exp) begin
                                errors = errors + 1;
                                $display("FAIL: sel=%b a=%h b=%h c=%h d=%h -> y=%h",
                                         sel, a, b, c, d, y);
                            end
                        end
                    end
                end
            end
        end

        if (errors == 0)
            $display("PASS  casez_mux : 16384 cases OK");
        else
            $display("FAIL  casez_mux : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
