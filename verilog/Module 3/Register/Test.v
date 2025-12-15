`timescale 1us/1us

module Register_Test;
    reg [15:0] in;
    reg load;
    wire [15:0] out;
    reg clk;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    Register test(
        .in(in),
        .load(load),
        .out(out),
        .clk(clk)
    );

    initial begin
        $dumpfile("Register/Test.vcd");
        $dumpvars(0, Register_Test);

        load = 0; in = 16'b1010101010101010; #2;
        load = 1; in = 16'b1010101010101010; #2;
        load = 0; in = 16'b0000000000000000; #2;
        load = 1; in = 16'b0000000000000000; #2;
        #1;

        $finish;
    end
endmodule;