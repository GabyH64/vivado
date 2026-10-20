`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2026 06:35:33 PM
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


/* 
module memory(
    input logic [3:0] keys,
    input logic [1:0] where_store,
    input logic clock,
    input logic [1:0] what_display,
    input logic [10:0] result,
    output logic [10:0] a, b, display,
    output logic [1:0] operator,
    output logic [1:0] output_nextstate,
    output logic [1:0] state   
    ); 
module alu_datapath(
    input logic [1:0] operation,
    input logic signed [10:0] a,
    input logic signed [10:0] b,
    output logic signed [10:0] result
    );
*/

module toplevel(
  input logic [3:0] keys,
  input logic [1:0] where_store, what_display,
  input logic clock,
  output logic signed [10:0] top_a, top_b, result,
  output logic [10:0] display,
  output logic [1:0] top_state
  );

logic [10:0] top_result;
logic [1:0] top_operator, top_state;

memory block1 (.keys(keys), .where_store(where_store), .what_display(what_display), .clock(clock), .a(top_a), .b(top_b),
    .display(display),
    .operator(top_operator), .result(top_result), .state(top_state));
alu_datapath block2 (.alu_operator(operator), .alu_a(a), .alu_b(b), .alu_result(result));

endmodule
