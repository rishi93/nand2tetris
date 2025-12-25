module Computer_Test;
    reg reset, clk;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    // Pass the ROM filepath into the Computer, which forwards it to ROM.
    // Change the string below to point to a different ROM image if needed.
    Computer #(.ROM_FILE("prog.bin")) computer(
        .reset(reset),
        .clk(clk)
    );

    task print_ram0;
    begin
        $display("RAM[0] = %d", computer.ram.mem[0]);
    end
    endtask

    integer i;

    initial begin
        // Press the reset button
        // It goes to 1, then bounces back to 0
        $display("--------------------");
        $display("finger on the reset button");
        reset = 1;
        $display("reset = %b", reset);
        #1;
        $display("finger off the reset button");
        reset = 0;
        $display("reset = %b", reset);
        $display("--------------------");

        for (i = 0; i <= 100; i = i + 1) begin
            $display("Clock cycle: %d", i+1);
            #2;
        end

        print_ram0();

        $finish;
    end

endmodule;