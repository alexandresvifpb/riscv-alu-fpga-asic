`timescale 1ns / 1ps

module binary_calc_top_tb;

    // ==========================================
    // ENTRADAS
    // ==========================================

    reg clk;
    reg rst_n;
    reg execute_btn;

    reg [3:0] A_in;
    reg [3:0] B_in;
    reg [1:0] OP_in;

    // ==========================================
    // SAÍDAS
    // ==========================================

    wire [3:0] result_out;
    wire carry_out;
    wire zero_out;
    wire overflow_out;

    // ==========================================
    // DUT
    // ==========================================

    binary_calc_top dut (
        .clk(clk),
        .rst_n(rst_n),

        .A_in(A_in),
        .B_in(B_in),
        .OP_in(OP_in),
        .execute_btn(execute_btn),

        .result_out(result_out),
        .carry_out(carry_out),
        .zero_out(zero_out),
        .overflow_out(overflow_out)
    );

    // ==========================================
    // CLOCK
    // ==========================================

    always #5 clk = ~clk;

    // ==========================================
    // TESTES
    // ==========================================

    initial begin

        $dumpfile("sim/waves/binary_calc_top_tb.vcd");
        $dumpvars(0, binary_calc_top_tb);

        clk = 0;
        rst_n = 0;
        execute_btn = 0;

        A_in = 0;
        B_in = 0;
        OP_in = 0;

        // Reset
        #20;
        rst_n = 1;

        // ==========================================
        // TESTE 1 - ADD (2 + 3 = 5)
        // ==========================================

        A_in = 4'd2;
        B_in = 4'd3;
        OP_in = 2'b00;

        #12 execute_btn = 1;
        #20 execute_btn = 0;

        #100;

        // ==========================================
        // TESTE 2 - SUB (10 - 4 = 6)
        // ==========================================

        A_in = 4'd10;
        B_in = 4'd4;
        OP_in = 2'b01;

        #12 execute_btn = 1;
        #20 execute_btn = 0;

        #100;

        // ==========================================
        // TESTE 3 - AND
        // ==========================================

        A_in = 4'b1100;
        B_in = 4'b1010;
        OP_in = 2'b10;

        #10 execute_btn = 1;
        #10 execute_btn = 0;

        #40;

        // ==========================================
        // TESTE 4 - OR
        // ==========================================

        A_in = 4'b1100;
        B_in = 4'b0011;
        OP_in = 2'b11;

        #10 execute_btn = 1;
        #10 execute_btn = 0;

        #40;

        // ==========================================
        // TESTE 5 - ZERO FLAG (4 - 4 = 0)
        // ==========================================

        A_in = 4'd4;
        B_in = 4'd4;
        OP_in = 2'b01;

        #10 execute_btn = 1;
        #10 execute_btn = 0;

        #40;

        // ==========================================
        // TESTE 6 - CARRY (15 + 1 = 16)
        // ==========================================

        A_in = 4'd15;
        B_in = 4'd1;
        OP_in = 2'b00;

        #10 execute_btn = 1;
        #10 execute_btn = 0;

        #40;

        // ==========================================
        // TESTE 7 - OVERFLOW (7 + 7 = 14)
        // ==========================================

        A_in = 4'd7;
        B_in = 4'd7;
        OP_in = 2'b00;

        #10 execute_btn = 1;
        #10 execute_btn = 0;

        #40;

        $finish;
    end

endmodule
