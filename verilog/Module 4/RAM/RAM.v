module RAM(
    input wire [15:0] in,
    input wire [14:0] address,
    input wire load, clk,
    output wire [15:0] out

);
    // 16K (2^14) locations
    // Each location stores a 16-bit value
    reg [15:0] mem [0:16383];

    // synchronous write
    always @(posedge clk) begin
        if (load) begin
            mem[address] <= in;
        end
    end

    // asynchronous read
    assign out = mem[address];
endmodule;