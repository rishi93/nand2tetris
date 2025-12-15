`timescale 1us/1us

module Not16_Test;
    reg [15:0] in;
    wire [15:0] out;

    Not16 test(
        .in(in),
        .out(out)
    );

    integer k;

    initial begin
        $dumpfile("Not16/Test.vcd");
        $dumpvars(0, Not16_Test);

        $display("%16s | %16s |", "in", "out");
        $display("-------------------------------------");

        for (k = 0; k < 4; k = k+1) begin
            // $random generate a random 32-bit integer
            // assigning it to a 16-bit number, takes only
            // the lower 16 bits, this is good enough for
            // our purpose
            in = $random;
            #1 $display("%b | %b |", in, out);
        end

        $finish;
    end
endmodule;