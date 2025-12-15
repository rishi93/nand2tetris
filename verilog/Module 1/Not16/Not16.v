module Not16(
    input wire [15:0] in,
    output wire [15:0] out
);
    assign out = ~in;
endmodule;