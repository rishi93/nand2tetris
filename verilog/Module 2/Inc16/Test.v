module Inc16_test;
    reg signed [15:0] in;
    wire signed [15:0] out;

    Inc16 test(
        .in(in),
        .out(out)
    );

    initial begin
        in = 16'd32;
        #1 $display("in = %0d, out = %0d", in, out);
        in = -16'd32;
        #1 $display("in = %0d, out = %0d", in, out);
        in = 16'd32767;
        #1 $display("in = %0d, out = %0d", in, out);
        in = 16'd32768;
        #1 $display("in = %0d, out = %0d", in, out);
    end
endmodule;