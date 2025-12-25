.PHONY: ALU CPU ROM RAM Computer clean

Register:
	iverilog -o Register/sim.out \
		Register/Register.v Register/Test.v
	vvp Register/sim.out
	gtkwave Register/Test.vcd

ALU:
	iverilog -o ALU/sim.out \
		ALU/ALU.v ALU/Test.v
	vvp ALU/sim.out
	gtkwave ALU/Test.vcd

CPU:
	iverilog -o CPU/sim.out \
		Register/Register.v PC/PC.v \
		ALU/ALU.v \
	    CPU/CPU.v CPU/Test.v
	vvp CPU/sim.out
	# no waveforms for CPU, it's quite complex
	# looking at the print statements should suffice

ROM:
	iverilog -o ROM/sim.out \
		ROM/ROM.v ROM/Test.v
	vvp ROM/sim.out
	gtkwave ROM/Test.vcd

RAM:
	iverilog -o RAM/sim.out \
		RAM/RAM.v RAM/Test.v
	vvp RAM/sim.out

Computer:
	# Convert the `prog.hack` written in symbolic hack assembly language
	# to binary machine instructions in `prog.bin`
	python assembler/main.py
	# Load the ROM with the `prog.bin` file and then run the entire computer
	iverilog -o Computer/sim.out \
		Register/Register.v PC/PC.v \
		ALU/ALU.v \
	    CPU/CPU.v RAM/RAM.v ROM/ROM.v \
		Computer/Computer.v Computer/Test.v
	vvp Computer/sim.out

clean:
	rm -f */*sim.out */*Test.vcd
