`timescale 1ns / 1ps

module binary_calc_top_fpga_tb;

    reg CLOCK_50;
    reg [9:0] SW;
    reg [3:0] KEY;

    wire [9:0] LEDR;

    binary_calc_top_fpga dut (
        .CLOCK_50(CLOCK_50),
        .SW(SW),
        .KEY(KEY),
        .LEDR(LEDR)
    );

    always #10 CLOCK_50 = ~CLOCK_50;

    initial begin
        $dumpfile("sim/waves/binary_calc_top_fpga_tb.vcd");
        $dumpvars(0, binary_calc_top_fpga_tb);

        CLOCK_50 = 0;
        SW = 0;
        KEY = 4'b1111; // reset desativado

        #50;

        // ADD: 2 + 3
        SW[3:0] = 4'd2;
        SW[7:4] = 4'd3;
        SW[9:8] = 2'b00;

        KEY[0] = 0; #20;
        KEY[0] = 1;

        #100;

        // SUB: 10 - 4
        SW[3:0] = 4'd10;
        SW[7:4] = 4'd4;
        SW[9:8] = 2'b01;

        KEY[0] = 0; #20;
        KEY[0] = 1;

        #100;

        $finish;
    end

endmodule
