`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2026 06:50:36 PM
// Design Name: 
// Module Name: memory2_tb
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


module memory2_tb(
    );
    logic [3:0] keys;
    logic [1:0] where_store, what_display;
    logic clock = 0, write_enable;
    logic signed [10:0] result;
    logic signed [10:0] a, b;
    logic [10:0] display;
    logic [1:0] operator;
    logic [1:0] state;
    
    memory2 dut (.keys(keys), .where_store(where_store), .what_display(what_display), .clock(clock), 
    .write_enable(write_enable), .result(result), .a(a), .b(b), .display(display), .operator(operator), .state(state)
    );
    
    always begin
        #5 clock = ~clock;
    end
    
    initial begin
        where_store = 2'b00; what_display = 2'b00; keys = 4'b0010; 
        write_enable = 1; #10; write_enable = 0; #15; 
        
        where_store = 2'b01; what_display = 2'b01; keys = 4'b1010; 
        write_enable = 1; #10; write_enable = 0; #15; 
        
        where_store = 2'b10; what_display = 2'b10; keys = 4'b0010;
        write_enable = 1; #10; write_enable = 0; #15;
        
        where_store = 2'b11; what_display = 2'b11; result = 11'b00000000100;
        write_enable = 1; #10; write_enable = 0; #15;
        $finish;
    end
    
endmodule
