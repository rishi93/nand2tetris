.PHONY: ALU CPU ROM RAM Computer clean

ALU:
	iverilog -o ALU/sim.out \
		ALU/ALU.v ALU/Test.v
	vvp ALU/sim.out
	gtkwave ALU/Test.vcd

CPU:
	iverilog -o CPU/sim.out \
		DFlipFlop/DFF.v Bit/Bit.v Register/Register.v PC/PC.v \
		ALU/ALU.v \
	    CPU/CPU.v CPU/Test.v
	vvp CPU/sim.out

ROM:
	iverilog -o Computer/ROM_sim.out \
		Computer/ROM.v Computer/ROM_Test.v
	vvp Computer/ROM_sim.out

RAM:
	iverilog -o Computer/RAM_sim.out \
		Computer/RAM.v Computer/RAM_Test.v
	vvp Computer/RAM_sim.out

Computer:
	python assembler/main.py
	iverilog -o Computer/Computer_sim.out \
		DFlipFlop/DFF.v Bit/Bit.v Register/Register.v PC/PC.v \
		ALU/ALU.v \
	    CPU/CPU.v Computer/RAM.v Computer/ROM.v \
		Computer/Computer.v Computer/Computer_Test.v
	vvp Computer/Computer_sim.out

clean:
	rm -f */*sim.out */*Test.vcd
