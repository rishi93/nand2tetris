`timescale 1us/1us
module Nand_Test;
    reg a, b;
    wire y;

    Nand test(
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        $dumpfile("Test.vcd");
        $dumpvars(0, Nand_Test);

        $display("a b | y");
        $display("-------");
        
        a = 0; b = 0; #1
        $display("%b %b | %b", a, b, y);
        a = 0; b = 1; #1
        $display("%b %b | %b", a, b, y);
        a = 1; b = 0; #1
        $display("%b %b | %b", a, b, y);
        a = 1; b = 1; #1
        $display("%b %b | %b", a, b, y);
    end
endmodule;
