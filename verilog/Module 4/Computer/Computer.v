module Computer #(
    parameter ROM_FILE = ""
) (
    input wire reset, clk
);
    // pc is the address of the current instruction
    // on pressing the reset button, pc = 0
    wire [15:0] instruction;
    wire [14:0] pc;
    // writeM --> set to 1, to write into RAM
    // addressM --> address in RAM to write to
    // outM --> data out from CPU and into RAM
    // inM --> data out from RAM and into CPU
    wire writeM;
    wire [14:0] addressM;
    wire [15:0] inM, outM;

    // The ROM is asynchronous, as soon as it gets an
    // address, it pumps out the contents at that address
    // which should be an instruction that the CPU can
    // execute
    ROM #(.FILE(ROM_FILE)) rom(
        .address(pc),
        .out(instruction)
    );

    CPU cpu(
        .reset(reset),
        .clk(clk),
        .instruction(instruction),
        .inM(inM),
        .writeM(writeM),
        .addressM(addressM),
        .outM(outM),
        .pc(pc)
    );

    // The RAM is synchronous,
    // the data is written into the RAM on every clock cycle
    // but the data is read constantly immediately
    RAM ram(
        .clk(clk),
        .load(writeM),
        .address(addressM),
        .in(outM),
        .out(inM)
    );

endmodule;