`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2026 07:02:11 PM
// Design Name: 
// Module Name: alu_datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_datapath(
    input logic [1:0] alu_operator,
    input logic signed [10:0] alu_a,
    input logic signed [10:0] alu_b,
    output logic signed [10:0] alu_result
    );
    always_comb begin
    // defining the operations
    // 00 = add      01 = subtract
    // 10 = divide   11 = multiply
        case (alu_operator)
            2'b00: begin //addition
                assign alu_result = alu_a + alu_b;
            end
            2'b01: begin //subtraction
                assign alu_result = alu_a - alu_b;
            end
            2'b10: begin //division
                assign alu_result = alu_a/alu_b;
            end
            2'b11: begin //multiplication
                assign alu_result = alu_a * alu_b;
            end
        endcase
    end
    
    
endmodule
