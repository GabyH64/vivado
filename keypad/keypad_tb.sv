`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2026 06:42:00 PM
// Design Name: 
// Module Name: keypad_tb
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


module keypad_tb(
    );
    logic clk=0;
    logic [3:0] columns, rows, keys;
    
    keypad dut ( .clk(clk), .columns(columns), .rows(rows), .keys(keys) );
    
    initial begin
        #2040
        $finish;
    end
    
    always begin
        #1 clk = ~clk;
    end
endmodule
