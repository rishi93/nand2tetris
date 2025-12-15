module HalfAdder_test;
    reg a, b;
    wire sum, carry;

    HalfAdder test(
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    integer i;

    initial begin
        $dumpfile("HalfAdder/Test.vcd");
        $dumpvars(0, HalfAdder_test);

        $display("a | b | s | c");
        $display("-------------");

        for (i = 0; i < 4; i = i+1) begin
            {a, b} = i[1:0];
            #1 $display("%b | %b | %b | %b", a, b, sum, carry);
        end

        $finish;
    end
endmodule;