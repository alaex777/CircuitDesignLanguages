module testbench;
    reg clk = 0;
    always #5 clk = ~clk;

    reg [7:0] x;
    reg [1:0] on;
    reg start;
    wire [7:0] y;
    wire [2:0] s;
    wire b, active;
    wire [1:0] regime;
    reg rst;

    initial begin
        $dumpfile("test.vcd");
        rst = 1;

        #1
        rst = 0;
        on = 2;
        $dumpvars;

        #10
        start = 1;
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        start = 0;
        on = 3;
        x = 25;
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        on = 1;
        start = 0;
        $dumpvars;

        #10
        $dumpvars;

        #10
        start = 1;
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;

        #10
        $dumpvars;
        $finish;
    end

    main _main(
        .x(x),
        .y(y),
        .s(s),
        .b(b),
        .on(on),
        .start(start),
        .active(active),
        .regime(regime),
        .clk(clk),
        .rst(rst)
    );

    initial
        $monitor("At time %t, x=%h, y=%h, on=%h, start=%h, s=%h, b=%h, active=%h, regime=%h", $time, x, y, on, start, s, b, active, regime);

endmodule
