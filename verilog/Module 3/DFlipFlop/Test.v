`timescale 1us/1us

module DFF_Test;
    reg clk;
    reg d;
    wire q;

    initial clk = 0;

    DFF test(
        .clk(clk),
        .d(d),
        .q(q)
    );

    always begin
        #1 clk = ~clk;
    end

    initial begin
        $dumpfile("DFlipFlop/Test.vcd");
        $dumpvars(0, DFF_Test);

        clk = 0;
        d = 0;
        #2 d = 1;
        #2 d = 0;
        #2 d = 1;
        #2 d = 1;
        #2 d = 0;

        #2 $finish; 
    end
endmodule;
