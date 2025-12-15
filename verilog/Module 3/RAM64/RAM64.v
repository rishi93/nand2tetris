module RAM64(
    input wire [15:0] in,
    input wire load, clk,
    // address[5:3] selects one of the RAM8 blocks
    // address[2:0] selects the register from within the block
    input wire [5:0] address,
    output wire [15:0] out
);
    wire [7:0] ramblock_load;
    wire [15:0] ramblock_out [7:0];

    DMux8Way dmux(
        .in(load),
        .sel(address[5:3]),
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
            RAM8 ramblock(
                .in(in),
                .clk(clk),
                .load(ramblock_load[i]),
                .address(address[2:0]),
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
        .sel(address[5:3]),
        .out(out)
    );

endmodule;