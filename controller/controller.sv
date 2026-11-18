`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2026 08:50:26 PM
// Design Name: 
// Module Name: controller
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


module controller(
    input logic [3:0] keys,
    input logic clk,
    output logic write_enable,
    output logic [1:0] where_store, what_display
    );
    
    typedef enum logic [3:0] {
        wait_a,
        enable_a,
        enable_a_off,
        enable_op,
        enable_op_off,
        wait_b,
        enable_b,
        enable_b_off,
        enable_result
    } state_t;
    
    state_t state = wait_a;
    state_t next_state;
    
    // to change to next state
    always_ff @ (posedge clk) begin
        state <= next_state;
    end 
    
    // next state logic
    always_comb begin
        case(state)
            wait_a:
            enable_a:
            enable_a_off:
            enable_op:
            enable_op_off:
            wait_b:
            enable_b:
            enable_b_off:
            enable_result:
        endcase
    end
    
endmodule
