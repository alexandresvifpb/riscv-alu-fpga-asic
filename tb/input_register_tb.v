`timescale 1ns / 1ps

module input_register_tb;

    reg clk;
    reg rst;
    reg execute;

    reg [3:0] a_in;
    reg [3:0] b_in;
    reg [1:0] op_in;

    wire [3:0] a_out;
    wire [3:0] b_out;
    wire [1:0] op_out;

    input_register dut (
        .clk(clk),
        .rst(rst),
        .execute(execute),
        .a_in(a_in),
        .b_in(b_in),
        .op_in(op_in),
        .a_out(a_out),
        .b_out(b_out),
        .op_out(op_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/waves/input_register_tb.vcd");
        $dumpvars(0, input_register_tb);

        clk = 0;
        rst = 1;
        execute = 0;

        a_in = 0;
        b_in = 0;
        op_in = 0;

        #20;
        rst = 0;

        // TESTE 1
        a_in = 4'd3;
        b_in = 4'd2;
        op_in = 2'b00;
        execute = 1;

        #10;
        execute = 0;

        #20;

        // TESTE 2
        a_in = 4'd7;
        b_in = 4'd1;
        op_in = 2'b01;
        execute = 1;

        #10;
        execute = 0;

        #20;

        $finish;
    end

endmodule
