`timescale 1ns / 1ps

module input_register (

    input clk,
    input rst,
    input execute,

    input [3:0] a_in,
    input [3:0] b_in,
    input [1:0] op_in,

    output reg [3:0] a_out,
    output reg [3:0] b_out,
    output reg [1:0] op_out
);

    always @(posedge clk) begin
        if (rst) begin
            a_out  <= 4'b0000;
            b_out  <= 4'b0000;
            op_out <= 2'b00;
        end
        else if (execute) begin
            a_out  <= a_in;
            b_out  <= b_in;
            op_out <= op_in;
        end
    end

endmodule
