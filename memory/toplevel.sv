/* 
module memory(
    input logic [3:0] keys,
    input logic [1:0] where_store,
    input logic clock,
    input logic [1:0] what_display, GETTING RID OF 
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
/*

module toplevel(
  input logic [3:0] keys,
  input logic [1:0] where_store,
  input logic clock,
  output logic [10:0] display,
);

logic [10:0] result;
logic [10:0] a, b;
logic [1:0] operator;

memory block1 (.keys(keys), .where_store(where_store), .clock(clock), .a(a), .b(b), .display(display),
.operator(operator), .result(result))
alu_datapath block2 (.operation(operator), .a(a), .b(b), .result(result))
