`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2026 01:25:43 AM
// Design Name: 
// Module Name: display
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


module display(
    input logic clock,
    input logic signed [10:0] to_display,
    output logic [3:0] anodes,
    output logic [7:0] segments
    );
    
    int display_counter = 0;
    int wait_counter = 0;
    
    
    typedef enum logic [7:0] {
    display_AN0,
    wait_0,
    display_AN1,
    wait_1,
    display_AN2,
    wait_2,
    display_AN3,
    wait_3    
} state_t;

    state_t state = display_AN0;
    state_t next_state;
    
    // to change to next state
    always_ff @ (posedge clock) begin
            state <= next_state;
        end  
        
    // next state logic
    always_comb begin
        case (state)
            display_AN0: if (display_counter == 20) next_state = wait_0; else next_state = display_AN0; 
            wait_0: if (wait_counter == 20) next_state = display_AN1; else next_state = wait_0;
            display_AN1: if (display_counter == 20) next_state = wait_1; else next_state = display_AN1;
            wait_1: if (wait_counter == 20) next_state = display_AN2; else next_state = wait_1;
            display_AN2: if (display_counter == 20) next_state = wait_2; else next_state = display_AN2; 
            wait_2: if (wait_counter == 20) next_state = display_AN3; else next_state = wait_2;
            display_AN3: if (display_counter == 20) next_state = wait_3; else next_state = display_AN3;
            wait_3: if (wait_counter == 20) next_state = display_AN0; else next_state = wait_3;
            default: next_state = display_AN0;
        endcase
    end
    
    //taking the input and taking it apart to display the sign, hundreds, tens, and ones place
    always_comb begin
        if (to_display < 0)
            
    end

    // then based on the state we do different things
    always_ff @ (negedge clock) begin
    
    end
endmodule

