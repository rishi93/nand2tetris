module CPU(
    // input to Register M; contents of RAM[A]
    input wire [15:0] inM,
    // Instruction for execution
    input wire [15:0] instruction,
    // Reset signal
    // Reset = 1, puts the PC back to 0,
    // restarts the current program
    input wire reset, clk,
    // Output from register M
    output wire [15:0] outM,
    // write to M?
    output wire writeM,
    input wire [15:0] addressM,
    // Address of next instruction
    output wire [15:0] pc
);
    /*
        The CPU can execute two types of instructions

        1. A-instruction
        Looks like:
        ```
        @15
        ```
        In this case, the value 15 is stored in the A register. That's it.
        In the A-instruction, the first bit is 0
        example: @15 looks like 0000000000001111

        2. C-instruction
        This is a bit more complex.
        Looks like:
        ```
        destination = computation; jump
        In the C-instruction, the computation is mandatory, the destination is
        optional, in this case the `=` sign is omitted. the jump is also optional,
        in this case the `;` sign is omitted.
        ```
        In the C-instruction, the first-bit is 1, that's how you instantly know
        if it's an A-instruction or C-instruction 

        The entire bit-layout of the C-instruction is like so:
        111|a|cccccc|ddd|jjj

        The D register is something that can always be used in a computation
        If a == 0, then the computation involves the D and A registers
        If a == 1, then the computation involves the D and M registers

        The 6 "c" bits decide what kind of computation it is. In the ALU there are
        6 control bits that decide what kind of computation is carried out, these
        6 bits here are just that.
        Therefore we can read those 6 bits here as zx,nx,zy,ny,f,no

        The 3 "d" bits decide the destination where the result of the computation
        should be stored. There are 3 possible locations, the A register, the D
        register and the M register, and each of the bits represents just that

        Therefore we can read those 3 bits here as "store in a", "store in d" and
        "store in m". A 1 in the bit location representing a yes, and a 0 a no.
    */
 
    // 16-bit wires that transfer input to the A-register
    // and output from the A-register
    wire [15:0] inA, outA;
    // one bit wires that act as input control bits to the ALU
    wire zx, nx, zy, ny, f, no;
    // The 15-bit address to the program memory (RAM). This is the M-register
    wire [14:0] addressM;
    /*
        The control bits that represent what the result looks like:
            zr => the result is 0
            ng => the result is negative
            pos => the result is positive
            notPos => the result is not positive
    */
    wire zr, ng, pos, notPos;
    /*
        The jump bits, the PC jumps to A, depending on what the result looks like
        j1 == 1 -> Jump if result is less than 0
        j2 == 1 -> Jump if result is equal to 0
        j3 == 1 -> Jump if result is greater than 0

        j1 j2 j3
        0  0  0  -> no jump
        0  0  1  -> jump if result > 0
        0  1  0  -> jump if result == 0
        0  1  1  -> jump if result >= 0
        1  0  0  -> jump if result < 0
        1  0  1  -> jump if result != 0
        1  1  0  -> jump if result <= 0
        1  1  1  -> unconditional jump
    */
    wire j1, j2, j3, jump;

    // An A-instruction means you just store the instruction value in the
    // A-register,
    // If C-instruction, then you store the ALU output in the A-register
    assign inA = instruction[15]? outALU : instruction;

    // If it's an A-instruction, then we need to write the above value
    // into the A-register, or if it's a C-instruction whose destinations
    // includes the A-register, then also we need to write the above value
    // into the A-register
    assign loadA = ~instruction[15] | instruction[5];

    // If it's a C-instruction, then those 6 "c" bits represent
    // zx, nx, zy, ny, f and no respectively
    assign zx = instruction[11] & instruction[15];
    assign nx = instruction[10] & instruction[15];
    assign zy = instruction[9] & instruction[15];
    assign ny = instruction[8] & instruction[15];
    assign f  = instruction[7] & instruction[15];
    assign no = instruction[6] & instruction[15];

    ALU alu(
        .x(outD),
        .y(outAM),
        .zx(zx),
        .nx(nx),
        .zy(zy),
        .ny(ny),
        .f(f),
        .no(no),
        .out(outALU),
        .zr(zr),
        .ng(ng)
    );

    assign outM = outALU;

    // The A Register
    Register ARegister(
        .in(inA),
        .load(loadA),
        .out(outA),
        .clk(clk),
    );

    assign outM = outA[14:0];

    // So we know one of the operands is always the D-register. Now
    // is the other operand the M-register or the A-register. This
    // depends on the "a" bit which is position 12
    assign outAM = instruction[12] ? inM : outA;

    // If it's a C-instruction, AND the destination includes M, then writeM
    // should be enabled, to be able to write to the memory
    assign writeM = instruction[15] & instruction[3];

    // If it's a C-instruction, AND the destination includes D, then loadD
    // should be enabled, to be able to write to the D-register
    assign loadD = instruction[15] & instruction[4];

    Register DRegister(
        .in(outALU),
        .load(loadD),
        .clk(clk),
        .out(outD)
    );

    // Sign of the result
    assign notPos = zr | ng;
    assign pos = ~notPos;

    // Prepare for jump
    assign j1 = ng & instruction[2];
    assign j2 = zr & instruction[1];
    assign j3 = pos & instruction[0];

    // Jump if C-instruction, and any of the jump bits is set
    assign jump = instruction[15] & (j1 | j2 | j3);
    
    PC ProgramCounter(
        .in(inA),
        .load(jump)
        .reset(reset),
        .inc(1'b1),
        .clk(clk),
        .out(pc)
    );

endmodule;