`timescale 1us/1us

module Bit_Test;
    reg load, in, clk;
    wire out;

    initial clk = 0;

    Bit test(
        .in(in),
        .load(load),
        .clk(clk),
        .out(out)
    );

    always begin
        #1 clk = ~clk;
    end

    initial begin
        $dumpfile("Bit/Test.vcd");
        $dumpvars(0, Bit_Test);

        load = 0; in = 1; #2;
        load = 1; in = 1; #2;
        load = 0; in = 0; #2;
        load = 1; in = 0; #2;

        $finish;
    end
endmodule;