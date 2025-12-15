module FullAdder(
    input wire a, b, cin,
    output wire sum, cout
);
    wire s, c1, c2;
    // sum and carry in HalfAdder should
    // be connected to 
    HalfAdder ha1(
        .a(a),
        .b(b),
        .sum(s),
        .carry(c1)
    );
    HalfAdder ha2(
        .a(s),
        .b(cin),
        .sum(sum),
        .carry(c2)
    );
    assign cout = c1 | c2;
endmodule;