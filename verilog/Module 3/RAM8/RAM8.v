module RAM8(
    input wire [15:0] in,
    input wire load, clk,
    input wire [2:0] address,
    output wire [15:0] out
);
    wire [7:0] register_load;
    wire [15:0] register_out [7:0];

    DMux8Way dmux(
        .in(load),
        .sel(address),
        .a(register_load[0]),
        .b(register_load[1]),
        .c(register_load[2]),
        .d(register_load[3]),
        .e(register_load[4]),
        .f(register_load[5]),
        .g(register_load[6]),
        .h(register_load[7])
    );

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin: registers
            Register register(
                .in(in),
                .clk(clk),
                .load(register_load[i]),
                .out(register_out[i])
            );
        end
    endgenerate

    Mux8Way16 mux(
        .a(register_out[0]),
        .b(register_out[1]),
        .c(register_out[2]),
        .d(register_out[3]),
        .e(register_out[4]),
        .f(register_out[5]),
        .g(register_out[6]),
        .h(register_out[7]),
        .sel(address),
        .out(out)
    );

endmodule;