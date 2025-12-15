module DMux4Way_Test;
    reg in;
    reg [1:0] sel;
    wire a, b, c, d;

    DMux4Way test(
        .in(in),
        .sel(sel),
        .a(a),
        .b(b),
        .c(c),
        .d(d)
    );

    integer i;

    initial begin
        $dumpfile("DMux4Way/Test.vcd");
        $dumpvars(0, DMux4Way_Test);
        
        for (i = 0; i < 4; i = i+1) begin
            in = 1;
            sel = i[1:0];
            #1;
            $display("in = %b", in);
            $display("sel = %b", sel);
            $display("a = %b, b = %b, c = %b, d = %b", a, b, c, d);
            $display("----------------------------------");
        end

        $finish;
    end
endmodule;