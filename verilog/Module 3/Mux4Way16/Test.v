module Mux4Way16_Test;
    reg [15:0] a, b, c, d;
    reg [1:0] sel;
    wire [15:0] out;

    Mux4Way16 test(
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .out(out) 
    );

    integer i;

    initial begin
        $dumpfile("Mux4Way16/Test.vcd");
        $dumpvars(0, Mux4Way16_Test);

        $display("%16s | %16s | %16s | %16s | sel | %16s |", "a", "b", "c", "d", "out");

        for (i = 0; i < 4; i = i+1) begin
            {a, b} = $random;
            {c, d} = $random;

            sel = i[1:0];

            #1 $display("%b | %b | %b | %b | %b  | %b |", a, b, c, d, sel, out);
        end

        $finish;
    end
endmodule;