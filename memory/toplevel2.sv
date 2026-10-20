`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2026 07:28:31 PM
// Design Name: 
// Module Name: toplevel2
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
/*module alu_datapath(
    input logic [1:0] alu_operator,
    input logic signed [10:0] alu_a,
    input logic signed [10:0] alu_b,
    output logic signed [10:0] alu_result
    );
module memory2(
    input logic [3:0] keys,
    input logic [1:0] where_store, what_display,
    input logic clock, write_enable,
    input logic signed [10:0] result,
    output logic signed [10:0] a, b,
    output logic [10:0] display,
    output logic [1:0] operator,
    output logic [1:0] state
    );*/

module toplevel2(
    input logic [3:0] keys,
    input logic [1:0] where_store, what_display,
    input logic clock, write_enable,
    output logic [1:0] state,
    output logic [10:0] display,
    output logic signed [10:0] a, b
    );
    logic signed [10:0] result;
    logic [1:0] operator;
    
    alu_datapath block1 ( .alu_operator(operator), .alu_a(a), .alu_b(b), .alu_result(result));
    memory2 block2 (.keys(keys), .where_store(where_store), .what_display(what_display),
    .clock(clock), .write_enable(write_enable), .state(state), .display(display), .a(a), .b(b), .result(result));
    
endmodule
