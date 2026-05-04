`timescale 1ns / 1ps

module binary_calc_top_fpga (

    input CLOCK_50,
    input [9:0] SW,
    input [1:0] KEY,

    output [9:0] LEDR
);

    wire [3:0] result;
    wire carry;
    wire zero;
    wire overflow;

    binary_calc_top core (

        .clk(CLOCK_50),
        .rst_n(KEY[1]),

        .A_in(SW[3:0]),
        .B_in(SW[7:4]),
        .OP_in(SW[9:8]),
        .execute_btn(~KEY[0]),

        .result_out(result),
        .carry_out(carry),
        .zero_out(zero),
        .overflow_out(overflow)
    );

    assign LEDR[3:0] = result;
    assign LEDR[4]   = carry;
    assign LEDR[5]   = zero;
    assign LEDR[6]   = overflow;

    assign LEDR[9:7] = 3'b000;

endmodule
