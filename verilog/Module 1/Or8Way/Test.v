module Or8Way_Test;
    reg [7:0] in;
    wire out;

    Or8Way test(
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("Or8Way/Test.vcd");
        $dumpvars(0, Or8Way_Test);

        $display("%8s | %s |", "in", "out");
        $display("----------------");

        in = 8'b0000_0000;
        #1 $display("%b | %b   |", in, out);

        in = 8'b0101_0101;
        #1 $display("%b | %b   |", in, out);

        $finish;
    end
endmodule;