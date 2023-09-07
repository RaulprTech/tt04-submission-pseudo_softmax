module abs #(parameter EXP_WIDTH = 9) (
  input signed [EXP_WIDTH-1:0] value,
  output [EXP_WIDTH-1:0] abs_value
);

reg [EXP_WIDTH-1:0] abs_val;

  always @* begin
    if (value < 0) begin
      abs_val = -value;
    end else begin
      abs_val <= value;
    end
  end

assign abs_value = abs_val;

endmodule
