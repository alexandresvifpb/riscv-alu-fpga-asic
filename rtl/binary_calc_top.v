`timescale 1ns / 1ps

module binary_calc_top (
    input clk,              // clock genérico (ASIC ou FPGA)
    input rst_n,            // reset ativo em nível baixo
    input [3:0] A_in,
    input [3:0] B_in,
    input [1:0] OP_in,
    input execute_btn,      // botão (ou sinal externo)
    output [3:0] result_out,
    output carry_out,
    output zero_out,
    output overflow_out
);

    // ================================
    // RESET
    // ================================
    wire rst;
    assign rst = ~rst_n;

    // ================================
    // EXECUTE BUTTON (SINCRONIZAÇÃO)
    // ================================
    reg btn_sync_0, btn_sync_1, btn_sync_2;
    wire execute;
    
    always @(posedge clk) begin
        btn_sync_0 <= execute_btn;
        btn_sync_1 <= btn_sync_0;
        btn_sync_2 <= btn_sync_1;
    end
    
    assign execute = btn_sync_1 & ~btn_sync_2;  // Borda de subida

    // ================================
    // DECLARAÇÃO DOS WIRES (ESTAVA FALTANDO!)
    // ================================
    wire [3:0] a_reg;
    wire [3:0] b_reg;
    wire [1:0] op_reg;
    wire [3:0] alu_result;
    wire alu_carry;
    wire alu_zero;
    wire alu_overflow;

    // ================================
    // INPUT REGISTER
    // ================================
    input_register in_reg (
        .clk(clk),
        .rst(rst),
        .execute(execute),
        .a_in(A_in),
        .b_in(B_in),
        .op_in(OP_in),
        .a_out(a_reg),
        .b_out(b_reg),
        .op_out(op_reg)
    );

    // ================================
    // ALU
    // ================================
    alu arithmetic_unit (
        .a(a_reg),
        .b(b_reg),
        .op(op_reg),
        .result(alu_result),
        .carry(alu_carry),
        .overflow(alu_overflow),
        .zero(alu_zero)
    );

    // ================================
    // OUTPUT REGISTER
    // ================================
    output_register out_reg (
        .clk(clk),
        .rst(rst),
        .execute(execute),
        .result_in(alu_result),
        .carry_in(alu_carry),
        .zero_in(alu_zero),
        .overflow_in(alu_overflow),
        .result_out(result_out),
        .carry_out(carry_out),
        .zero_out(zero_out),
        .overflow_out(overflow_out)
    );

endmodule
