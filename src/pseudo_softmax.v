

module pseudo_softmax(
  input clk,
  input [2:0] input_bus,
  output [2:0] mant_out,
  output [3:0] exp_out

);

  wire [3:0] exp_sum;
  wire [2:0] mant_sum;
  wire [3:0] exp_out_wire;
  wire [2:0] mant_out_wire;


  
  FLP_adder_tree adder_tree(
    .clk(clk),
    .input_bus(input_bus),
    .exp(exp_sum),
    .mant(mant_sum)
  );

  subtractors_array subtractors(
    .input_bus(input_bus),
    .exp_sum(exp_sum),
    .exp_out(exp_out_wire)
  );

  reciprocal_pwl pwl(
    .clk(clk),
    .in(mant_sum),
    .out(mant_out_wire)
  );
  
  assign exp_out = exp_out_wire;
  assign mant_out = mant_out_wire;

endmodule
