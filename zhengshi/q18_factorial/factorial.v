// ============================================================================
//  factorial.v  --  阶乘运算（用 function 实现）
//
//  输入 n (0~12，超出 12 会导致 32 位溢出)
//  输出 fact = n!
//  ============================================================================

`timescale 1ns / 1ps

module factorial (
    input  wire [3:0]  n,       // 0~12
    output wire [31:0] fact
);

    // 用 function 计算阶乘
    function [31:0] fact_fn;
        input [3:0] k;
        integer i;
        begin
            fact_fn = 32'd1;
            for (i = 1; i <= k; i = i + 1)
                fact_fn = fact_fn * i;
        end
    endfunction

    assign fact = fact_fn(n);

endmodule
