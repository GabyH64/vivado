`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2026 12:50:22 AM
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
  logic [3:0] keys;
  logic [1:0] where_store;
  logic clock;
  logic [1:0] what_display;
  logic [10:0] result;
  logic [10:0] a, b, display;
  logic [1:0] operator;
  logic [1:0] output_nextstate;
  logic [1:0] state;

  toplevel dut (.keys(keys), .where_store(where_store), .clock(clock), .what_display(what_display),
              .result(result), .a(a), .b(b), .display(display), .operator(operator));

  always begin
        #1 clock = ~clock;
    end

  initial begin
    where_store = 2'b00; #10; keys = 4'b0010; what_display = 2'b00; #100;
    where_store = 2'b01; #10; keys = 4'b1010; what_display = 2'b01; #100;
    where_store = 2'b10; #10; keys = 4'b0001; what_display = 2'b10; #100;
    where_store = 2'b11; #10; what_display = 2'b11; #100;

    $finish;
  end
  endmodule
