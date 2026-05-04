`timescale 1ns / 1ps

module binary_calc_top_gl_tb;

    // ==========================================
    // ENTRADAS
    // ==========================================
    reg clk;
    reg rst_n;
    reg [3:0] A_in;
    reg [3:0] B_in;
    reg [1:0] OP_in;
    reg execute_btn;

    // ==========================================
    // SAÍDAS
    // ==========================================
    wire [3:0] result_out;
    wire carry_out;
    wire zero_out;
    wire overflow_out;

    // ==========================================
    // DUT = Netlist sintetizado (GATE-LEVEL)
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
    // CLOCK (50 MHz)
    // ==========================================
    always #10 clk = ~clk;

    // ==========================================
    // TESTES
    // ==========================================
    initial begin
        $dumpfile("sim/gl/gl_wave.vcd");
        $dumpvars(0, binary_calc_top_gl_tb);

        $display("========================================");
        $display("=== Gate-Level Simulation ===");
        $display("=== Calculadora Binária 4 bits ===");
        $display("========================================\n");

        // Inicialização
        clk = 0;
        rst_n = 0;
        execute_btn = 0;
        A_in = 0;
        B_in = 0;
        OP_in = 0;

        #20;
        rst_n = 1;
        $display("Reset liberado.");

        // ==========================================
        // TESTE 1: ADD 2 + 3 = 5
        // ==========================================
        #10;
        A_in = 4'd2;
        B_in = 4'd3;
        OP_in = 2'b00;
        #10 execute_btn = 1;
        #10 execute_btn = 0;
        #40;

        $display("TESTE 1 - ADD: %d + %d = %d (esperado 5)", A_in, B_in, result_out);

        // ==========================================
        // TESTE 2: SUB 10 - 4 = 6
        // ==========================================
        A_in = 4'd10;
        B_in = 4'd4;
        OP_in = 2'b01;
        #10 execute_btn = 1;
        #10 execute_btn = 0;
        #40;

        $display("TESTE 2 - SUB: %d - %d = %d (esperado 6)", A_in, B_in, result_out);

        // ==========================================
        // TESTE 3: AND 12 & 10 = 8
        // ==========================================
        A_in = 4'b1100;
        B_in = 4'b1010;
        OP_in = 2'b10;
        #10 execute_btn = 1;
        #10 execute_btn = 0;
        #40;

        $display("TESTE 3 - AND: 12 & 10 = %d (esperado 8)", result_out);

        // ==========================================
        // TESTE 4: OR 12 | 3 = 15
        // ==========================================
        A_in = 4'b1100;
        B_in = 4'b0011;
        OP_in = 2'b11;
        #10 execute_btn = 1;
        #10 execute_btn = 0;
        #40;

        $display("TESTE 4 - OR: 12 | 3 = %d (esperado 15)", result_out);

        // ==========================================
        // TESTE 5: CARRY 15 + 1 = 16
        // ==========================================
        A_in = 4'd15;
        B_in = 4'd1;
        OP_in = 2'b00;
        #10 execute_btn = 1;
        #10 execute_btn = 0;
        #40;

        $display("TESTE 5 - CARRY: 15 + 1 = %d, carry = %b (esperado carry=1)", result_out, carry_out);

        // ==========================================
        // TESTE 6: ZERO 4 - 4 = 0
        // ==========================================
        A_in = 4'd4;
        B_in = 4'd4;
        OP_in = 2'b01;
        #10 execute_btn = 1;
        #10 execute_btn = 0;
        #40;

        $display("TESTE 6 - ZERO: 4 - 4 = %d, zero = %b (esperado zero=1)", result_out, zero_out);

        $display("\n========================================");
        $display("=== Gate-Level Simulation Finalizada ===");
        $display("========================================");

        #50;
        $finish;
    end

endmodule
