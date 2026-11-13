// =============================================================
// led_flow.v  --  Breathing flowing LED
// Board   : Terasic DE10-Nano (Cyclone V SoC 5CSEBA6U23I7), 50MHz clock
// Function: 8 LEDs light up one by one at 10 Hz (100 ms per step).
//           While flowing, each LED shows 4 brightness levels by
//           PWM: 7'd70 (current) -> 7'd35 -> 7'd5 -> 7'd1 (tail).
//           duty = brightness / 128
// =============================================================
module led_flow #(
    // 50MHz / 10Hz = 5_000_000 clocks per step (default: real board)
    parameter STEP_MAX = 23'd4_999_999
)(
    input  wire       clk,     // 50 MHz system clock  (PIN_M9)
    input  wire       rst_n,   // KEY0, active-low reset (PIN_U7)
    output wire [7:0] ledr     // 8 LEDs, high = on
);

    // ---------------------------------------------------------
    // 1. Flow pointer: pos advances every STEP_MAX clocks (100ms)
    // ---------------------------------------------------------
    localparam CNT_W = 23;

    reg [CNT_W-1:0] step_cnt;
    reg [2:0]       pos;         // position of the brightest LED

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            step_cnt <= {CNT_W{1'b0}};
            pos      <= 3'd0;
        end else if (step_cnt == STEP_MAX) begin
            step_cnt <= {CNT_W{1'b0}};
            pos      <= pos + 3'd1;          // wrap 7 -> 0 automatically
        end else begin
            step_cnt <= step_cnt + 1'b1;
        end
    end

    // ---------------------------------------------------------
    // 2. PWM counter: free-running 7-bit counter (0 ~ 127)
    //    PWM period = 128 clocks ~ 2.56us (about 390kHz)
    // ---------------------------------------------------------
    reg [6:0] pwm_cnt;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pwm_cnt <= 7'd0;
        else
            pwm_cnt <= pwm_cnt + 7'd1;
    end

    // ---------------------------------------------------------
    // 3. Brightness of each LED decided by its distance to pos
    //    d = pos - i (mod 8):  0->70, 1->35, 2->5, 3->1, else 0
    //    This builds the "breathing" comet tail behind the head.
    // ---------------------------------------------------------
    reg [6:0] bright [0:7];
    reg [2:0] d;
    integer   i;

    always @(*) begin
        for (i = 0; i < 8; i = i + 1) begin
            d = pos - i;                     // truncated to 3 bits => mod 8
            case (d)
                3'd0: bright[i] = 7'd70;     // head, brightest
                3'd1: bright[i] = 7'd35;
                3'd2: bright[i] = 7'd5;
                3'd3: bright[i] = 7'd1;      // faint tail
                default: bright[i] = 7'd0;   // off
            endcase
        end
    end

    // ---------------------------------------------------------
    // 4. PWM output: LED on while brightness > pwm_cnt
    // ---------------------------------------------------------
    genvar g;
    generate
        for (g = 0; g < 8; g = g + 1) begin : gen_pwm
            assign ledr[g] = (bright[g] > pwm_cnt);
        end
    endgenerate

endmodule
