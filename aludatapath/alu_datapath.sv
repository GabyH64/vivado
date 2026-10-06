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
    input logic [1:0] operation,
    input logic [10:0] a,
    input logic [10:0] b,
    output logic [10:0] result
    );
    // defining the operations
    // 00 = add      01 = subtract
    // 10 = divide   11 = multiply
    always_comb begin
        case (operation)
            2'b00: begin //addition
                assign result = a + b;
            end
            2'b01: begin //subtraction
                assign result = a - b;
            end
            2'b10: begin //division
                assign result = a/b;
            end
            2'b11: begin //multiplication
                assign result = a * b;
            end
        endcase
    end
    
    
endmodule
