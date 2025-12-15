module Mux(
    input wire a, b, sel,
    output wire out
);
    // Approach 1:
    // assign out = (a & ~sel) | (b & sel);
    // Approach 2:
    assign out = sel ? b : a;
    // Approach 3:
    // But make out as reg in an always block
    /*
    always @(*) begin
        if (sel) begin
            out = b;
        end else begin
            out = a;
        end
    end
    */
endmodule;