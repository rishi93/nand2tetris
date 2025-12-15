`timescale 1us/1us
module And_Test;
    // The signals in this test module
    reg a, b;
    wire out;

    // Instantiate our module to test
    And test(
        .a(a),
        .b(b),
        .out(out)
    );

    // We'll use this variable to iterate
    // through the various input possibilities
    integer i;

    initial begin
        // Dump all the signals into this file
        $dumpfile("And/Test.vcd");
        $dumpvars(0, And_Test);

        // Print some things to the console
        $display("a | b | out");
        $display("-----------");

        for (i = 0; i < 4; i = i+1) begin
            {a, b} = i[1:0];
            #1 $display("%b | %b | %b", a, b, out);
        end

        $finish;
    end

endmodule;