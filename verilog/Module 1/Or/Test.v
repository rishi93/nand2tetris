`timescale 1us/1us
module Or_Test;
    reg a, b;
    wire out;

    Or test(
        .a(a),
        .b(b),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("Or/Test.vcd");
        $dumpvars(0, Or_Test);

        $display("a | b | out");
        $display("-----------");

        for (i = 0; i < 4; i = i+1) begin
            {a, b} = i[1:0];
            #1 $display("%b | %b | %b", a, b, out);
        end

        $finish;
    end
endmodule;