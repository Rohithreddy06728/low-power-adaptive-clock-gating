`timescale 1ns/1ps

module tb_icg_cell;

    reg clk = 0;
    reg gate = 0;
    wire gclk;

    sky130_fd_sc_hd__dlclkp_1 dut (
        .CLK(clk),
        .GATE(gate),
        .GCLK(gclk)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("icg_cell_test.vcd");
        $dumpvars(0, tb_icg_cell);

        $monitor("Time=%0t clk=%b gate=%b gclk=%b",
                 $time, clk, gate, gclk);

        // Enable the gate during the low clock phase
        #2 gate = 1;

        // Disable during the high phase.
        // GCLK should remain high until CLK falls.
        #5 gate = 0;

        #8;

        // Re-enable during the low phase
        gate = 1;

        #15;

        $finish;
    end

endmodule
