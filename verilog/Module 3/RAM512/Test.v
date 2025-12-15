module RAM512_Test;
    reg [15:0] in;
    reg load, clk;
    reg[8:0] address;
    wire [15:0] out;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    RAM512 ram512(
        .in(in),
        .load(load),
        .clk(clk),
        .address(address),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("RAM512/Test.vcd");
        $dumpvars(0, RAM512_Test);

        // first write into a certain register
        // in each of the blocks
        load = 1;

        for (i = 0; i < 8; i = i + 1) begin
            address = 4+(8*i) + (64*i);
            in = 4+(8*i) + (64*i);
            #2;
        end

        // now read the values
        load = 0;

        for (i = 0; i < 8; i = i + 1) begin
            address = 4+(8*i) + (64*i); #2;
        end

        $finish;
    end

endmodule;