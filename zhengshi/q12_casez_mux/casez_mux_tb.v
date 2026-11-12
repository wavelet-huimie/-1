`timescale 1ns / 1ps

module casez_mux_tb;

    reg  [3:0] a, b, c, d;
    reg  [1:0] sel;
    wire [3:0] y;

    integer ia, ib, ic, id, isel;

    casez_mux dut (
        .a   (a),
        .b   (b),
        .c   (c),
        .d   (d),
        .sel (sel),
        .y   (y)
    );

    initial begin
        a = 4'd1; b = 4'd2; c = 4'd3; d = 4'd4;

        sel = 2'b00; #1;
        sel = 2'b01; #1;
        sel = 2'b10; #1;
        sel = 2'b11; #1;

        for (ia = 0; ia < 16; ia = ia + 1) begin
            for (ib = 0; ib < 16; ib = ib + 1) begin
                for (ic = 0; ic < 16; ic = ic + 1) begin
                    for (id = 0; id < 16; id = id + 1) begin
                        for (isel = 0; isel < 4; isel = isel + 1) begin
                            a = ia[3:0]; b = ib[3:0]; c = ic[3:0]; d = id[3:0];
                            sel = isel[1:0];
                            #1;
                        end
                    end
                end
            end
        end

        $stop;
    end

endmodule
