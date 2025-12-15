module DMux8Way_Test;
    reg in;
    reg [2:0] sel;
    wire a, b, c, d, e, f, g, h;

    DMux8Way test(
        .in(in),
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .h(h)
    );

    integer i;
    
    initial begin
        $dumpfile("DMux8Way/Test.vcd");
        $dumpvars(0, DMux8Way_Test);

        for (i = 0; i < 8; i = i+1) begin
            in = 1;
            sel = i[2:0];
            #1;
            $display("in = %b", in);
            $display("sel = %b", sel);
            $display("a = %b, b = %b, c = %b, d = %b", a, b, c, d);
            $display("e = %b, f = %b, g = %b, h = %b", e, f, g, h);
            $display("----------------------------");
        end

        $finish;
    end
endmodule;