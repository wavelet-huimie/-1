// ============================================================================
//  bcd60.v  --  模 60 的 BCD 码加法计数器
//
//  输出：units[3:0] 个位 (0-9)，tens[2:0] 十位 (0-5)
//  循环：00, 01, ..., 58, 59, 00, 01, ...
//  ============================================================================

`timescale 1ns / 1ps

module bcd60 (
    input  wire       clk,
    input  wire       clr,       // 异步高电平清零
    output reg  [3:0] units,     // 个位 BCD 0-9
    output reg  [2:0] tens       // 十位 BCD 0-5（3 位足够）
);

    always @(posedge clk or posedge clr) begin
        if (clr) begin
            units <= 4'd0;
            tens  <= 3'd0;
        end
        else if (units == 4'd9 && tens == 3'd5) begin
            // 59 -> 00 归零
            units <= 4'd0;
            tens  <= 3'd0;
        end
        else if (units == 4'd9) begin
            // 个位到顶，十位 +1，个位归零
            units <= 4'd0;
            tens  <= tens + 3'd1;
        end
        else begin
            units <= units + 4'd1;
        end
    end

endmodule
