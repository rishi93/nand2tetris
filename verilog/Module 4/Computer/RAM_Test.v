module RAM_Test;
    reg [15:0] in;
    reg [14:0] address;
    reg load, clk;
    wire [15:0] out;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    RAM ram(
        .in(in),
        .address(address),
        .load(load),
        .clk(clk),
        .out(out)
    );

    initial begin
        address = 0; load = 1;
        in = 16'b01010101_01010101;
        #2;
        $display("out = %b", out);

        address = 1; load = 1;
        in = 16'b10101010_10101010;
        #2;
        $display("out = %b", out);

        address = 0; load = 0;
        #2;
        $display("out = %b", out);

        address = 1; load = 0;
        #2;
        $display("out = %b", out);

        $finish;
    end
endmodule;