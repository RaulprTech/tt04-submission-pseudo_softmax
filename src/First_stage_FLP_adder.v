

`include "abs.v"
`include "shift_reg.v"

module First_stage_FLP_adder #(
  parameter EXP_WIDTH=9, parameter MANT_WIDTH=8
) (
  input clk,
  input [MANT_WIDTH-1:0] exp1,
  input [MANT_WIDTH-1:0] exp2,
  output [EXP_WIDTH-1:0] exp,
  output [MANT_WIDTH-1:0] mant
);

  wire [EXP_WIDTH-1:0] sum;
  wire [EXP_WIDTH-1:0] max_exp;
  wire [EXP_WIDTH-1:0] abs_value;
  wire [EXP_WIDTH-1:0] shifted_value;
  wire ovf;

  // Resta de exponentes
  assign sum = exp1 - exp2;

  // Instancia de modulo de valor absoluto
  absolute_value abs(
    .value(sum),
    .abs_value(abs_value)
  );

  // Registro de desplazamiento de abs_value al valor 1
  assign shifted_value = 'd1 >> abs_value;

  // Mant es igual a la suma de shifted_value y 1, ovf toma el valor de desbordamiento
  assign {ovf, mant} = shifted_value + 'd1;

  // Mux selecciona el mayor valor de entrada
  assign max_exp = (exp1 >= exp2) ? exp1 : exp2;

  // la salida exp es la suma de max_exp con ovf
  assign exp = max_exp + ovf;

endmodule
