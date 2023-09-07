
module subtractors_array #(
  parameter NUM_INPUTS = 10,
  parameter EXP_WIDTH = 9,
  parameter MANT_WIDTH = 8
)(
  input [EXP_WIDTH-1:0] exp_sum,
  input [NUM_INPUTS*MANT_WIDTH-1:0] input_bus,
  output [NUM_INPUTS*EXP_WIDTH-1:0] exp_out

);

  wire [EXP_WIDTH-1:0] x[NUM_INPUTS-1:0];
  wire [EXP_WIDTH-1:0] exp_sust[NUM_INPUTS-1:0];

  genvar i;
  generate
    for (i = 0; i < NUM_INPUTS; i = i + 1) begin
      assign x[i] = input_bus[i*MANT_WIDTH +: MANT_WIDTH];
      assign exp_sust[i] = x[i] - exp_sum;
      assign exp_out[i*EXP_WIDTH +: EXP_WIDTH] = exp_sust[i];
    end
  endgenerate

endmodule
