// ============================================================================
//  bit_counter.v  --  统计 8 位输入中值为 1 的位的个数
//
//  data[7:0] : 输入 8 位数据
//  count[3:0]: 1 的个数 (0-8，4 位足够)
//  ============================================================================

`timescale 1ns / 1ps

module bit_counter (
    input  wire [7:0] data,
    output reg  [3:0] count
);

    integer i;

    always @(*) begin
        count = 4'd0;
        for (i = 0; i < 8; i = i + 1) begin
            if (data[i])
                count = count + 4'd1;
        end
    end

endmodule
