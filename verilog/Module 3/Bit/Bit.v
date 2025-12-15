module Bit(
    input wire in, load, clk,
    output wire out
);
    wire newIn;

    // if load then feed the input
    // to the D-FlipFlop, else feed
    // the previous output back
    // This way the value is remembered
    assign newIn = load ? in : out;

    DFF dff(
        .clk(clk),
        .d(newIn),
        .q(out)
    );
endmodule;