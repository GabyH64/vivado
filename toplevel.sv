`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2026 10:47:54 AM
// Design Name: 
// Module Name: toplevel
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


module toplevel(
        input logic clk,
        input logic [3:0] columns,
        output logic [3:0] anodes,
        output logic [7:0] cathodes,
        output logic [3:0] rows
    );
    
    alu_datapath block1 ( .alu_operator(operator), .alu_a(a), .alu_b(b), .alu_result(result));
    
    memory2 block2 (.keys(keys), .where_store(where_store), .what_display(what_display),
    .clock(clk), .write_enable(write_enable), .display(display), .a(a), .b(b), .result(result),
    .operator(operator));
    
    display block3 (.clock(clk), .to_display(display), .anodes(anodes), .cathodes(cathodes));
    
    keypad block4 (.clk(clk), .columns(columns), .rows(rows), .keys(keys), .key_release(key_release));
    
    controller block5 (.keys(keys), .clk(clk), .write_enable(write_enable), .where_store(where_store), 
    .what_display(what_display));
    
endmodule
