`timescale 1ns / 1ps

module alu (
    input  [3:0] a,
    input  [3:0] b,
    input  [1:0] op,

    output reg [3:0] result,
    output reg carry,
    output reg overflow,
    output wire zero
);

    reg [4:0] temp;

    always @(*) begin

        carry    = 1'b0;
        overflow = 1'b0;
        temp      = 5'b00000;

        case(op)

            // ADD
            2'b00: begin
                temp   = a + b;
                result = temp[3:0];
                carry  = temp[4];

                overflow =
                    (~a[3] & ~b[3] & result[3]) |
                    ( a[3] &  b[3] & ~result[3]);
            end

            // SUB
            2'b01: begin
                temp   = a - b;
                result = temp[3:0];
                carry  = temp[4];

                overflow =
                    (~a[3] & b[3] & result[3]) |
                    ( a[3] & ~b[3] & ~result[3]);
            end

            // AND
            2'b10: begin
                result   = a & b;
                carry    = 1'b0;
                overflow = 1'b0;
            end

            // OR
            2'b11: begin
                result   = a | b;
                carry    = 1'b0;
                overflow = 1'b0;
            end

            default: begin
                result   = 4'b0000;
                carry    = 1'b0;
                overflow = 1'b0;
            end

        endcase
    end

    assign zero = (result == 4'b0000);

endmodule

