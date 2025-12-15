module Or16_Test;
    reg [15:0] a, b;
    wire [15:0] out;

    Or16 test(
        .a(a),
        .b(b),
        .out(out)
    );

    integer k;

    initial begin
        $dumpfile("Or16/Test.vcd");
        $dumpvars(0, Or16_Test);

        $display("%16s | %16s | %16s", "a", "b", "out");
        $display("-------------------------------------------------------");

        for (k = 0; k < 4; k = k+1) begin
            {a, b} = $random;
            #1 $display("%b | %b | %b |", a, b, out);
        end

        $finish;
    end
endmodule;