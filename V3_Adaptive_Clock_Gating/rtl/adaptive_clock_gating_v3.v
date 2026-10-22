`timescale 1ns/1ps

module adaptive_clock_gating_v3 #(
    parameter IDLE_THRESHOLD = 3
)(
    input  wire clk,
    input  wire reset,
    input  wire req_A,
    input  wire req_B,
    input  wire req_C,
    input  wire wake,
    output wire gated_clk_A,
    output wire gated_clk_B,
    output wire gated_clk_C,
    output wire idle_A,
    output wire idle_B,
    output wire idle_C
);

    reg [2:0] idle_count_A;
    reg [2:0] idle_count_B;
    reg [2:0] idle_count_C;

    reg enable_A;
    reg enable_B;
    reg enable_C;

    // Adaptive activity and idle detection logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            idle_count_A <= 3'd0;
            idle_count_B <= 3'd0;
            idle_count_C <= 3'd0;

            enable_A <= 1'b0;
            enable_B <= 1'b0;
            enable_C <= 1'b0;
        end else begin
            if (req_A || wake) begin
                idle_count_A <= 3'd0;
                enable_A <= 1'b1;
            end else if (idle_count_A < IDLE_THRESHOLD) begin
                idle_count_A <= idle_count_A + 1'b1;
                if (idle_count_A + 1'b1 >= IDLE_THRESHOLD)
                    enable_A <= 1'b0;
            end

            if (req_B || wake) begin
                idle_count_B <= 3'd0;
                enable_B <= 1'b1;
            end else if (idle_count_B < IDLE_THRESHOLD) begin
                idle_count_B <= idle_count_B + 1'b1;
                if (idle_count_B + 1'b1 >= IDLE_THRESHOLD)
                    enable_B <= 1'b0;
            end

            if (req_C || wake) begin
                idle_count_C <= 3'd0;
                enable_C <= 1'b1;
            end else if (idle_count_C < IDLE_THRESHOLD) begin
                idle_count_C <= idle_count_C + 1'b1;
                if (idle_count_C + 1'b1 >= IDLE_THRESHOLD)
                    enable_C <= 1'b0;
            end
        end
    end

    // Sky130 integrated clock-gating cells.
    // Their internal latch holds GATE stable while CLK is high.
    sky130_fd_sc_hd__dlclkp_1 u_icg_A (
        .CLK(clk),
        .GATE(enable_A),
        .GCLK(gated_clk_A)
    );

    sky130_fd_sc_hd__dlclkp_1 u_icg_B (
        .CLK(clk),
        .GATE(enable_B),
        .GCLK(gated_clk_B)
    );

    sky130_fd_sc_hd__dlclkp_1 u_icg_C (
        .CLK(clk),
        .GATE(enable_C),
        .GCLK(gated_clk_C)
    );

    assign idle_A = ~enable_A;
    assign idle_B = ~enable_B;
    assign idle_C = ~enable_C;

endmodule
