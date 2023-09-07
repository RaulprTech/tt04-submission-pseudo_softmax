
// `include "FLP_adder.v"
// `include "First_stage_FLP_adder.v"

module FLP_adder_tree #(
  parameter NUM_INPUTS=10, parameter EXP_WIDTH=9, parameter MANT_WIDTH=8
) (
  input clk,
  input [NUM_INPUTS*MANT_WIDTH-1:0] input_bus,
  output [EXP_WIDTH-1:0] exp,
  output [MANT_WIDTH-1:0] mant
);

  wire [EXP_WIDTH-1:0] exp_n[NUM_INPUTS-1:0];
  wire [MANT_WIDTH-1:0] mant_n[NUM_INPUTS-1:0];
  
//  wire exp_bus[NUM_INPUTS*EXP_WIDTH*((NUM_INPUTS/2)-1):0];
//  wire mant_bus[NUM_INPUTS*MANT_WIDTH*((NUM_INPUTS/2)-1):0];
  wire [NUM_INPUTS*EXP_WIDTH*((NUM_INPUTS/2)-1):0] exp_bus;
  wire [NUM_INPUTS*MANT_WIDTH*((NUM_INPUTS/2)-1):0] mant_bus;
 
  
//  wire [MANT_WIDTH-1:0] x[NUM_INPUTS-1:0];


genvar i;
generate
  for (i = 0; i < NUM_INPUTS/2; i = i + 1) begin
    First_stage_FLP_adder adder_first(
      .clk(clk),
      .exp1(input_bus[2*i*MANT_WIDTH +: MANT_WIDTH]),
      .exp2(input_bus[(2*i+1)*MANT_WIDTH +: MANT_WIDTH]),
      .exp(exp_bus[i*EXP_WIDTH+:EXP_WIDTH]),
      .mant(mant_bus[i*MANT_WIDTH+:MANT_WIDTH])
//      .mant(mant_bus[MANT_WIDTH+:i*NUM_INPUTS])
    );
  end
endgenerate


  generate
    for (i = 0; i < NUM_INPUTS/2-1; i = i + 1) begin
      FLP_adder adder(
        .clk(clk),
        .exp1(exp_bus[2*i*EXP_WIDTH+:EXP_WIDTH]),
        .exp2(exp_bus[(2*i+1)*EXP_WIDTH+:EXP_WIDTH]),
        .mant1(mant_bus[2*i*MANT_WIDTH +: MANT_WIDTH]),
        .mant2(mant_bus[(2*i+1)*MANT_WIDTH +: MANT_WIDTH]),
        .exp(exp_bus[(i+(NUM_INPUTS/2))*EXP_WIDTH+:EXP_WIDTH]),
        .mant(mant_bus[(i+(NUM_INPUTS/2))*MANT_WIDTH+:MANT_WIDTH])
      );
    end
  endgenerate

//  generate
//    for (i = 0; i < NUM_INPUTS/2-1; i = i + 1) begin
//      FLP_adder adder(
//        .clk(clk),
//        .exp1(exp_n[2*i][EXP_WIDTH-1:0]),
//        .exp2(exp_n[(2*i)+1][EXP_WIDTH-1:0]),
//        .mant1(mant_n[2*i]),
//        .mant2(mant_n[(2*i)+1]),
//        .exp(exp_n[i+NUM_INPUTS/2]),
//        .mant(mant_n[i+NUM_INPUTS/2])
//      );
//    end
//  endgenerate


  assign exp = exp_bus[(NUM_INPUTS-2)*EXP_WIDTH+:EXP_WIDTH];
  assign mant = mant_bus[(NUM_INPUTS-2)*MANT_WIDTH+:MANT_WIDTH];


endmodule
