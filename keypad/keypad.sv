`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2026 02:35:16 AM
// Design Name: 
// Module Name: keypad
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


module keypad(
    input logic clk,
    input logic [3:0] columns,
    output logic [3:0] rows, keys
    );
    
    int counter1, counter2, wait_counter, send_counter;
    logic [3:0] which_row;
    logic [3:0] which_column;
    
    typedef enum logic [5:0] {
    row0,
    row1,
    row2,
    row3,
    send,
    delay
    } state_t;

    state_t state = row1;
    state_t next_state;
    
    // to change to next state
    always_ff @ (posedge clk) begin
        state <= next_state;
    end 
    
    // next state logic
    always_comb begin
        case (state)
            row0: begin
                if (columns != 4'b0000) begin
                        which_row = 4'b0001;
                        which_column = columns;
                        next_state = send;
                    end
                else if (columns == 4'b0000 && counter1 == 200) next_state = row2;
                else next_state = row0;
            end
            
            row1: begin
                if (columns != 4'b0000) begin
                        which_row = 4'b0010;
                        which_column = columns;
                        next_state = send;
                    end
                else if (columns == 4'b0000 && counter2 == 200) next_state = row2;
                else next_state = row1; 
            end
            
            row2:begin
                if (columns != 4'b0000) begin
                        which_row = 4'b0100;
                        which_column = columns;
                        next_state = send;
                    end
                else if (columns == 4'b0000 && counter1 == 200) next_state = row2;
                else next_state = row2;
            end
            
            row3:begin
                if (columns != 4'b0000) begin
                        which_row = 4'b1000;
                        which_column = columns;
                        next_state = send;
                    end
                else if (columns == 4'b0000 && counter1 == 200) next_state = row2;
                else next_state = row3;
            end
            send:
                if (send_counter == 20) next_state = delay;
                else next_state = send;
            delay: 
                if (wait_counter == 200) next_state = row0;
                else next_state = delay;
        endcase
    end
    
    // then based on the state we do different things
    always_ff @ (negedge clk) begin
        case (state)
            row0: begin
                counter2 <= 0;
                send_counter <=0;
                counter1 <= counter1 + 1;
                rows <= 4'b0001;
            end
                
            row1: begin
                counter1 <= 0;
                counter2 <= counter2 + 1;
                rows <= 4'b0010;
            end
            
            row2:begin
                counter2 <= 0;
                counter1 <= counter1 + 1;
                rows <= 4'b0100;
            end
            
            row3: begin
                counter1 <= 0;
                counter2 <= counter2 + 1;
                rows <= 4'b1000;
            end
            
            send: begin
                send_counter <= send_counter + 1;
                
            end
            
            delay: begin
            end
            
        endcase
    end

    
    
endmodule
