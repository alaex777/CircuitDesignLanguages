module main(in, op, apply, tail, valid, empty, clk, reset);
    parameter WIDTH = 8;
    parameter QUEUE_SIZE = 5;

    input clk, reset, apply;
    input [WIDTH - 1 : 0] in;
    input [2 : 0] op;

    output reg [WIDTH - 1 : 0] tail;
    output reg valid = 1;
    output reg empty = 1;

    reg [WIDTH - 1 : 0] queue [QUEUE_SIZE-1 : 0];
    reg [2 : 0] size = 0;
    reg [WIDTH - 1 : 0] op1, op2;
    integer i;

    always @(posedge clk or posedge reset)
        if (reset) begin
            valid = 1;
            empty = 1;
            size = 0;
        end

        else
            if (apply) begin
                if (op === 0) begin
                    if (size === 5) valid = 0;
                    else begin
                        size = size + 1;
                        queue[size - 1] = in;
                        tail = queue[size - 1];
                        empty = 0;
                    end
                end
                
                else if (op === 1) begin
                    if (size === 0) valid = 0;
                    else begin
                        for (i = 0; i < QUEUE_SIZE - 1; i = i + 1) begin
                            queue[i] = queue[i+1];
                        end;

                        queue[size - 1] = 8'bx;

                        size = size - 1;
                        if (size === 0) empty = 1;
                    end
                end
                
                else if (op === 2) begin
                    if (size < 2) valid = 0;
                    else begin
                        op1 = queue[0];
                        op2 = queue[1];

                        for (i = 0; i < QUEUE_SIZE - 2; i = i + 1) begin
                            queue[i] = queue[i+2];
                        end;

                        queue[size - 1] = 8'bx;
                        queue[size - 2] = op1 + op2;

                        size = size - 1;
                        tail = queue[size - 1];
                    end
                end
                
                else if (op === 3) begin
                    if (size < 2) valid = 0;
                    else begin
                        op1 = queue[0];
                        op2 = queue[1];

                        for (i = 0; i < QUEUE_SIZE - 2; i = i + 1) begin
                            queue[i] = queue[i+2];
                        end;

                        queue[size - 1] = 8'bx;
                        queue[size - 2] = op1 * op2;

                        size = size - 1;
                        tail = queue[size - 1];
                    end
                end

                else if (op === 4) begin
                    if (size < 2) valid = 0;
                    else begin
                        op1 = queue[0];
                        op2 = queue[1];

                        for (i = 0; i < QUEUE_SIZE - 2; i = i + 1) begin
                            queue[i] = queue[i+2];
                        end;

                        queue[size - 1] = 8'bx;
                        queue[size - 2] = op2 - op1;

                        size = size - 1;
                        tail = queue[size - 1];
                    end
                end
                
                else if (op === 5) begin
                    if (size < 2) valid = 0;
                    else begin
                        op1 = queue[0];
                        op2 = queue[1];

                        if (op1 === 0) valid = 0;
                        else begin
                            for (i = 0; i < QUEUE_SIZE - 2; i = i + 1) begin
                                queue[i] = queue[i+2];
                            end;

                            queue[size - 1] = 8'bx;
                            queue[size - 2] = op2 / op1;

                            size = size - 1;
                            tail = queue[size - 1];
                        end
                    end
                end
                
                else if (op === 6) begin
                    if (size < 2) valid = 0;
                    else begin
                        op1 = queue[0];
                        op2 = queue[1];

                        if (op1 === 0) valid = 0;
                        else begin
                            for (i = 0; i < QUEUE_SIZE - 2; i = i + 1) begin
                                queue[i] = queue[i+2];
                            end;

                            queue[size - 1] = 8'bx;
                            queue[size - 2] = op2 % op1;

                            size = size - 1;
                            tail = queue[size - 1];
                        end
                    end
                end
                
                else begin
                    valid = 0;
                end
            end

endmodule // counter
