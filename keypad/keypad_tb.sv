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
    logic [2:0] state;
    
    keypad dut ( .clk(clk), .columns(columns), .rows(rows), .keys(keys), .counter1(counter1), .state(state),
        .counter2(counter2), .send_counter(send_counter), .wait_counter(wait_counter));
    
    initial begin //3200 for two whole cycles
        #50;
        columns = 4'b1000;
        #25;
        columns = 4'b0000;
        #250;
        
        columns = 4'b0010;
        #25
        columns = 4'b0000;
        
        
        #1600;
        $finish;
    end
    
    always begin
        #1 clk = ~clk;
    end
endmodule
