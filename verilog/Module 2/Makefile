.PHONY: HalfAdder FullAdder Add16 Inc16 ALU clean

HalfAdder:
	iverilog -o HalfAdder/sim.out \
	    HalfAdder/HalfAdder.v HalfAdder/Test.v
	vvp HalfAdder/sim.out

FullAdder:
	iverilog -o FullAdder/sim.out \
	    HalfAdder/HalfAdder.v \
	    FullAdder/FullAdder.v FullAdder/Test.v
	vvp FullAdder/sim.out

Add16:
	iverilog -o Add16/sim.out \
	    HalfAdder/HalfAdder.v \
	    FullAdder/FullAdder.v \
	    Add16/Add16.v Add16/Test.v
	vvp Add16/sim.out

Inc16:
	iverilog -o Inc16/sim.out \
		HalfAdder/HalfAdder.v \
		FullAdder/FullAdder.v \
		Add16/Add16.v \
		Inc16/Inc16.v Inc16/Test.v
	vvp Inc16/sim.out

ALU:
	iverilog -o ALU/sim.out \
		ALU/ALU.v ALU/Test.v
	vvp ALU/sim.out

clean:
	rm -f */sim.out */Test.vcd
