module DMux8Way(
    input wire in,
    input wire [2:0] sel,
    output reg a, b, c, d, e, f, g, h
);
    always @(*) begin
        a = 0; b = 0; c = 0; d = 0;
        e = 0; f = 0; g = 0; h = 0;
        case (sel)
            3'b000: begin
                a = in;
            end
            3'b001: begin
                b = in;
            end
            3'b010: begin
                c = in;
            end
            3'b011: begin
                d = in;
            end
            3'b100: begin
                e = in;
            end
            3'b101: begin
                f = in;
            end
            3'b110: begin
                g = in;
            end
            3'b111: begin
                h = in;
            end
        endcase
    end
endmodule;