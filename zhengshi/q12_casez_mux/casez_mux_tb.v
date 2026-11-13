`timescale 1ns / 1ps

module casez_mux_tb;

    reg  [1:0] a, b, c;
    reg  [1:0] sel;
    wire [1:0] y;

    integer ia, ib, ic, isel;

    casez_mux dut (
        .a   (a),
        .b   (b),
        .c   (c),
        .sel (sel),
        .y   (y)
    );

    initial begin
        a = 2'd1; b = 2'd2; c = 2'd3;

        sel = 2'b00; #1;
        sel = 2'b01; #1;
        sel = 2'b10; #1;
        sel = 2'b11; #1;

        for (ia = 0; ia < 4; ia = ia + 1) begin
            for (ib = 0; ib < 4; ib = ib + 1) begin
                for (ic = 0; ic < 4; ic = ic + 1) begin
                    for (isel = 0; isel < 4; isel = isel + 1) begin
                        a = ia[1:0]; b = ib[1:0]; c = ic[1:0];
                        sel = isel[1:0];
                        #1;
                    end
                end
            end
        end

        $stop;
    end

endmodule
