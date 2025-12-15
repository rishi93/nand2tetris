`timescale 1us/1us

module PC_Test;
    reg [15:0] in;
    reg inc, load, reset, clk;
    wire [15:0] out;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    PC pc(
        .in(in),
        .inc(inc),
        .load(load),
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    initial begin
        $dumpfile("PC/Test.vcd");
        $dumpvars(0, PC_Test);

        in = 12345;
        reset = 1; inc = 0; load = 0; #2;
        reset = 0; inc = 1; load = 0; #10;
        reset = 0; inc = 0; load = 1; #2;
        reset = 0; inc = 1; load = 0; #10;

        $finish;
    end
endmodule;