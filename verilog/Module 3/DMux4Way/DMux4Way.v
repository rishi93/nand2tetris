module DMux4Way(
    input wire in,
    input wire [1:0] sel,
    output reg a, b, c, d
);
    always @(*) begin
        case (sel)
            2'b00: begin
                a = in; b = 0; c = 0; d = 0;
            end
            2'b01: begin
                a = 0; b = in; c = 0; d = 0;
            end
            2'b10: begin
                a = 0; b = 0; c = in; d = 0;
            end
            2'b11: begin
                a = 0; b = 0; c = 0; d = in;
            end
        endcase
    end
endmodule;