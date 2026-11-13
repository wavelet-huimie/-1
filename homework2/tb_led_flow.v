// =============================================================
// tb_led_flow.v  --  Testbench for led_flow
// STEP_MAX shrunk to 49 so one flow step = 50 clocks (1us),
// easy to observe several steps + PWM duty in the waveform.
// Expected duty (fraction of time high) for each LED:
//   head = 70/128, 1st tail = 35/128, 2nd tail = 5/128,
//   3rd tail = 1/128, others = 0
// =============================================================
`timescale 1ns/1ps

module tb_led_flow;

    reg        clk   = 1'b0;
    reg        rst_n = 1'b0;
    wire [7:0] ledr;

    // DUT with a short flow period for simulation
    led_flow #(
        .STEP_MAX(23'd49)
    ) dut (
        .clk   (clk),
        .rst_n (rst_n),
        .ledr  (ledr)
    );

    // 50 MHz clock: 20 ns period
    always #10 clk = ~clk;

    // track position changes for the log
    reg [7:0] ledr_d;
    always @(posedge clk) ledr_d <= ledr;

    initial begin
        $dumpfile("tb_led_flow.vcd");
        $dumpvars(0, tb_led_flow);

        // reset
        rst_n = 1'b0;
        #100;
        rst_n = 1'b1;

        // run long enough to see the head go around 8 LEDs and wrap
        #100_000;

        $display("Simulation done. Final ledr = %b", ledr);
        $stop;
    end

endmodule
