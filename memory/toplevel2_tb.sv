`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2026 07:35:52 PM
// Design Name: 
// Module Name: toplevel2_tb
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


module toplevel2_tb(
    );
    logic [3:0] keys;
    logic [1:0] where_store, what_display;
    logic clock = 0, write_enable=0;
    logic [1:0] state;
    logic [10:0] display;
    
    toplevel2 dut (.keys(keys), .where_store(where_store), .what_display(what_display),
    .clock(clock), .write_enable(write_enable), .state(state), .display(display));
    
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
        
        where_store = 2'b11; what_display = 2'b11;
        write_enable = 1; #10; write_enable = 0; #15;
        
        $finish;
    end
    
endmodule
