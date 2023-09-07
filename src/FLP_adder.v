

// `include "abs.v"
// `include "shift_reg.v"

module FLP_adder #(
  parameter EXP_WIDTH = 9, parameter MANT_WIDTH = 8
) (
  input clk,
  input [EXP_WIDTH-1:0] exp1,
  input [EXP_WIDTH-1:0] exp2,
  input [MANT_WIDTH-1:0] mant1,
  input [MANT_WIDTH-1:0] mant2,
  output [MANT_WIDTH-1:0] mant,
  output [EXP_WIDTH-1:0] exp
);

  wire [EXP_WIDTH-1:0] sum;
  wire [EXP_WIDTH-1:0] max_exp;

  wire [EXP_WIDTH-1:0] abs_value;
  wire [MANT_WIDTH-1:0] data_in;
  wire [MANT_WIDTH-1:0] shifted_value;

  wire [EXP_WIDTH-1:0] add2;
  wire ovf;

  wire [MANT_WIDTH-1:0] shifted_value2;
  wire [MANT_WIDTH-1:0] mant_val;

  // Resta de exponentes
  assign sum = exp1 - exp2;

  // Instanciar el m�dulo de valor absoluto
  absolute_value abs(
    .value(sum),
    .abs_value(abs_value)
  );

  // Mux selecciona el mayor valor de entrada
  assign max_exp = (exp1 >= exp2) ? exp1 : exp2;

  // Mux selecciona dependiendo del mayor exp selecciona la mantisa
  assign data_in = (exp1 >= exp2) ? mant2 : mant1;

  // Mux selecciona dependiendo del mayor exp selecciona la mantisa
  assign add2 = (exp1 > exp2) ? mant1 : mant2;

  // Registro de desplazamiento de 2 variables
  shift_reg reg1(
    .clk(clk),
    .data_in(data_in),
    .shift_in(abs_value),
    .data_out(shifted_value)
  );

  // Mant es igual a la suma de shifted_value y add2, ovf toma el valor de desbordamiento
  assign {ovf, mant_val} = shifted_value + add2;

  // Registro de desplazamiento con shift_in fijo de 1
  shift_reg reg2(
    .clk(clk),
    .data_in(mant_val),
    .shift_in('d1),
    .data_out(shifted_value2)
  );

  // Mux selecciona dependiendo del mayor exp selecciona la mantisa
  assign mant = ovf ? shifted_value2 : mant_val;

  // la salida exp es la suma de max_exp con mant
  assign exp = max_exp + ovf;

endmodule
