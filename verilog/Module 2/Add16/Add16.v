module Add16(
    input wire [15:0] a,
    input wire [15:0] b,
    output wire [15:0] sum
);
    wire [16:0] c;
    // c[0] is assigned to 0
    assign c[0] = 1'b0;
    // c[1] to c[14] are used internally for
    // carrying the carry bit forward
    // c[15] is ignored
 
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin: adders
            FullAdder fa(
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .cout(c[i+1]),
                .sum(sum[i])
            );
        end
    endgenerate
endmodule;