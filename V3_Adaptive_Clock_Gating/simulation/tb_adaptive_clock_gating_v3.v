`timescale 1ns/1ps

module tb_adaptive_clock_gating_v3;

    reg clk = 0;
    reg reset = 1;
    reg req_A = 0;
    reg req_B = 0;
    reg req_C = 0;
    reg wake = 0;

    wire gated_clk_A, gated_clk_B, gated_clk_C;
    wire idle_A, idle_B, idle_C;

    integer errors = 0;

    adaptive_clock_gating_v3 #(.IDLE_THRESHOLD(3)) dut (
        .clk(clk),
        .reset(reset),
        .req_A(req_A),
        .req_B(req_B),
        .req_C(req_C),
        .wake(wake),
        .gated_clk_A(gated_clk_A),
        .gated_clk_B(gated_clk_B),
        .gated_clk_C(gated_clk_C),
        .idle_A(idle_A),
        .idle_B(idle_B),
        .idle_C(idle_C)
    );

    always #5 clk = ~clk;

    task check;
        input condition;
        input [8*80-1:0] message;
        begin
            if (condition) begin
                $display("PASS: %0s", message);
            end else begin
                $display("FAIL: %0s at time %0t", message, $time);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("clock_gating_v3.vcd");
        $dumpvars(0, tb_adaptive_clock_gating_v3);

        // Reset keeps all clock gates disabled
        #2;
        check(idle_A && idle_B && idle_C,
              "Reset disables all three clock gates");

        // Release reset away from the active clock edge
        #6 reset = 0;

        // Request A: its clock should become enabled
        @(negedge clk);
        req_A = 1;
        @(negedge clk);
        req_A = 0;
        #1;
        check(!idle_A && idle_B && idle_C,
              "Request A enables only clock A");

        // Request B
        @(negedge clk);
        req_B = 1;
        @(negedge clk);
        req_B = 0;
        #1;
        check(!idle_A && !idle_B,
              "Request B enables clock B");

        // Wake should enable all three clocks
        @(negedge clk);
        wake = 1;
        @(negedge clk);
        wake = 0;
        #1;
        check(!idle_A && !idle_B && !idle_C,
              "Wake enables all three clocks");

        // Wait for the idle timeout
        repeat (4) @(negedge clk);
        #1;
        check(idle_A && idle_B && idle_C,
              "All clocks disable after the idle timeout");

        if (errors == 0)
            $display("RESULT: ALL V3 TESTS PASSED");
        else
            $display("RESULT: %0d V3 TEST(S) FAILED", errors);

        #5;
        $finish;
    end

endmodule
