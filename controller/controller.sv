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
    input logic clk, key_release,
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
                next_state = a_release; //one clock cycle here should be enough
            end
            a_release: begin
                if(key_release == 1) next_state = wait_a;
                else next_state = a_release;
            end
            enable_op: begin
                if (enable_counter == 4) next_state = enable_op_off;
                else next_state = enable_op; //want to keep write enable on for a sec cause i'm worried the memory will mis time it
            end
            enable_op_off: next_state = op_release; //one clock cycle here should be enough
            op_release: begin
                if(key_release == 1) next_state = wait_b;
                else next_state = op_release;
            end
            wait_b: begin
                if(keys <= 4'b1001) next_state = enable_b; //if 0-9 is pushed then enable write
                else if (keys > 4'b1001) next_state = enable_result; //else is a equal and we don't account for operations so don't press it 
                else next_state = wait_a;
            end 
            enable_b:begin
                if (enable_counter == 4) next_state = enable_b_off;
                else next_state = enable_b; //want to keep write enable on for a sec cause i'm worried the memory will mis time it
            end
            enable_b_off: next_state = b_release;
            b_release: begin
                if(key_release == 1) next_state = wait_b;
                else next_state = b_release;
            end
            enable_result: begin
                if (enable_counter == 4) next_state = enable_result_off;
                else next_state = enable_b; //want to keep write enable on for a sec cause i'm worried the memory will mis time it
            end
            enable_result_off: next_state = result_release;
            result_release: begin
                if(key_release == 1) next_state = wait_a;
                else next_state = result_release;
            end
            default: next_state = wait_a;
        endcase
    end
    
    // then based on the state we do different things
    always_ff @ (negedge clk) begin
        case(state)
            wait_a: begin
                enable_counter <=0;
                where_store <= 2'b00;
                what_display <= 2'b00;
            end
            enable_a:begin
                enable_counter <= enable_counter + 1;
            end
            enable_a_off:
            a_release:
            enable_op:
            enable_op_off:
            op_release:
            wait_b:
            enable_b:
            enable_b_off:
            b_release:
            enable_result:
            enable_result_off:
            result_release:
        endcase
    end
    
endmodule
