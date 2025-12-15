module RAM64_Test;
    reg [15:0] in;
    reg load, clk;
    reg [5:0] address;
    wire [15:0] out;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    RAM64 ram64(
        .in(in),
        .load(load),
        .clk(clk),
        .address(address),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("RAM64/Test.vcd");
        $dumpvars(0, RAM64_Test);

        load = 1;

        // We can't test out all 64 registers in RAM64
        // Let's just test one register in each RAM8 block
        // Let's pick register #4

        for (i = 0; i < 8; i = i + 1) begin
            // write this value into register 4 in i-th block
            in = 16'd4 + 8*i;
            address = 4 + 8*i;
            #2;
        end

        load = 0;

        for (i = 0; i < 8; i = i + 1) begin
            // read the value from register 0
            address = 4 + 8*i; #2;
        end

        $finish;
    end
endmodule;