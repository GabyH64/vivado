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
    input logic [10:0] result,
    output logic [10:0] a, b, display,
    output logic [1:0] operator    
    );
    
    logic [10:0] temp_a, temp_b, temp_result;
    logic [1:0] temp_op;   
    
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
    always_comb begin
        case (state)
            save_a: begin
                if (where_store == 2'b01) next_state = save_op;
            end
            save_op: begin
                if (where_store == 2'b10) next_state = save_b;
            end
            save_b: begin
                if (where_store == 2'b11) next_state = save_result;
            end 
            save_result: begin
                if (where_store == 2'b00) next_state = save_a;
            end
        endcase
    end
   
   // saving logic depending on the state and on the falling edge so we're sure that we're in the right state
   always_ff @ (negedge clock) begin
    case (state)
        save_a: begin
            temp_a = {7'b0000000, keys};
        end
        save_op: begin
            case(keys)
                4'b1010: temp_op = 2'b00; //addition
                4'b1011: temp_op = 2'b01; //subtraction
                4'b1100: temp_op = 2'b10; // division
                4'b1101: temp_op = 2'b11; //multiplication
            endcase
        end       
        save_b: begin
            temp_b = {7'b0000000, keys};
        end
        save_result: begin
            temp_result = result;
        end
    endcase
   end 
   
   // actually sending the logic out to the data alu 
    
    
endmodule



