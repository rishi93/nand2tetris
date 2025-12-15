module Register(
    input wire [15:0] in,
    input wire load, clk,
    output wire [15:0] out
);
    genvar i;
    
    generate
        for (i = 0; i < 16; i = i + 1) begin: bits
            Bit bit(
                .in(in[i]),
                .clk(clk),
                .load(load),
                .out(out[i])
            );
        end
    endgenerate
endmodule;