module Mux16(
    input wire [15:0] a, b,
    input wire sel,
    output wire [15:0] out
);
    assign out = sel ? b : a;
endmodule;