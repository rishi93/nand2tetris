module ALU_Test;
    reg [15:0] x, y;
    reg zx, nx, zy, ny, f, no;
    wire zr, ng;
    wire [15:0] out;

    ALU test(
        .x(x),
        .y(y),
        .zx(zx),
        .nx(nx),
        .zy(zy),
        .ny(ny),
        .f(f),
        .no(no),
        .out(out),
        .zr(zr),
        .ng(ng)
    );

    initial begin
        // Fix x and y to random inputs
        x = 16'b1010101010101010;
        y = 16'b0101010101010101;

        // Test out all computation possibilities

        // Test output => 0
        $display("out should be 0");
        zx = 1; nx = 0; zy = 1; ny = 0; f = 1; no = 0;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => 1
        $display("out should be 1");
        zx = 1; nx = 1; zy = 1; ny = 1; f = 1; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => -1
        $display("out should be -1");
        zx = 1; nx = 1; zy = 1; ny = 0; f = 1; no = 0;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => x
        $display("out should be x");
        zx = 0; nx = 0; zy = 1; ny = 1; f = 0; no = 0;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => y
        $display("out should be y");
        zx = 1; nx = 1; zy = 0; ny = 0; f = 0; no = 0;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => ~x
        $display("out should be ~x");
        zx = 0; nx = 0; zy = 1; ny = 1; f = 0; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => ~y
        $display("out should be ~y");
        zx = 1; nx = 1; zy = 0; ny = 0; f = 0; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => -x
        $display("out should be -x");
        zx = 0; nx = 0; zy = 1; ny = 1; f = 1; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => -y
        $display("out should be -y");
        zx = 1; nx = 1; zy = 0; ny = 0; f = 1; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => x + 1
        $display("out should be x+1");
        zx = 0; nx = 1; zy = 1; ny = 1; f = 1; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => y + 1
        $display("out sould be y+1");
        zx = 1; nx = 1; zy = 0; ny = 1; f = 1; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => x - 1
        $display("out should be x-1");
        zx = 0; nx = 0; zy = 1; ny = 1; f = 1; no = 0;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => y - 1
        $display("out should be y-1");
        zx = 1; nx = 1; zy = 0; ny = 0; f = 1; no = 0;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => x + y
        $display("out should be x+y");
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => x - y
        $display("out should be x-y");
        zx = 0; nx = 1; zy = 0; ny = 0; f = 1; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => y - x
        $display("out should be y-x");
        zx = 0; nx = 0; zy = 0; ny = 1; f = 1; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => x & y
        $display("out should be x&y");
        zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);

        // Test output => x | y
        $display("out should be x|y");
        zx = 0; nx = 1; zy = 0; ny = 1; f = 0; no = 1;
        #1 $display("x = %b, y = %b, out = %b", x, y, out);
    end

endmodule;