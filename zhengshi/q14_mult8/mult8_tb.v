`timescale 1ns / 1ps

module mult8_tb;

    reg  [7:0]  a, b;
    wire [15:0] product;

    integer ia, ib;

    mult8 dut (
        .a       (a),
        .b       (b),
        .product (product)
    );

    initial begin
        for (ia = 0; ia < 256; ia = ia + 1) begin
            for (ib = 0; ib < 256; ib = ib + 1) begin
                a = ia[7:0];
                b = ib[7:0];
                #1;
            end
        end
        $stop;
    end

endmodule
