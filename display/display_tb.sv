`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2026 11:32:54 PM
// Design Name: 
// Module Name: display_tb
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


module display_tb(
    );
    logic clock=0;
    logic signed [10:0] to_display;
    logic [3:0] anodes;
    logic [7:0] cathodes;
    
    display dut ( .clock(clock), .to_display(to_display), .anodes(anodes), .cathodes(cathodes) );
    
    initial begin
        to_display = 1;
        #100;
        
        to_display = 36;
        #100;
        
        to_display = -87;
        #100;
        
        to_display = 389;
        #100;
        
        to_display = -843;
        #100;
        $finish;
    end
    
    always begin
        #1 clock = ~clock;
    end
    
endmodule
