`timescale 1us/1us
module Not_Test;
    reg in;
    wire out;

    Not test(
        .in(in),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("Not/Test.vcd");
        $dumpvars(0, Not_Test);

        $display("in | out");
        $display("--------");

        for (i = 0; i < 2; i = i+1) begin
            in = i;
            #1 $display("%b | %b", in, out);
        end

        $finish;
    end
endmodule;