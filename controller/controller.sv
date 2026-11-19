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
    
    int enable_counter;
    
    typedef enum logic [3:0] {
        wait_a,
        enable_a,
        enable_a_off,
        a_release,
        enable_op,
        enable_op_off,
        op_release,
        wait_b,
        enable_b,
        enable_b_off,
        b_release,
        enable_result,
        enable_result_off,
        result_release
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
            wait_a: begin
                if(keys <= 4'b1001) next_state = enable_a; //if 0-9 is pushed then enable write
                else if (keys > 4'b1001) next_state = enable_op; //else is a operation and we don't account for equal sign so don't press it 
                else next_state = wait_a;
            end 
            enable_a: begin
                if (enable_counter == 4) next_state = enable_a_off;
                else next_state = enable_a; //want to keep write enable on for a sec cause i'm worried the memory will mis time it
            end
            enable_a_off: begin
                next_state = wait_a; //one clock cycle here should be enough
            end
            enable_op: begin
                if (enable_counter == 4) next_state = enable_op_off;
                else next_state = enable_op; //want to keep write enable on for a sec cause i'm worried the memory will mis time it
            end
            enable_op_off: next_state = wait_b; //one clock cycle here should be enough
            wait_b: begin
                if(keys <= 4'b1001) next_state = enable_b; //if 0-9 is pushed then enable write
                else if (keys > 4'b1001) next_state = enable_result; //else is a equal and we don't account for operations so don't press it 
                else next_state = wait_a;
            end 
            enable_b:begin
                if (enable_counter == 4) next_state = enable_b_off;
                else next_state = enable_b; //want to keep write enable on for a sec cause i'm worried the memory will mis time it
            end
            enable_b_off: next_state = wait_b;
            enable_result: begin
                if (enable_counter == 4) next_state = enable_result_off;
                else next_state = enable_b; //want to keep write enable on for a sec cause i'm worried the memory will mis time it
            end
            enable_result_off: next_state = wait_a;
            default: next_state = wait_a;
        endcase
    end
    
endmodule
