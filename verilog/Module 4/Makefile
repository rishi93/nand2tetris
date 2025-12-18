.PHONY: ALU CPU clean

ALU:
	iverilog -o ALU/sim.out \
		ALU/ALU.v ALU/Test.v
	vvp ALU/sim.out
	gtkwave ALU/Test.vcd

CPU:
	iverilog -o CPU/sim.out \
		DFF/DFF.v Bit/Bit.v Register/Register.v PC/PC.v \
		ALU/ALU.v \
	    CPU/CPU.v CPU/Test.v
	vvp CPU/sim.out
	gtkwave CPU/Test.vcd

clean:
	rm -f */sim.out */Test.vcd
