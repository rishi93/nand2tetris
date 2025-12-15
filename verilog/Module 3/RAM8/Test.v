`timescale 1us/1us

module RAM8_Test;
    reg [15:0] in;
    reg load, clk;
    reg [2:0] address;
    wire [15:0] out;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    RAM8 ram8(
        .in(in),
        .load(load),
        .clk(clk),
        .address(address),
        .out(out)
    );

    integer i;

    initial begin
        $dumpfile("RAM8/Test.vcd");
        $dumpvars(0, RAM8_Test);

        load = 1;
        // Write values 1 to 8 into registers 0 to 7
        for (i = 0; i < 8; i = i + 1) begin
            in = 16'd1 + i;
            address = i[2:0];
            #2;
        end

        load = 0;
        // Read values from registers 0 to 7
        for (i = 0; i < 8; i = i + 1) begin
            address = i[2:0];
            #2;
        end

        $finish;
    end
endmodule;