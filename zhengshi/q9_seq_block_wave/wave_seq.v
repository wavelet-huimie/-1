// ============================================================================
//  wave_seq.v  --  题9：用顺序块和延迟控制产生一个时序波形
//
//  仿真版本：initial + begin/end 内的 #N 相对延迟（会累加）
//  综合版本：clk 驱动的状态机，产生同样的 10ns 翻转波形
// ============================================================================

`timescale 1ns / 1ps

module wave_seq (
    input  wire clk,
    input  wire rst,
    output reg  sig
);

`ifdef SYNTHESIS

    // Quartus 综合版本：用计数器产生 0/1 交替波形
    reg [2:0] cnt;

    always @(posedge clk or posedge rst) begin
        if (rst)
            cnt <= 3'd0;
        else
            cnt <= cnt + 3'd1;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            sig <= 1'b0;
        else
            sig <= (cnt < 3) ? 1'b0 : 1'b1;
    end

`else

    // ModelSim 仿真版本：顺序块，每条 #10 相对上一条执行，自然累加
    // 实际时刻：0 / 10 / 20 / 30 / 40 / 50 ns
    initial begin
        sig = 1'b0;
        #10 sig = 1'b1;
        #10 sig = 1'b0;
        #10 sig = 1'b1;
        #10 sig = 1'b0;
        #10 sig = 1'b1;
    end

`endif

endmodule
