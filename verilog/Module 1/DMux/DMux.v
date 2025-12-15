module DMux(
    input wire in,
    input wire sel,
    output wire a,
    output wire b
);
    // Approach 1:
    assign a = in & ~sel;
    assign b = in & sel;
    // Approach 2:
    // Change a and b to reg
    // you can only assign to reg in always block
    /*
    always @(*) begin
        case (sel)
            1'b0: begin
                a = in;
                b = 0;
            end
            1'b1: begin
                a = 0;
                b = in;
            end
        endcase
    end
    */
endmodule;