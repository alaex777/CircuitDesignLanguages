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
        #10
        if (tail !== 8'bx) $error ("tail is not empty!");
        op = 0;
        in = 4;

        #10
        // Проверяем, что при apply = 0 ничего не меняется
        if (tail !== 8'bx) $error ("tail is not empty!");
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        apply = 1;

        #10
        // Проверяем, что при apply = 1 и op = 0 добавляется число 4
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");

        #46
        // Проверяем, что очередь переполнилась после 5 добавленых элементов
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 0) $error ("queue is valid!");
        reset = 1;

        #1
        // Проверяем, что все асинхронно сбрасывается после reset = 1
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        reset = 0;

        #23
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 2;

        #10
        // Проверяем, сложение
        if (tail !== 8) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;

        #20
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 3;

        #10
        // Проверяем, умножение
        if (tail !== 16) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;

        #20
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 4;

        #10
        // Проверяем, вычитание
        if (tail !== 0) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;

        #20
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 5;

        #10
        // Проверяем, деление
        if (tail !== 1) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;

        #20
        // Проверяем, что записали два числа
        if (tail !== 4) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 6;

        #10
        // Проверяем, остаток от деления
        if (tail !== 0) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        in = 7;

        #10
        in = 86;
        
        #10
        op = 5;

        #10
        // Проверяем, правильность того, что на что делим
        if (tail !== 12) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        in = 7;

        #10
        in = 86;
        
        #10
        op = 6;

        #10
        // Проверяем, правильность того, от чего на что ищем остаток от деления
        if (tail !== 2) $error ("tail is not correct!");
        if (empty !== 0) $error ("queue is empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 1;

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        op = 0;
        in = 0;

        #10
        in = 86;
        
        #10
        op = 5;

        #10
        // Проверяем, что при делении на 0 получаем ошибку
        if (valid !== 0) $error ("queue is valid!");
        reset = 1;

        #10
        // Проверяем, что удалили числа
        if (empty !== 1) $error ("queue is not empty!");
        if (valid !== 1) $error ("queue is not valid!");
        reset = 0;
        op = 0;
        in = 0;

        #10
        in = 86;
        
        #10
        op = 6;

        #10
        // Проверяем, что при остатке от деления на 0 получаем ошибку
        if (valid !== 0) $error ("queue is valid!");
        reset = 1;

        $stop;
    end

    main test_queue (in, op, apply, tail, valid, empty, clk, reset);

    initial
        $monitor("At time %t, tail = %h (%0d), empty = %h, valid = %h", $time, tail, tail, empty, valid);
endmodule // test
