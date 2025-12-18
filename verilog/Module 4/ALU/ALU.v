module ALU(
    // The two 16-bit inputs
    input wire [15:0] x, y,
    // The 4 control bits that define the computation

    // The order of computation is:
    // x is transformed first by zx, then by nx
    // Similarly y is transformed first by zy, then by ny
    // Then both pass through f, and then the output of f
    // passes through no

    // if zx == 1, we output 0, else we output x as is
    // if nx == 1, we output ~x, else we output x as is

    // if f == 1, we output x+y, else we output x&y
    // if no == 1, we output ~out, else we output out
    input wire zx, nx, zy, ny, f, no,
    output wire zr, ng,
    output wire [15:0] out
);
    // First zx is applied, then nx
    wire [15:0] zx_out, nx_out, zy_out, ny_out, f_out;
    assign zx_out = zx ? 0 : x;
    assign nx_out = nx ? ~zx_out : zx_out;

    // Similarly, first zy is applied, then ny
    assign zy_out = zy ? 0 : y;
    assign ny_out = ny ? ~zy_out : zy_out;

    // Apply computation for f
    assign f_out = f ? (nx_out + ny_out) : (nx_out & ny_out);

    // Apply final computation no
    assign out = no ? ~f_out : f_out;

    // Apply OR operation on all the bits,
    // if all bits are 0, then result will be 0, so we
    // will take the NOT of this output to indicate that we got
    // a zero as output
    assign zr = ~(|out);

    // The leftmost bit indicates if output is negative
    assign ng = out[15];

endmodule;