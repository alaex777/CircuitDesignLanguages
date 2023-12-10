// ВНИМАНИЕ!
// Можно изменять ТОЛЬКО части кода, помеченные "(*)",
//   и ТОЛЬКО так, как написано у "(*)".
module main(x, on, start, y, s, b, regime, active, clk, rst);
  // // (*) По необходимости можно добавть "reg" в объявлениях выходных точек, задающихся в управляющем автомате.
  input [7:0] x;
  input [1:0] on;
  input start;
  output [7:0] y;
  output [2:0] s;
  output b;
  output reg active;
  output reg [1:0] regime;
  input clk, rst;
  
  // (*) По необходимости можно заменить wire на reg для любых точек далее.
  reg [1:0] y_select_next, s_step;
  reg y_en, s_en, y_upd, s_sub, s_zero;
  
  // Основная часть операционного автомата.
  datapath _datapath(
    .x(x),
    .y(y),
    .s(s),
    .b(b),
    .s_en(s_en),
    .s_step(s_step),
    .s_sub(s_sub),
    .s_zero(s_zero),
    .y_en(y_en),
    .y_select_next(y_select_next),
    .y_upd(y_upd),
    .clk(clk),
    .rst(rst)
  );
  
  // Распознавание свойств данных в операционном автомате.
  // (*) Здесь следует по необходимости объявить новые управляющие точки
  //   и реализовать задающие их подсхемы
  //   (преобразующие данные в управление).
  reg [2:0] count;
  
  // Управляющий автомат.
  // (*) Здесь следует написать схему, основная часть которой - это
  //   типовая реализация управляющего символьного автомата,
  //   заставляющая схему main выполняться согласно условию.
  always @(posedge clk or posedge rst)

    if (rst) begin
      regime <= 0;
    end

    else begin
      if (regime === 0) begin
        s_en <= 0;
        y_en <= 0;
        active <= 0;
        regime <= on;
      end

      if (regime === 1) begin
        if (start) begin
          active <= 1;
          s_en <= 1;
          s_zero <= 1;
          s_sub <= 0;
          s_step <= 0;
          count <= 0;
        end

        else active <= 0;

        if (active === 1) begin
          if (count === 0) begin
            s_en <= 1;
            s_zero <= 0;
            s_sub <= 0;
            s_step <= 2;
            count <= 1;
          end
          else if (count === 1) begin
            s_en <= 1;
            s_zero <= 0;
            s_sub <= 0;
            s_step <= 2;
            count <= 2;
          end
          else if (count === 2) begin
            s_en <= 1;
            s_zero <= 0;
            s_sub <= 0;
            s_step <= 2;
            count <= 3;
          end
          else if (count === 3) begin
            s_en <= 0;
            count <= 4;
          end
          else if (count === 4) begin
            s_en <= 1;
            s_zero <= 1;
            s_sub <= 0;
            s_step <= 0;
            regime <= 0;
            count <= 0;
          end
        end
      end

      else if (regime === 2) begin
        if (start) begin
          if (s === 7) begin
            y_en <= 1;
            y_upd <= 1;
            y_select_next <= 3;
          end

          s_en <= 1;
          active <= 0;
          s_step <= 1;
          s_sub <= 1;
          s_zero <= 0;
        end

        else begin
          s_en <= 0;
          y_en <= 0;
          regime <= 0;
          count <= 0;
        end
      end

      else if (regime === 3) begin
        active <= 0;
        if (count === 0) begin
          y_en <= 1;
          y_upd <= 0;
          count <= 1;
        end

        else if (count === 1) begin
          y_en <= 1;
          y_upd <= 1;
          y_select_next <= 2;
          count <= 2;
        end

        else if (count === 2) begin
          y_en <= 0;
          s_en <= 1;
          s_step <= 1;
          s_sub <= 0;
          s_zero <= 0;
          count <= 3;
        end

        else if (count === 3) begin
          s_en <= 0;
          y_en <= 0;
          count <= 4;
        end

        else if (count === 4) begin
          regime <= 0;
          count <= 0;
        end
      end
    end

endmodule
