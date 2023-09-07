

module sub_sub_add (
    input [7:0] num1,
    input [7:0] num2,
    input [7:0] num3,
    output [7:0] result
);
    wire [7:0] num1_a2;
    wire [7:0] num2_a2;
    
    assign num1_a2 = ~num1 + 1;
    assign num2_a2 = ~num2 + 1;
    assign result = num1_a2 + num2_a2 + num3;
endmodule
