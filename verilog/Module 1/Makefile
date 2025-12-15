.PHONY: And And16 DMux DMux4Way DMux8Way Mux Mux16 Mux4Way16 Mux8Way16 Nand Not Not16 Or Or16 Or8Way Xor clean

And:
	iverilog -o And/sim.out \
		And/And.v And/Test.v
	vvp And/sim.out

And16:
	iverilog -o And16/sim.out \
		And16/And16.v And16/Test.v
	vvp And16/sim.out

DMux:
	iverilog -o DMux/sim.out \
		DMux/DMux.v DMux/Test.v
	vvp DMux/sim.out

DMux4Way:
	iverilog -o DMux4Way/sim.out \
		DMux4Way/DMux4Way.v DMux4Way/Test.v
	vvp DMux4Way/sim.out

DMux8Way:
	iverilog -o DMux8Way/sim.out \
		DMux8Way/DMux8Way.v DMux8Way/Test.v
	vvp DMux8Way/sim.out

Mux:
	iverilog -o Mux/sim.out \
		Mux/Mux.v Mux/Test.v
	vvp Mux/sim.out

Mux16:
	iverilog -o Mux16/sim.out \
		Mux16/Mux16.v Mux16/Test.v
	vvp Mux16/sim.out

Mux4Way16:
	iverilog -o Mux4Way16/sim.out \
		Mux4Way16/Mux4Way16.v Mux4Way16/Test.v
	vvp Mux4Way16/sim.out

Mux8Way16:
	iverilog -o Mux8Way16/sim.out \
		Mux8Way16/Mux8Way16.v Mux8Way16/Test.v
	vvp Mux8Way16/sim.out

Nand:
	iverilog -o Nand/sim.out \
		Nand/Nand.v Nand/Test.v
	vvp Nand/sim.out

Not:
	iverilog -o Not/sim.out \
		Not/Not.v Not/Test.v
	vvp Not/sim.out

Not16:
	iverilog -o Not16/sim.out \
		Not16/Not16.v Not16/Test.v
	vvp Not16/sim.out

Or:
	iverilog -o Or/sim.out \
		Or/Or.v Or/Test.v
	vvp Or/sim.out

Or16:
	iverilog -o Or16/sim.out \
		Or16/Or16.v Or16/Test.v
	vvp Or16/sim.out

Or8Way:
	iverilog -o Or8Way/sim.out \
		Or8Way/Or8Way.v Or8Way/Test.v
	vvp Or8Way/sim.out

Xor:
	iverilog -o Xor/sim.out \
		Xor/Xor.v Xor/Test.v
	vvp Xor/sim.out

clean:
	rm -f */sim.out */Test.vcd
