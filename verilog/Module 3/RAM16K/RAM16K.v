module RAM16K(
    input wire [15:0] in,
    input wire load, clk,
    input wire [13:0] address,
    output wire [15:0] out
);
    wire [7:0] ramblock_load;
    wire [15:0] ramblock_out [7:0];

    // address[13:12] selects the ram4k block
    // address[11:0] selects the register inside the ram4k block
    DMux4Way dmux(
        .in(load),
        .sel(address[13:12]),
        .a(ramblock_load[0]),
        .b(ramblock_load[1]),
        .c(ramblock_load[2]),
        .d(ramblock_load[3])
    );

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin: ramblocks
            RAM4K ramblock(
                .in(in),
                .clk(clk),
                .load(ramblock_load[i]),
                .address(address[11:0]),
                .out(ramblock_out[i])
            );
        end
    endgenerate

    Mux4Way16 mux(
        .a(ramblock_out[0]),
        .b(ramblock_out[1]),
        .c(ramblock_out[2]),
        .d(ramblock_out[3]),
        .sel(address[13:12]),
        .out(out)
    );

endmodule;