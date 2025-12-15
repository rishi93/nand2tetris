`timescale 1us/1us

module RAM16K_Test;
    reg [15:0] in;
    reg load, clk;
    reg[13:0] address;
    wire [15:0] out;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    RAM4K ram4k(
        .in(in),
        .load(load),
        .clk(clk),
        .address(address),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("RAM16K/Test.vcd");
        $dumpvars(0, RAM16K_Test);

        // first write into a certain register
        // in each of the blocks
        load = 1;

        for (i = 0; i < 4; i = i + 1) begin
            address = 4+(512*i) + (4096*i);
            in = 4+(512*i) + (4096*i);
            #2;
        end

        // now read the values
        load = 0;

        for (i = 0; i < 4; i = i + 1) begin
            address = 4+(512*i) + (4096*i); #2;
        end

        $finish;
    end

endmodule;