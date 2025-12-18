module PC(
    input wire [15:0] in,
    input wire reset, load, inc, clk,
    output wire [15:0] out
);
    wire [15:0] resetOut, regOut, loadOut, incOut, incWire;
    // reset overrides everything
    // load overrides inc
    // so we need to design in this order
    Register register(
        .in(resetOut),
        .load(1'b1),
        .clk(clk),
        .out(out)
    );

    assign regOut = out;

    assign incWire = regOut + 1;

    // regOut/incOut --> incOut/in --> loadOut/reset
    assign incOut = inc ? incWire : regOut;
    assign loadOut = load ? in : incOut;
    assign resetOut = reset ? 0: loadOut;

endmodule;