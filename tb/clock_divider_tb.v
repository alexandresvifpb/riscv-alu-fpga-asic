`timescale 1ns / 1ps

module clock_divider_tb;

    reg clk_in;
    reg rst;

    wire clk_out;

    // ==========================================
    // DUT
    // ==========================================

    clock_divider dut (

        .clk_in(clk_in),
        .rst(rst),
        .clk_out(clk_out)
    );

    // Clock rápido
    always #1 clk_in = ~clk_in;

    initial begin

        $dumpfile("sim/waves/clock_divider_tb.vcd");
        $dumpvars(0, clock_divider_tb);

        clk_in = 0;
        rst = 1;

        #10;

        rst = 0;

        #200;

        $finish;
    end

endmodule
