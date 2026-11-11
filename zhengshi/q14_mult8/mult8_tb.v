// ============================================================================
//  mult8_tb.v  --  题 14 自测平台
//
//  8 位乘法共 256x256 = 65536 种组合，全部穷举。
//  ============================================================================

`timescale 1ns / 1ps

module mult8_tb;

    reg  [7:0]  a, b;
    wire [15:0] product;

    integer ia, ib, errors;

    mult8 dut (
        .a       (a),
        .b       (b),
        .product (product)
    );

    initial begin
        errors = 0;
        $dumpfile("mult8.vcd");
        $dumpvars(0, mult8_tb);

        for (ia = 0; ia < 256; ia = ia + 1) begin
            for (ib = 0; ib < 256; ib = ib + 1) begin
                a = ia[7:0];
                b = ib[7:0];
                #1;
                if (product !== (a * b)) begin
                    errors = errors + 1;
                    $display("FAIL: a=%0d b=%0d -> product=%0d (expect %0d)",
                             a, b, product, a * b);
                end
            end
        end

        if (errors == 0)
            $display("PASS  mult8 : 65536 cases OK");
        else
            $display("FAIL  mult8 : %0d mismatch(es)", errors);

        $stop;
    end

endmodule
