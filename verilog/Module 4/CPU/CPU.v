module CPU(
    // input to the memory
    input wire [15:0] inM,
    // Instruction for execution
    input wire [15:0] instruction,
    // Reset signal
    // Reset = 1, puts the PC back to 0,
    // restarts the current program
    input wire reset, clk,
    // write to memory?
    output wire writeM,
    // The 15-bit address to the memory
    output wire [14:0] addressM,
    // The 16-bit output to write to the memory
    output wire [15:0] outM,
    // Address of next instruction
    output wire [14:0] pc
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

    // If the instruction is a C-instruction or an A-instruction
    wire isCInstr, isAInstr;

    // 16-bit wires that transfer input to the A-register
    // and output from the A-register
    wire [15:0] inA, outA;
    wire loadA;

    // 16-bit wires that transfer input to the D-register
    // and output from the D-register
    wire [15:0] inD, outD;
    wire loadD;

    // The two operands to the ALU
    wire [15:0] x, y;
    // the first operand is always the Register-D
    // the second operand is either Register-A or memory location M,
    // depending on the "a" bit in position 12 like already explained above

    wire useM; // Should we use memory location M? If not, use register A 
    wire [15:0] outAOrM; // carries output from either A-register or memory location M

    // one bit wires that act as input control bits to the ALU
    wire zx, nx, zy, ny, f, no;

    // 16-bit output from the ALU 
    wire [15:0] outALU;

    /*
        The control bits that represent what the result looks like:
            zr => the result is 0
            ng => the result is negative
            pos => the result is positive
            notPos => the result is not positive
    */
    // the two control outputs from the ALU
    wire zr, ng;
    // further control pins derived from the outputs of the ALU
    wire pos, notPos;

    /*
        The destination bits
    */
    wire storeInA, storeInD, storeInM;

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
    wire [15:0] pc_16bit;

    assign isCInstr = instruction[15];
    assign isAInstr = ~isCInstr;

    // bits 14 and 13 are ignored in a C-instruction

    // So we know one of the operands is always the D-register. Now
    // is the other operand the A-register or the M-register? This
    // depends on the "a" bit which is position 12
    assign useM = isCInstr & instruction[12];

    // If it's a C-instruction, then those 6 "c" bits represent
    // zx, nx, zy, ny, f and no respectively
    assign zx = instruction[11] & isCInstr;
    assign nx = instruction[10] & isCInstr;
    assign zy = instruction[9] & isCInstr;
    assign ny = instruction[8] & isCInstr;
    assign f  = instruction[7] & isCInstr;
    assign no = instruction[6] & isCInstr;

    // The next 3 bits d1, d2, d3 determine where
    // the result of the computation should be stored
    assign storeInA = isCInstr & instruction[5];
    assign storeInD = isCInstr & instruction[4];
    assign storeInM = isCInstr & instruction[3];

    assign j1 = isCInstr & instruction[2];
    assign j2 = isCInstr & instruction[1];
    assign j3 = isCInstr & instruction[0];

    // Prepare for jump
    assign jumpLessThan = ng & j1;
    assign jumpEqualTo = zr & j2;
    assign jumpGreaterThan = pos & j3;

    // An A-instruction means you just store the instruction value in the
    // A-register,
    // If C-instruction, then you store the ALU output in the A-register
    assign inA = isAInstr ? instruction : outALU;

    // If it's an A-instruction, then we need to write the above value
    // into the A-register, or if it's a C-instruction whose destinations
    // includes the A-register, then also we need to write the above value
    // into the A-register
    assign loadA = isAInstr | storeInA;

    // The A Register
    Register ARegister(
        .in(inA),
        .load(loadA),
        .clk(clk),
        .out(outA)
    );

    // The address to be passed to the memory
    assign addressM = outA[14:0];

    assign outAOrM = useM ? inM : outA;

    // Now we prepare to pass two operands into the ALU
    assign x = outD;
    assign y = outAOrM;

    ALU alu(
        .x(x),
        .y(y),
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

    // Writing to the D-register
    assign inD = outALU;
    assign loadD = storeInD;

    Register DRegister(
        .in(inD),
        .load(loadD),
        .clk(clk),
        .out(outD)
    );

    // Writing to Memory

    // If it's a C-instruction, AND the destination includes M, then writeM
    // should be enabled, to be able to write to the memory
    assign outM = outALU;
    assign writeM = storeInM;

    // Prepare for the jump

    // Sign of the result
    assign notPos = zr | ng;
    assign pos = ~notPos;

    // Jump if C-instruction, and any of the jump bits is set
    assign jump = isCInstr & (
        jumpLessThan | 
        jumpEqualTo | 
        jumpGreaterThan
    );

    // The value of the A-register is always supplied to the Program Counter
    // but it loads that value only when there is a jump required
    PC ProgramCounter(
        .in(outA),
        .clk(clk),
        .load(jump),
        .reset(reset),
        .inc(1'b1),
        .out(pc_16bit)
    );

    // ignore the 15th bit, since pc can only represent positive numbers
    assign pc = pc_16bit[14:0];

endmodule;