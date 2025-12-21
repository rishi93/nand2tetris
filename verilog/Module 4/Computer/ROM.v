module ROM #(
    parameter FILE = ""
) (
    input wire [14:0] address,
    output reg [15:0] out
);
    /*
        We call this the ROM (Read Only Memory),
        since this is only used for reading the instructions
        from, we don't write anything here. If we want to write
        anything we use the RAM

        This is an asynchronous memory, we don't need any clock
        signal. As soon as the ROM gets an address, it outputs
        data at that location
    */
    reg [15:0] mem [0:32767];

    initial begin
        if (FILE == "") begin
            $display("ERROR: ROM parameter FILE is empty. Please provide a filepath when instantiating ROM.");
            $fatal;
        end else begin
            $readmemb(FILE, mem);
        end
    end

    always @(*) begin
        out = mem[address];
    end
endmodule;