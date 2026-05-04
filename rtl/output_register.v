`timescale 1ns / 1ps

module output_register (

    input clk,
    input rst,
    input execute,

    input  [3:0] result_in,
    input        carry_in,
    input        zero_in,
    input        overflow_in,

    output reg [3:0] result_out,
    output reg       carry_out,
    output reg       zero_out,
    output reg       overflow_out
);

    always @(posedge clk) begin

        if (rst) begin

            result_out   <= 4'b0000;
            carry_out    <= 1'b0;
            zero_out     <= 1'b0;
            overflow_out <= 1'b0;

        end
        else if (execute) begin

            result_out   <= result_in;
            carry_out    <= carry_in;
            zero_out     <= zero_in;
            overflow_out <= overflow_in;

        end
    end

endmodule
