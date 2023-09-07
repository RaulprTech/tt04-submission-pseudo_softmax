
module shift_reg(
  input clk,
  input [7:0] data_in,
  input [7:0] shift_in,
  output reg [7:0] data_out
);
  always @(posedge clk) begin
    data_out <= data_in >> shift_in;
  end
endmodule
