.PHONY: DFlipFlop Bit Register DMux8Way RAM8 RAM64 RAM512 RAM4K RAM16K PC clean

DFlipFlop:
	iverilog -o DFlipFlop/sim.out \
	    DFlipFlop/DFF.v DFlipFlop/Test.v
	vvp DFlipFlop/sim.out
	gtkwave DFlipFlop/Test.vcd

Bit:
	iverilog -o Bit/sim.out \
		DFlipFlop/DFF.v \
	    Bit/Bit.v Bit/Test.v
	vvp Bit/sim.out
	gtkwave Bit/Test.vcd

Register:
	iverilog -o Register/sim.out \
		DFlipFlop/DFF.v Bit/Bit.v \
		Register/Register.v Register/Test.v
	vvp Register/sim.out
	gtkwave Register/Test.vcd

DMux8Way:
	iverilog -o DMux8Way/sim.out \
	    DMux8Way/DMux8Way.v DMux8Way/Test.v
	vvp DMux8Way/sim.out
	gtkwave DMux8Way/Test.vcd

RAM8:
	iverilog -o RAM8/sim.out \
		DMux8Way/DMux8Way.v Mux8Way16/Mux8Way16.v \
		Register/Register.v Bit/Bit.v DFlipFlop/DFF.v \
		RAM8/RAM8.v RAM8/Test.v
	vvp RAM8/sim.out
	gtkwave RAM8/Test.vcd

RAM64:
	iverilog -o RAM64/sim.out \
		DMux8Way/DMux8Way.v Mux8Way16/Mux8Way16.v \
		Register/Register.v Bit/Bit.v DFlipFlop/DFF.v \
		RAM8/RAM8.v \
		RAM64/RAM64.v RAM64/Test.v
	vvp RAM64/sim.out
	gtkwave RAM64/Test.vcd

RAM512:
	iverilog -o RAM512/sim.out \
		DMux8Way/DMux8Way.v Mux8Way16/Mux8Way16.v \
		Register/Register.v Bit/Bit.v DFlipFlop/DFF.v \
		RAM8/RAM8.v RAM64/RAM64.v \
		RAM512/RAM512.v RAM512/Test.v
	vvp RAM512/sim.out
	gtkwave RAM512/Test.vcd

RAM4K:
	iverilog -o RAM4K/sim.out \
		DMux8Way/DMux8Way.v Mux8Way16/Mux8Way16.v \
		Register/Register.v Bit/Bit.v DFlipFlop/DFF.v \
		RAM8/RAM8.v RAM64/RAM64.v RAM512/RAM512.v \
		RAM4K/RAM4K.v RAM4K/Test.v
	vvp RAM4K/sim.out
	gtkwave RAM4K/Test.vcd

RAM16K:
	iverilog -o RAM16K/sim.out \
		DMux4Way/DMux4Way.v Mux4Way16/Mux4Way16.v \
		DMux8Way/DMux8Way.v Mux8Way16/Mux8Way16.v \
		Register/Register.v Bit/Bit.v DFlipFlop/DFF.v \
		RAM8/RAM8.v RAM64/RAM64.v RAM512/RAM512.v RAM4K/RAM4K.v \
		RAM16K/RAM16K.v RAM16K/Test.v
	vvp RAM16K/sim.out
	gtkwave RAM16K/Test.vcd

PC:
	iverilog -o PC/sim.out \
		Register/Register.v Bit/Bit.v DFlipFlop/DFF.v \
		PC/PC.v PC/Test.v
	vvp PC/sim.out
	gtkwave PC/Test.vcd

clean:
	rm -f */sim.out */Test.vcd
