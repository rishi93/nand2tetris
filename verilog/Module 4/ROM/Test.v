module ROM_Test;
    reg [14:0] address;
    wire [15:0] instruction;

    ROM rom(
        .address(address),
        .out(instruction)
    );

    integer i;

    initial begin
        for (i = 0 ; i < 5; i = i + 1) begin
            address = i; #1;
            $display("address = %b, instruction = %b", address, instruction);
        end

        $finish;
    end
endmodule;