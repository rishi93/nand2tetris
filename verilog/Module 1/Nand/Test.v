`timescale 1us/1us

module Nand_Test;
    reg a, b;
    wire out;

    Nand test(
        .a(a),
        .b(b),
        .out(out)
    );

    integer i;

    initial begin
        $display("a | b | out");
        $display("-----------");

        $dumpfile("Nand/Test.vcd");
        $dumpvars(0, Nand_Test);

        for (i = 0; i < 4; i = i+1) begin
            {a, b} = i[1:0];
            #1 $display("%b | %b | %b", a, b, out);
        end

        $finish;
    end
endmodule;