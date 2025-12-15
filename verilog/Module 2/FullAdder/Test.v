module FullAdder_test;
    reg a, b, cin;
    wire sum, cout;

    FullAdder test(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    integer i;

    initial begin
        $dumpfile("FullAdder/Test.vcd");
        $dumpvars(0, FullAdder_test);

        $display("a | b | cin | sum | cout");
        $display("------------------------");

        for (i = 0; i < 8; i = i+1) begin
            {a, b, cin} = i[2:0];
            #1 $display("%b | %b | %b   | %b   | %b", a, b, cin, sum, cout);
        end

        $finish;
    end
endmodule;