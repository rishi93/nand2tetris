module Register(
    input wire [15:0] in,
    input wire load, clk,
    output reg [15:0] out
);
    always @(posedge clk) begin
        if (load) out <= in;
    end
endmodule;