module Inc16(
    input wire [15:0] in,
    output wire [15:0] out
);
    wire b = 16'b0000000000000001;

    Add16 adder(
        .a(in),
        .b(b),
        .sum(out)
    );
endmodule;