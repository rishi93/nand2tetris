`timescale 1us/1us
module Mux_Test;
    reg a, b, sel;
    wire out;

    Mux test(
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("Mux/Test.vcd");
        $dumpvars(0, Mux_Test);

        $display("a | b | sel | out");
        $display("-----------------");

        for (i = 0; i < 8; i = i+1) begin
            {a, b, sel} = i[2:0];
            #1 $display("%b | %b | %b   | %b", a, b, sel, out);
        end

        $finish;
    end
endmodule;