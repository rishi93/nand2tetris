`timescale 1us/1us
module DMux_Test;
    reg in, sel;
    wire a, b;

    DMux test(
        .in(in),
        .sel(sel),
        .a(a),
        .b(b)
    );

    integer i;

    initial begin
        $dumpfile("DMux/Test.vcd");
        $dumpvars(0, DMux_Test);

        $display("in | sel | a | b");
        $display("----------------");

        for (i = 0; i < 4; i = i + 1) begin
            {in, sel} = i[1:0];
            #1 $display("%b | %b   |  %b | %b", in, sel, a, b);
        end

        $finish;
    end
endmodule;