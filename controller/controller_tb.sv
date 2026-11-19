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
    logic [1:0] what_display, where_store;
    logic [3:0] state;
    
    controller dut ( .clk(clk), .keys(keys), .key_release(key_release), .write_enable(write_enable),
    .where_store(where_store), .what_display(what_display), .state(state));
    
    initial begin
    key_release = 0;
    keys = 4'b0010; // a should be 2
    #50;
    key_release = 1;
    #25;
    keys = 4'b1111;
    key_release = 0;
    #50
    keys = 4'b1010; // addition
    #50;
    key_release = 1;
    #25;
    keys = 4'b1111;
    key_release = 0;
    #50;
    keys = 4'b0010; //b should be 2
    #50;
    key_release = 1;
    #25;
    key_release = 0;
    #50;
    keys = 4'b1110; //equal sign
    #50;
    key_release = 1;
    #25;
    key_release = 0;
    #50
    #10
    $finish;
    end
    
    always begin
        #1 clk = ~clk;
    end
endmodule
