
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2026 11:30:55 PM
// Design Name: 
// Module Name: testing_tb
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
`timescale 1ns / 1ps
//the time units for this program is 1ns
//when graphing, it'll make a point every 1ps

module testing_tb;
    //defining variables
    logic a; 
    logic b;
    logic y;
    //summoning the testing module and setting the defined
    //variable "a" in the testbench to be the same as the 
    //input "a" (which is the ".a" in testing module.
    // then doing the same thing for b and y. 
    testing dut (.a(a), .b(b), .y(y) );
    //initial meaning it runs it once
    initial begin
    //setting the values for a and b, then waiting 10 units
    //which was defined as 1ns
        a = 0; b = 0;      #10;
        a = 0; b = 1;      #10;
        a = 1; b = 0;      #10;
        a = 1; b = 1;      #10;
    //end the program for sure even though we don't need
    //to since we used an initial
        $finish;
    end //end the initial 
endmodule //end the module
