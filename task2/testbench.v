module testbench;
    reg reset = 0;
    reg apply = 0;
    reg [7 : 0] in;
    reg [2 : 0] op;

    reg clk = 0;
    always #5 clk = !clk;

    wire [7 : 0] tail;
    wire empty;
    wire valid;

    initial begin
        $dumpfile("test.vcd");
        reset = 1;

        #1
        reset = 0;

        #10
        if (tail !== 8'bx) $error ("tail is not empty!");
        op = 0;
        in = 4;
        $dumpvars(0, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что при apply = 0 ничего не меняется
        if (tail !== 8'bx) $error ("tail is not empty!");
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        apply = 1;
        $dumpvars(1, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что при apply = 1 и op = 0 добавляется число 4
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        $dumpvars(2, clk, reset, tail, empty, valid);

        #46
        // Проверяем, что очередь переполнилась после 5 добавленых элементов
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 0) $error ("queue is valid!");
        reset = 1;
        $dumpvars(3, clk, reset, tail, empty, valid);

        #1
        // Проверяем, что все асинхронно сбрасывается после reset = 1
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        reset = 0;
        $dumpvars(4, clk, reset, tail, empty, valid);

        #23
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 2;
        $dumpvars(5, clk, reset, tail, empty, valid);

        #10
        // Проверяем, сложение
        if (tail !== 8) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;
        $dumpvars(6, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        $dumpvars(7, clk, reset, tail, empty, valid);

        #20
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 3;
        $dumpvars(8, clk, reset, tail, empty, valid);

        #10
        // Проверяем, умножение
        if (tail !== 16) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;
        $dumpvars(9, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        $dumpvars(10, clk, reset, tail, empty, valid);

        #20
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 4;
        $dumpvars(11, clk, reset, tail, empty, valid);

        #10
        // Проверяем, вычитание
        if (tail !== 0) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;
        $dumpvars(12, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        $dumpvars(13, clk, reset, tail, empty, valid);

        #20
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 5;
        $dumpvars(14, clk, reset, tail, empty, valid);

        #10
        // Проверяем, деление
        if (tail !== 1) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;
        $dumpvars(15, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        $dumpvars(16, clk, reset, tail, empty, valid);

        #20
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 6;
        $dumpvars(17, clk, reset, tail, empty, valid);

        #10
        // Проверяем, остаток от деления
        if (tail !== 0) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;
        $dumpvars(18, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        in = 7;
        $dumpvars(19, clk, reset, tail, empty, valid);

        #10
        in = 86;
        $dumpvars(20, clk, reset, tail, empty, valid);
        
        #10
        op = 5;
        $dumpvars(21, clk, reset, tail, empty, valid);

        #10
        // Проверяем, правильность того, что на что делим
        if (tail !== 12) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;
        $dumpvars(22, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        in = 7;
        $dumpvars(23, clk, reset, tail, empty, valid);

        #10
        in = 86;
        $dumpvars(24, clk, reset, tail, empty, valid);
        
        #10
        op = 6;
        $dumpvars(25, clk, reset, tail, empty, valid);

        #10
        // Проверяем, правильность того, от чего на что ищем остаток от деления
        if (tail !== 2) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;
        $dumpvars(26, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        in = 0;
        $dumpvars(27, clk, reset, tail, empty, valid);

        #10
        in = 86;
        $dumpvars(28, clk, reset, tail, empty, valid);
        
        #10
        op = 5;
        $dumpvars(29, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что при делении на 0 получаем ошибку
        if (valid !== 0) $error ("queue is valid!");
        reset = 1;
        $dumpvars(30, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        reset = 0;
        op = 0;
        in = 0;
        $dumpvars(31, clk, reset, tail, empty, valid);

        #10
        in = 86;
        $dumpvars(32, clk, reset, tail, empty, valid);
        
        #10
        op = 6;
        $dumpvars(33, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что при остатке от деления на 0 получаем ошибку
        if (valid !== 0) $error ("queue is valid!");
        reset = 1;
        $dumpvars(34, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        reset = 0;
        op = 7;
        $dumpvars(35, clk, reset, tail, empty, valid);

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 0) $error ("queue is valid!");
        reset = 1;
        $dumpvars(36, clk, reset, tail, empty, valid);

        $stop;
    end

    main test_queue (in, op, apply, tail, valid, empty, clk, reset);

    initial
        $monitor("At time %t, tail = %h (%0d), empty = %h, valid = %h", $time, tail, tail, empty, valid);
endmodule // test
