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
           
           8'b10010000 // 9
           8'b10000000 // 8
           8'b11111000 // 7
           8'b10000010 // 6
           8'b10010010 // 5
           8'b10011001 // 4
           8'b10110000 // 3
           8'b10100100 // 2
           8'b11111001 // 1
           8'b11000000 // 0
           
           
*/



module display(
    input logic clock,
    input logic signed [10:0] to_display,
    output logic [3:0] anodes,
    output logic [7:0] cathodes
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
            
       //taking the to display number and figuring out how many hundreds are in it, it should truncate the decimals away
       hundreds_compare = display_copy/11'b00001100100; //divide the work by 100
       // depending on how many hundreds there are, it changes the variable that is what will be displayed
       case(hundreds_compare)
           11'b00000000000: hundreds = 8'b11000000; // 0
           11'b00000000001: hundreds = 8'b11111001; // 1
           11'b00000000010: hundreds = 8'b10100100; // 2
           11'b00000000011: hundreds = 8'b10110000; // 3
           11'b00000000100: hundreds = 8'b10011001; // 4
           11'b00000000101: hundreds = 8'b10010010; // 5
           11'b00000000110: hundreds = 8'b10000010; // 6
           11'b00000000111: hundreds = 8'b11111000; // 7
           11'b00000001000: hundreds = 8'b10000000; // 8
           11'b00000001001: hundreds = 8'b10010000; // 9
           default: hundreds = 8'b01111111; // turn on the just the decimal to let us know there is something wrong
       endcase 
       
       // dealing with the tens
       display_copy = display_copy % 11'b00001100100; //modulus by 100 to get only the tens place max
       tens_compare = display_copy / 11'b00000001010; //divide by 10 and it should truncate down
       //depending on how many tens there are, change the display
       case (tens_compare)
           11'b00000000000: tens = 8'b11000000; // 0
           11'b00000000001: tens = 8'b11111001; // 1
           11'b00000000010: tens = 8'b10100100; // 2
           11'b00000000011: tens = 8'b10110000; // 3
           11'b00000000100: tens = 8'b10011001; // 4
           11'b00000000101: tens = 8'b10010010; // 5
           11'b00000000110: tens = 8'b10000010; // 6
           11'b00000000111: tens = 8'b11111000; // 7
           11'b00000001000: tens = 8'b10000000; // 8
           11'b00000001001: tens = 8'b10010000; // 9
           default: hundreds = 8'b01111111; //decimal point for error
       endcase
       
       ones_compare = display_copy % 11'b00000001010; //modulus by 10 to get only the ones place max
       case (ones_compare)
           11'b00000000000: ones = 8'b11000000; // 0
           11'b00000000001: ones = 8'b11111001; // 1
           11'b00000000010: ones = 8'b10100100; // 2
           11'b00000000011: ones = 8'b10110000; // 3
           11'b00000000100: ones = 8'b10011001; // 4
           11'b00000000101: ones = 8'b10010010; // 5
           11'b00000000110: ones = 8'b10000010; // 6
           11'b00000000111: ones = 8'b11111000; // 7
           11'b00000001000: ones = 8'b10000000; // 8
           11'b00000001001: ones = 8'b10010000; // 9
           default: hundreds = 8'b01111111; //decimal point for error
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
        case (state)
            display_AN0:
                begin
                    wait_counter <= 0;
                    display_counter <= display_counter + 1;
                    anodes <= 4'b1110;
                    cathodes <= ones;
                end
            wait_0:
                begin
                    display_counter <= 0;
                    wait_counter <= wait_counter + 1;
                    anodes <= 4'b1111;
                    cathodes <= 8'b11111111;
                end
            display_AN1:
                begin
                    wait_counter <= 0;
                    display_counter <= display_counter + 1;
                    anodes <= 4'b1101;
                    cathodes <= tens;
                end
            wait_1:
                begin
                    display_counter <= 0;
                    wait_counter <= wait_counter + 1;
                    anodes <= 4'b1111;
                    cathodes <= 8'b11111111;
                end
            display_AN2:
                begin
                    wait_counter <= 0;
                    display_counter <= display_counter + 1;
                    anodes <= 4'b1011;
                    cathodes <= hundreds;
                end
            wait_2:
                begin
                    display_counter <= 0;
                    wait_counter <= wait_counter + 1;
                    anodes <= 4'b1111;
                    cathodes <= 8'b11111111;
                end
            display_AN3:
                begin
                    wait_counter <= 0;
                    display_counter <= display_counter + 1;
                    anodes <= 4'b1101;
                    cathodes <= tens;
                end
            wait_3:
                begin
                    display_counter <= 0;
                    wait_counter <= wait_counter + 1;
                    anodes <= 4'b1111;
                    cathodes <= 8'b11111111;
                end
        endcase
    end
endmodule
