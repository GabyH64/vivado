`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2026 11:40:08 PM
// Design Name: 
// Module Name: memory_tb
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


module memory_tb(
    );
     logic [3:0] keys;    
     logic [1:0] where_store;
     logic clock;        
     logic [1:0] what_display;
     logic [10:0] result; 
     logic [10:0] a, b, display;
     logic [1:0] operator;
    
    memory dut ( .keys(keys), .where_store(where_store), .clock(clock), .what_display(what_display),
    .result(result), .a(a), .b(b), .display(display), .operator(operator) );
    always begin
        clock = ~clock;
    end
    
    initial begin
        where_store = 2'b00; keys = 4'b0010; what_display = 2'b00; #10;
        where_store = 2'b01; keys = 4'b1010; what_display = 2'b01; #10;
        where_store = 2'b10; keys = 4'b0001; what_display = 2'b10; #10;
        where_store = 2'b11; result = 4'b0011; what_display = 2'b11; #10;
    
    $finish;
    end
    
    
endmodule
