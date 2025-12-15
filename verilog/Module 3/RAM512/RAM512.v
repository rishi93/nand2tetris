module RAM512(
    input wire [15:0] in,
    input wire load, clk,
    input wire [8:0] address,
    output wire [15:0] out
);
    wire [7:0] ramblock_load;
    wire [15:0] ramblock_out [7:0];

    // address[8:6] selects the ram64 block
    // address[5:0] selects the register inside the ram64 block
    DMux8Way dmux(
        .in(load),
        .sel(address[8:6]),
        .a(ramblock_load[0]),
        .b(ramblock_load[1]),
        .c(ramblock_load[2]),
        .d(ramblock_load[3]),
        .e(ramblock_load[4]),
        .f(ramblock_load[5]),
        .g(ramblock_load[6]),
        .h(ramblock_load[7])
    );

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin: ramblocks
            RAM64 ramblock(
                .in(in),
                .clk(clk),
                .load(ramblock_load[i]),
                .address(address[5:0]),
                .out(ramblock_out[i])
            );
        end
    endgenerate

    Mux8Way16 mux(
        .a(ramblock_out[0]),
        .b(ramblock_out[1]),
        .c(ramblock_out[2]),
        .d(ramblock_out[3]),
        .e(ramblock_out[4]),
        .f(ramblock_out[5]),
        .g(ramblock_out[6]),
        .h(ramblock_out[7]),
        .sel(address[8:6]),
        .out(out)
    );

endmodule;