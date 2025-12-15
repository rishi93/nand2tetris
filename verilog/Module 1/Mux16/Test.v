module Mux16_Test;
    reg [15:0] a, b;
    reg sel;
    wire [15:0] out;

    Mux16 test(
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("Mux16/Test.vcd");
        $dumpvars(0, Mux16_Test);

        $display("%16s | %16s | %s | %16s |", "a", "b", "sel", "out");
        $display("-------------------------------------------------------------");

        for (i = 0; i < 2; i = i+1) begin
            a = $random;
            b = $random;
            sel = i;
            #1 $display("%b | %b | %b   | %b |", a, b, sel, out);
        end

        $finish;
    end
endmodule;