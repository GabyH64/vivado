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
    output logic [3:0] rows, keys,
    output int counter1, counter2, wait_counter,
    output logic [2:0] state,
    output logic key_release
    );
    
    int counter1, counter2, wait_counter;
    logic [3:0] which_row;
    logic [3:0] which_column;
    
    typedef enum logic [2:0] {
    row0,
    row1,
    row2,
    row3,
    send,
    delay
    } state_t;

    state_t state = row0;
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
                else if (counter1 == 200) next_state = row1;
                else next_state = row0;
            end
            
            row1: begin
                if (columns != 4'b0000) begin
                        which_row = 4'b0010;
                        which_column = columns;
                        next_state = send;
                    end
                else if (counter2 == 200) next_state = row2;
                else next_state = row1; 
            end
            
            row2:begin
                if (columns != 4'b0000) begin
                        which_row = 4'b0100;
                        which_column = columns;
                        next_state = send;
                    end
                else if (counter1 == 200) next_state = row3;
                else next_state = row2;
            end
            
            row3:begin
                if (columns != 4'b0000) begin
                        which_row = 4'b1000;
                        which_column = columns;
                        next_state = send;
                    end
                else if (counter2 == 200) next_state = row0;
                else next_state = row3;
            end
            send:
                if (columns == 4'b0000) next_state = delay;
                else next_state = send;
            delay: 
                if (wait_counter == 200) next_state = row0;
                else next_state = delay;
            default: next_state = row0;
        endcase
    end
    
    // then based on the state we do different things
    always_ff @ (negedge clk) begin
        case (state)
            row0: begin
                key_release <= 0;
                counter2 <= 0;
                wait_counter <= 0;
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
                case(which_row)
                    4'b0001: begin //top row
                        case(which_column)
                            4'b0001: keys = 4'b0001; //1
                            4'b0010: keys = 4'b0010; //2
                            4'b0100: keys = 4'b0011; //3
                            4'b1000: keys = 4'b1010; //A or add
                        endcase
                    end
                   
                    4'b0010: begin //sencond from top row
                        case(which_column)
                            4'b0001: keys = 4'b0100; //4
                            4'b0010: keys = 4'b0101; //5
                            4'b0100: keys = 4'b0110; //6
                            4'b1000: keys = 4'b1011; //B aka subtract
                        endcase
                    end
                    4'b0100: begin
                        case(which_column)
                            4'b0001: keys = 4'b0111; //7
                            4'b0010: keys = 4'b1000; //8
                            4'b0100: keys = 4'b1001; //9
                            4'b1000: keys = 4'b1100; //C aka divide
                        endcase
                    end
                    4'b1000: begin
                        case(which_column)
                            4'b0001: keys = 4'b0000; //is the * but im making it also 0
                            4'b0010: keys = 4'b0000; //0
                            4'b0100: keys = 4'b1110; // # for equal sign
                            4'b1000: keys = 4'b1101; //D aka multiply
                        endcase
                    end
                endcase
            end
            
            delay: begin
                wait_counter <= wait_counter + 1;
                key_release <= 1;
                keys = 4'b1111;
            end
            
        endcase
    end

    
    
endmodule
