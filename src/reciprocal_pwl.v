
// `include "sub_sub_add.v"
// `include "shift_reg.v"


//`define X1 6'h110011   //  1.59375   -   1.10011
//`define X2 4'h1001     // 1.125     -   1.001

// `define X1 8'h00110011   //  1.59375   -   1.10011
// `define X2 8'h00001001     // 1.125     -   1.001

module reciprocal_pwl #(parameter MANT_WIDTH = 8)(
  input clk,
  input [MANT_WIDTH-1:0] in,
  output [MANT_WIDTH-1:0] out
);
  
  wire signal_1bit;
  wire [MANT_WIDTH-1:0] signal_data;
  
  wire [MANT_WIDTH-1:0] shifted_value1;
  wire [MANT_WIDTH-1:0] shifted_value2;
  wire [MANT_WIDTH-1:0] shifted_value3;
  wire [MANT_WIDTH-1:0] shifted_value4;
  
  wire [MANT_WIDTH-1:0] sum1;
  wire [MANT_WIDTH-1:0] sum2;

  assign signal_1bit = in[MANT_WIDTH-1];
  
  // Registro de desplazamiento con shift_in fijo de 1
  shift_reg reg1(
    .clk(clk),
    .data_in(in),
    .shift_in(8'h01),
    .data_out(shifted_value1)
  );
  
  // Registro de desplazamiento con shift_in fijo de 3
  shift_reg reg2(
    .clk(clk),
    .data_in(in),
    .shift_in(8'h03),
    .data_out(shifted_value2)
  );
  
  sub_sub_add adder1(
    .num1(shifted_value1),
    .num2(shifted_value2),
    .num3(8'h00110011),
    .result(sum1)
  );
  
  // Registro de desplazamiento con shift_in fijo de 2
  shift_reg reg3(
    .clk(clk),
    .data_in(signal_data),
    .shift_in(8'h02),
    .data_out(shifted_value3)
  );
  
  // Registro de desplazamiento con shift_in fijo de 4
  shift_reg reg4(
    .clk(clk),
    .data_in(signal_data),
    .shift_in(8'h04),
    .data_out(shifted_value4)
  );
  
  sub_sub_add adder2(
    .num1(shifted_value3),
    .num2(shifted_value4),
    .num3(8'h00001001),
    .result(sum2)
  );
  
  // Mux selecciona la salida dependiendo si signal_1bit es 0 o 1
  assign out = signal_1bit ? sum2 : sum1;
  
endmodule

