`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2026 10:24:18 PM
// Design Name: 
// Module Name: memory
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


module memory(
    input logic [3:0] keys,
    input logic [1:0] where_store,
    input logic clock,
    input logic [1:0] what_display,
    input logic result [10:0],
    output logic [10:0] a, b, display,
    output logic [1:0] operator    
    );
    typedef enum logic [1:0]{
        save_a,
        save_op,
        save_b,
        save_result
    } state_t;
    
    state_t state = save_a;
    state_t next_state;
    
    // to change to next state
    always_ff @ (posedge clock) begin
        state <= next_state;
    end
    
    //next state logic
    
    
endmodule



