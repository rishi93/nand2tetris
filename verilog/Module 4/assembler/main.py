class Assembler:
    def __init__(self, file=None):
        # Print some information about the assembler
        print("Hack Assembler v1.0")

        # Decode a file
        if file:
            print("Decoding .hack file --> .bin file")
            self.lines = self.read_file(file)

        # Else just use the assembler object to decode lines in a script

    def decode_line(self, line):
        if self.is_a_instruction(line):
            binary_instr = self.a_instruction(line)
            return binary_instr
        elif self.is_c_instruction(line):
            binary_instr = self.c_instruction(line)
            return binary_instr
        else:
            raise Exception(f"Line {line} is neither A-instruction nor C-instruction")

    def decode(self, output_file):
        with open(output_file, 'w') as f:
            for line in self.lines:
                binary_instr = self.decode_line(line)
                f.write(binary_instr + "\n") 

        print(f"Successfully wrote binary output to {output_file}")


    def read_file(self, file):
        # Read the `.hack` file which contains the program
        # in the hack assembly language
        with open(file, 'r') as f:
            lines = f.readlines()
            # After stripping away the whitespace
            # Each line represents an instruction in it's symbolic form 
            lines = [line.strip() for line in lines]

        return lines

    def is_a_instruction(self, line):
        return line.startswith("@")

    def is_c_instruction(self, line):
        return not self.is_a_instruction(line)

    def a_instruction(self, line):
        # An A-instruction looks like: @15
        # Strip away the @ symbol and get the integer value
        val = int(line.lstrip("@"))

        # Prepend a 0 to the start and follow it with the 15-bit
        # value. This creates an A-instruction in binary form
        bin_val = format(val, '015b')

        if len(bin_val) > 15:
            raise Exception(f"Value {val} on line{line} is longer than 15 bits")

        return "0" + bin_val
    
    def jump_bit_mapping(self, jump):
        match jump:
            # No jump
            case "":
                return "000"
            # Jump if greater than
            case "JGT":
                return "001"
            # Jump if equal to
            case "JEQ":
                return "010"
            # Jump if greater than or equal to
            case "JGE":
                return "011"
            # Jump if less than
            case "JLT":
                return "100"
            # Jump is not equal to
            case "JNE":
                return "101"
            # Jump if less than or equal to
            case "JLE":
                return "110"
            # Unconditional jump
            case "JMP":
                return "111"
            
    def computation_bit_mapping(self, computation):
        match computation:
            case "0":
                return "101010"
            case "1":
                return "111111"
            case "-1":
                return "111010"
            case "D":
                return "001100"
            case "A" | "M":
                return "110000"
            case "!D":
                return "001101"
            case "!A" | "!M":
                return "110001"
            case "-D":
                return "001111"
            case "-A" | "-M":
                return "110011"
            case "D+1":
                return "011111"
            case "A+1" | "M+1":
                return "110111"
            case "D-1":
                return "001110"
            case "A-1" | "M-1":
                return "110010"
            case "D+A" | "D+M":
                return "000010"
            case "D-A" | "D-M":
                return "010011"
            case "A-D" | "M-D":
                return "000111"
            case "D&A" | "D&M":
                return "000000"
            case "D|A" | "D|M":
                return "010101"

    def c_instruction(self, instr):
        # A C-instruction is something that doesn't
        # start with a "@" and looks like below:
        # destination = computation ; jump
        equation, _, jump = instr.partition(";")

        destination, _, computation = equation.partition("=")

        # Strip away the white space if any on either side of
        # the equals to (=) sign
        destination = destination.strip()
        computation = computation.strip()

        print(f"dest = {destination}, comp = {computation}, jmp = {jump}")

        # The first 3 bits in a C-instruction are always 111
        c_instr = "111"

        # Add the "a" bit
        if "M" in computation:
            # If the second operator is "M"
            # Then the a-bit is 1, this is the
            # bit in the 12th position
            c_instr += "1"
        else:
            # If the second operator is "A"
            # Then the a-bit is 0, this is the
            # bit in the 12th position
            c_instr += "0"

        # Add the computation bits
        # Remove all the white space between the operator
        # and the operands
        computation = "".join(computation.split())

        c_instr += self.computation_bit_mapping(computation)

        c_instr += "1" if "A" in destination else "0"
        c_instr += "1" if "D" in destination else "0"
        c_instr += "1" if "M" in destination else "0"

        # Add the jump bits
        c_instr += self.jump_bit_mapping(jump)
    
        return c_instr 


if __name__ == "__main__":
    # Filename to read
    input_file = "prog.hack"
    output_file = "prog.bin"

    assembler = Assembler(input_file)
    assembler.decode(output_file)
