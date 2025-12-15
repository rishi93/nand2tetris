module Mux8Way16_Test;
    reg [15:0] a, b, c, d, e, f, g, h;
    reg [2:0] sel;
    wire [15:0] out;

    Mux8Way16 test(
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .h(h),
        .sel(sel),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("Mux8Way16/Test.vcd");
        $dumpvars(0, Mux8Way16_Test);

        for (i = 0; i < 8; i = i+1) begin
            {a, b} = $random;
            {c, d} = $random;
            {e, f} = $random;
            {g, h} = $random;

            sel = i[2:0];
            #1;

            $display("a = %b", a);
            $display("b = %b", b);
            $display("c = %b", c);
            $display("d = %b", d);
            $display("e = %b", e);
            $display("f = %b", f);
            $display("g = %b", g);
            $display("h = %b", h);

            $display("sel = %b", sel);
            $display("out = %b", out);

            $display("----------------");
        end

        $finish;
    end
endmodule;