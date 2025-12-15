module Add16_test;
    reg signed [15:0] a, b;
    wire signed [15:0] sum;

    Add16 test(
        .a(a),
        .b(b),
        .sum(sum)
    );

    initial begin
        a = 16'd2;
        b = 16'd5;
        #1;
        $display("a = %0d, b = %0d, sum = %0d", a, b, sum);

        a = 16'd32767;
        b = 16'd1;
        #1;
        $display("a = %0d, b = %0d, sum = %0d", a, b, sum);

        a = -16'd10;
        b = -16'd30;
        #1;
        $display("a = %0d, b = %0d, sum = %0d", a, b, sum);
    end
endmodule;