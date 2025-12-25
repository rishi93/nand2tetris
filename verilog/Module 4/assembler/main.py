import re
from pathlib import Path


class Assembler:
    def __init__(self, filename):
        filename = Path(filename)

        # Print some information about the assembler
        print("Hack Assembler v1.0")

        # Symbol table
        # Certain special symbols mean something in our assembly language
        # For example, the first 16 locations in the RAM are reserved for
        # special general purpose "virtual" registers. This ensures you
        # can refer to these registers by name, rather than by their actual
        # location. And the Assembler takes on the burden of associating the
        # names with their actual locations
        self.symbol_table = {
            "R0": 0,
            "R1": 1,
            "R2": 2,
            "R3": 3,
            "R4": 4,
            "R5": 5,
            "R6": 6,
            "R7": 7,
            "R8": 8,
            "R9": 9,
            "R10": 10,
            "R11": 11,
            "R12": 12,
            "R13": 13,
            "R14": 14,
            "R15": 15,
            # Some other symbols that we don't use currently. Will
            # become clear when we implement the higher level language
            # on top of this assembly language
            "SP": 0,
            "LCL": 1,
            "ARG": 2,
            "THIS": 3,
            "THAT": 4,
            # These base addresses for the screen memory map and the keyboard
            # memory map will change depending on the hardware
            "SCREEN": 16384,
            "KBD": 24576,
        }

        # Extract the lines from the assembly program
        print("Decoding .hack file --> .bin file")
        if filename.suffix != ".hack":
            raise Exception("The input needs to be a .hack file")

        self.lines = self.read_file(filename)

        # Build the symbol table
        self.build_symbol_table()

    def is_label(self, line):
        """If the current line contains a label

        Args:
            line (str): A line that has been stripped of any trailing comment
        """
        # The line has to start with ( and end with ) since we've stripped
        # everything else
        return line.startswith("(") and line.endswith(")")

    def get_label(self, line):
        """Extract the label name.

        A label looks like so:
        (LOOP)

        Label names are by convention capitalized

        Args:
            line (str): line with a label that has been stripped of any trailing
            comment
        """
        # The \( \) is for actually signifying paranthesis
        # The () inside is for capturing that part of the string
        # \w stands for alphabets (lower or uppercase),
        # digits and _ (underscore) character
        label_pattern = re.compile(r'\((\w+)\)')
        # We get back a "Match" object and you can extract the
        # matches via something called "groups". The group(0) is
        # for the entire matching pattern, and group(1) is for
        # the extracted group, the part in () in our pattern
        match_groups = re.match(label_pattern, line)
        label_name= match_groups.group(1)
        return label_name
    
    def is_variable(self, line):
        """Return true if the line contains a variable

        Args:
            line (str): line with a variable that has been stripped of any
            trailing comment
        """
        # Check if the line starts with a `@`
        if line.startswith('@'):
            # Remove the leading '@' symbol
            variable_name = line.removeprefix('@')
            # Check if what remains is a number
            # If it's a number, then it's not a variable,
            # but just a constant
            if variable_name.isdigit():
                return False
            else:
                return True
            
    def get_variable(self, line):
        variable_pattern = re.compile(r'@(\w+)')
        match_groups = re.match(variable_pattern, line)
        variable_name = match_groups.group(1)
        # If this is a variable that we haven't encountered yet
        # then we need to store it in the symbol table
        if variable_name not in self.symbol_table:
            return variable_name
        # If we've already seen it, then ignore it
        else:
            return None


    def build_symbol_table(self):
        """
        Go over the entire program and collect all the symbols encountered
        into the symbol table.

        Types of symbols:

        1. Labels
        Looks like this: (LOOP)
        In this case, this represents a location in the instruction memory.
        If we want to jump back to the instruction immediately following
        this label, then we can just load this address in the A-register with
        @LOOP

        2. Variables
        Looks like this: @x
        In this case, this represents a location in the data memory. If we
        want to store or retrieve something from this location, then instead
        of specifying the actual memory location, we just specify the memory
        location as @x

        3. The pre-defined symbols like R0, R1, ... R15 are already part of our
        symbol table. They always are. Nothing to do in this case
        """
        line_number = 0
        num_variables = 0

        for line in self.lines:
            line = self.strip_comment(line)
            if not line:
                # Ignore whitespace, or lines that are just comments
                continue
            elif self.is_label(line):
                label = self.get_label(line)
                # Extend the symbol table with this new label
                # This label points to the next line number
                # essentially RAM[line_number]
                self.symbol_table[label] = line_number
            elif self.is_variable(line):
                variable = self.get_variable(line)
                if variable:
                    # The first variable will be stored at memory location 16
                    # Subsequent variables will occupy subsequent locations
                    # The first 16 locations are reserved for R0, R1, ... R15
                    self.symbol_table[variable] = 16 + num_variables
                    num_variables += 1
                line_number += 1
            else:
                # Else we encountered a normal instruction
                line_number += 1
                # We don't do anything now. We are collecting all the symbols
                # into our symbol table now. Once we're done, we'll go over
                # the program once again to substitute all the symbols in the
                # symbol table with the actual memory values

        print(f"Successfully built symbol table")

    def decode(self, output_file):
        with open(output_file, "w") as f:
            for line in self.lines:
                # Ignore comments
                if self.is_comment(line):
                    continue
                # Ignore labels, we already built the symbol table
                # before running decode
                if self.is_label(line):
                    continue
                binary_instr = self.decode_line(line)
                f.write(binary_instr + "\n")

        print(f"Successfully wrote binary output to {output_file}")

    def strip_comment(self, line):
        """
        Removes the trailing comment on a line
        For example, if we have a line like this:
        D = D + M // stores the result of sum
        In this case, the comment needs to ignored

        Args:
            line (str): A line of hack assembly code
        """
        # Ignore the // separator and the comment as well
        line, _, _ = line.partition("//")
        return line.strip()

    def decode_line(self, line):
        # Remove any trailing comment
        line = self.strip_comment(line)

        if self.is_a_instruction(line):
            binary_instr = self.a_instruction(line)
            return binary_instr
        elif self.is_c_instruction(line):
            binary_instr = self.c_instruction(line)
            return binary_instr
        else:
            raise Exception(f"Line {line} is neither A-instruction nor C-instruction")

    def read_file(self, file):
        # Read the `.hack` file which contains the program
        # in the hack assembly language
        with open(file, "r") as f:
            lines = f.readlines()
            # After stripping away the whitespace
            # Each line represents an instruction in it's symbolic form
            lines = [line.strip() for line in lines]

        return lines

    def is_a_instruction(self, line):
        return line.startswith("@")

    def is_c_instruction(self, line):
        if self.is_a_instruction(line):
            return False
        if self.is_label(line):
            return False
        return True

    def is_comment(self, line):
        return line.startswith("//")

    def a_instruction(self, line):
        """
            An A-instruction looks like @item
            item can be one of several values
            @15 (or) @R1 (or) @x (or) @LOOP
            
            In the case of @15, it's a simple integer value
            In the case of @R1, it refers to a virtual register
            In the case of @x, it refers to a variable
            In the case of @LOOP, it refers to a label
        """

        # Strip away the @ symbol
        item = line.lstrip("@")

        # If item is a simple integer constant
        if item.isdigit():
            val = item
        # if item is a variable or a label
        elif item in self.symbol_table:
            val = self.symbol_table[item]
        
        bin_val = format(int(val), "015b")

        if len(bin_val) > 15:
            raise Exception(f"Value {val} on line{line} is longer than 15 bits")

        # Prepend a 0 to the start and follow it with the 15-bit
        # value. This creates an A-instruction in binary form
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

        # Strip away the white space if any on either side
        # of the semicolon (;)
        equation = equation.strip()
        jump = jump.strip()

        destination, _, computation = equation.partition("=")

        # If there is no = (equals to) sign
        # for example in
        # D; JMP
        # then destination will be D, and computation will be null
        # But this is wrong, computation needs to be D, and destination
        # needs to be null
        # TLDR; the computation can never be empty, the destination can be empty
        if not computation:
            computation = destination
            destination = ''

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
    input_file = Path("prog.hack")
    output_file = Path("prog.bin")

    assembler = Assembler(input_file)
    assembler.decode(output_file)
