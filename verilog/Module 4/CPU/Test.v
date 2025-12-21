module CPU_Test;
    reg [15:0] inM, instruction;
    reg reset, clk;
    wire [15:0] outM;
    wire [14:0] addressM, pc;
    output wire writeM;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    CPU cpu(
            .inM(inM),
            .instruction(instruction),
            .reset(reset),
            .clk(clk),
            .outM(outM),
            .addressM(addressM),
            .pc(pc),
            .writeM(writeM)
        );

    initial begin
        // Provide the instruction @15 to the CPU
        inM = 16'b0000_0000_0000_0000;

        // Press the reset button
        // It goes to 1, then bounces back to 0
        $display("--------------------");
        $display("finger on the reset button");
        reset = 1;
        $display("reset = %b", reset);
        #1;
        $display("finger off the reset button");
        reset = 0;
        $display("reset = %b", reset);
        $display("--------------------");

        // @15
        instruction = 16'b0_000000000001111;
        #2;
        $display("instruction = %b", instruction);
        $display("writeM = %b", writeM);
        $display("addressM = %b", addressM);
        $display("outM = %b", outM);
        $display("pc = %b", pc);
        $display("--------------------");

        // D = A
        instruction = 16'b111_0_110000_010_000;
        #2;
        $display("instruction = %b", instruction);
        $display("writeM = %b", writeM);
        $display("addressM = %b", addressM);
        $display("outM = %b", outM);
        $display("pc = %b", pc);
        $display("--------------------");

        // @20
        instruction = 16'b0_000000000010100;
        #2;
        $display("instruction = %b", instruction);
        $display("writeM = %b", writeM);
        $display("addressM = %b", addressM);
        $display("outM = %b", outM);
        $display("pc = %b", pc);
        $display("--------------------");

        // A = D + A
        instruction = 16'b111_0_000010_100_000;
        #2;
        $display("instruction = %b", instruction);
        $display("writeM = %b", writeM);
        $display("addressM = %b", addressM);
        $display("outM = %b", outM);
        $display("pc = %b", pc);
        $display("--------------------");

        // RAM[A] = D
        instruction = 16'b111_0_110000_001_000;
        #2;
        $display("instruction = %b", instruction);
        $display("writeM = %b", writeM);
        $display("addressM = %b", addressM);
        $display("outM = %b", outM);
        $display("pc = %b", pc);
        $display("--------------------");

        $finish;
    end

endmodule;