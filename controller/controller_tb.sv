`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2026 09:34:41 AM
// Design Name: 
// Module Name: controller_tb
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


module controller_tb(
    );
    logic [3:0] keys;
    logic clk=0, key_release;
    
    controller dut ( .clk(clk), .keys(keys), .key_release(key_release), .write_enable(write_enable),
    .where_store(where_store), .what_display(what_display));
    
    initial begin
    $finish;
    end
    
    always begin
        #1 clk = ~clk;
    end
endmodule
