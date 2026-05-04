`timescale 1ns / 1ps

module output_register_tb;

    // ==========================================
    // ENTRADAS
    // ==========================================

    reg clk;
    reg rst;
    reg execute;

    reg [3:0] alu_result;
    reg carry_in;
    reg overflow_in;
    reg zero_in;

    // ==========================================
    // SAÍDAS
    // ==========================================

    wire [3:0] result_out;
    wire carry_out;
    wire overflow_out;
    wire zero_out;

    // ==========================================
    // DUT
    // ==========================================

    output_register dut (

        .clk(clk),
        .rst(rst),
        .execute(execute),

        .result_in(alu_result),

        .carry_in(carry_in),
        .overflow_in(overflow_in),
        .zero_in(zero_in),

        .result_out(result_out),

        .carry_out(carry_out),
        .overflow_out(overflow_out),
        .zero_out(zero_out)
    );

    // ==========================================
    // CLOCK
    // ==========================================

    always #5 clk = ~clk;

    // ==========================================
    // TESTES
    // ==========================================

    initial begin

        $dumpfile("sim/waves/output_register_tb.vcd");
        $dumpvars(0, output_register_tb);

        clk = 0;
        rst = 1;
        execute = 0;

        alu_result = 0;
        carry_in = 0;
        overflow_in = 0;
        zero_in = 0;

        #20;

        rst = 0;

        // TESTE 1
        alu_result = 4'd5;
        execute = 1;

        #10;

        execute = 0;

        #20;

        // TESTE 2
        alu_result = 4'd15;
        carry_in = 1;
        execute = 1;

        #10;

        execute = 0;

        #20;

        // TESTE 3
        alu_result = 4'd0;
        zero_in = 1;
        execute = 1;

        #10;

        execute = 0;

        #20;

        $finish;
    end

endmodule
