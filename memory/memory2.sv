`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2026 06:42:12 PM
// Design Name: 
// Module Name: memory2
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


module memory2(
    input logic [3:0] keys,
    input logic [1:0] where_store, what_display,
    input logic clock, write_enable,
    input logic signed [10:0] result,
    output logic signed [10:0] a, b,
    output logic [10:0] display,
    output logic [1:0] operator,
    output logic [1:0] state
    );
    
    typedef enum logic [1:0]{
            save_a,
            save_op,
            save_b,
            save_result
        } state_t;
        
    state_t state = save_a; 
    state_t next_state ;  
    
    // to change to next state
    always_ff @ (posedge clock) begin
        state <= next_state;
    end  
        
    //next state logic
    always_comb begin
        case (state)
            save_a: begin
                if (where_store == 2'b01) next_state = save_op; else next_state = save_a;
            end
            save_op: begin
                if (where_store == 2'b10) next_state = save_b; else next_state = save_op;
            end
            save_b: begin
                if (where_store == 2'b11) next_state = save_result; else next_state = save_b;
            end 
            save_result: begin
                if (where_store == 2'b00) next_state = save_a ;else next_state = save_result;
            end
            default: begin
                next_state = save_a;
            end
            
        endcase
    end
    
    //so based on the write enable we save on neg edge so the states have a chance to run
    always_ff @ (negedge write_enable) begin
    case (state)
        save_a: begin
            a <= keys;
        end
        save_op: begin
            case(keys)
                4'b1010: operator <= 2'b00; //addition
                4'b1011: operator <= 2'b01; //subtraction
                4'b1100: operator <= 2'b10; // division
                4'b1101: operator <= 2'b11; //multiplication
            endcase
        end       
        save_b: begin
            b <= keys;
        end
        save_result: begin
            display <= result;
            a <= 0;
            b <= 0;
        end
    endcase
   end
   
   //display which i'm assuming will be set depending the state of the controller
   // do neg edge of clock because thats probably after the stuff has been set equal
   always_comb begin
    case (what_display)
        2'b00: display = a;
        2'b01: display = operator;
        2'b10: display = b;
        2'b11: display = result;
    endcase 
   end    
endmodule
