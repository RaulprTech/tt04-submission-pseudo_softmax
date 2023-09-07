

//module sub_sub_add(
//    input [7:0] num1,
//    input [7:0] num2,
//    input [5:0] num3,
//    output [8:0] result
//    );
//        wire [7:0] num1_a2;
//        wire [7:0] num2_a2;
    
//  assign num1_a2 = ~num1 + 1;
//  assign num2_a2 = ~num2 + 1;
//  assign result = num1_a2 - num2_a2 + num3;
//endmodule

module sub_sub_add #(parameter DATA_WIDTH = 8) (
    input [DATA_WIDTH-1:0] num1,
    input [DATA_WIDTH-1:0] num2,
    input [DATA_WIDTH-1:0] num3,
    output [DATA_WIDTH-1:0] result
);
    wire [DATA_WIDTH-1:0] num1_a2;
    wire [DATA_WIDTH-1:0] num2_a2;
    
    assign num1_a2 = ~num1 + 1;
    assign num2_a2 = ~num2 + 1;
    assign result = num1_a2 + num2_a2 + num3;
endmodule
