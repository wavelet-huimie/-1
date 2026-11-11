// ============================================================================
//  vote7.v  --  7 人投票表决器（用 for 语句）
//
//  vote[6:0] : 7 位投票，1=赞成，0=反对
//  pass      : 赞成数 >= 4 时为 1，否则为 0
//  ============================================================================

`timescale 1ns / 1ps

module vote7 (
    input  wire [6:0] vote,
    output reg        pass
);

    integer i;
    reg [2:0] count;   // 最多 7，3 位足够

    always @(*) begin
        count = 3'd0;
        for (i = 0; i < 7; i = i + 1) begin
            if (vote[i])
                count = count + 3'd1;
        end
        pass = (count >= 3'd4);
    end

endmodule
