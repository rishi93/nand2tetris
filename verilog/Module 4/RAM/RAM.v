module RAM(
    input wire [15:0] in,
    input wire load, clk,
    output wire [15:0] out

);
    reg [15:0] memory [0:16383];

    always @(posedge clk) begin
        if (load) begin
            mem[address] <= in;
        end

        assign out = mem[address];
    end
endmodule;