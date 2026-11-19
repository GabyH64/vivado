`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2026 11:14:58 AM
// Design Name: 
// Module Name: toplevel_tb
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


module toplevel_tb(

    );
     logic clk=0;
     logic [3:0] columns;
     logic [3:0] anodes;
     logic [7:0] cathodes;
     logic [3:0] rows;
    
    toplevel dut ( .clk(clk), .columns(columns), .anodes(anodes), .cathodes(cathodes), .rows(rows));
    
    initial begin //3200 for two whole cycles
        #50
        $finish;
    end
    
    always begin
        #1 clk = ~clk;
    end
endmodule


