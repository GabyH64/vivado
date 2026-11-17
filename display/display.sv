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

/* is 0 through 9 for case statements
           11'b00000000000:
           11'b00000000001:
           11'b00000000010:
           11'b00000000011:
           11'b00000000100:
           11'b00000000101:
           11'b00000000110:
           11'b00000000111:
           11'b00000001000:
           11'b00000001001:
*/



module display(
    input logic clock,
    input logic signed [10:0] to_display,
    output logic [3:0] anodes,
    output logic [7:0] segments
    );
    
    logic signed [10:0] display_copy;
    int display_counter = 0;
    int wait_counter = 0;
    logic [7:0] sign, hundreds, tens, ones;
    logic [10:0] hundreds_compare, tens_compare, ones_compare;
    
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
    
    //taking the input and taking it apart to display the sign, hundreds, tens, and ones place
    always_comb begin
        display_copy = to_display;
        //dealing with negative or not
        if (display_copy < 0) // if the display output is negative then the sign will be turned on
            begin
                sign = 8'b10111111;
                display_copy = display_copy * 11'b11111111111; //multiply the copy by -1 so it is positive for the others
            end
        else // else the sign isn't on
            sign = 8'b11111111;
            
       //dealing with hundreds place
       hundreds_compare = display_copy/11'b00001100100; //divide the work by 100
       case(hundreds_compare)
           11'b00000000000: hundreds = 
           11'b00000000001:
           11'b00000000010:
           11'b00000000011:
           11'b00000000100:
           11'b00000000101:
           11'b00000000110:
           11'b00000000111:
           11'b00000001000:
           11'b00000001001:
       endcase 
    end
    
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

    // then based on the state we do different things
    always_ff @ (negedge clock) begin
    
    end
endmodule
