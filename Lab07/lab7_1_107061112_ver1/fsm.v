`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 23:07:24
// Design Name: 
// Module Name: fsm
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

`define STATE_PAUSE 2'b00
`define STATE_COUNT 2'b01
`define STATE_LAP   2'b10
`define STATE_RESET 2'b11
`define DISABLED    1'b0
`define ENABLED     1'b1
module fsm(
    rst_n,
    clk,
    in,          // input control
    count_en,   
    lap,
    reset_out   // output reset
    );

    input clk;
    input rst_n;
    input [2:0]in;  // lap / start_pause / reset

    output reg count_en;    // counter increase signal
    output reg lap;         // lap signal
    output reg reset_out;
    reg [1:0]state;
    reg [1:0]next_state;

    always @*
        case (state)
            `STATE_PAUSE:
                if (in == 3'b000)
                begin
                    next_state = `STATE_PAUSE;
                    count_en = `DISABLED;
                    lap =  `DISABLED;
                    reset_out = 1'b1;     
                end
                else if (in == 3'b001)
                begin
                    next_state = `STATE_RESET;
                    count_en = `DISABLED;
                    lap = `DISABLED;
                    reset_out = 1'b0;
                end
                else if (in == 3'b010)
                begin
                    next_state = `STATE_COUNT;
                    count_en = `ENABLED;
                    lap = `DISABLED;
                    reset_out = 1'b1;
                end
                else 
                begin
                    next_state = `STATE_PAUSE;
                    count_en = `DISABLED;
                    lap = `DISABLED;
                    reset_out = 1'b1;
                end
            `STATE_COUNT:
                if (in == 3'b000)
                begin
                    next_state = `STATE_COUNT;
                    count_en = `ENABLED;
                    lap = `DISABLED;
                    reset_out = 1'b1;
                end
                else if (in == 3'b001)
                begin
                    next_state = `STATE_RESET;
                    count_en = `DISABLED;
                    lap = `DISABLED;
                    reset_out = 1'b0;
                end
                else if (in == 3'b010)
                begin
                    next_state = `STATE_PAUSE;
                    count_en = `DISABLED;
                    lap = `DISABLED;
                    reset_out = 1'b1;
                end
                else if (in == 3'b100)
                begin
                    next_state = `STATE_LAP;
                    count_en = `ENABLED;
                    lap = `ENABLED;
                    reset_out = 1'b1;
                end
                else 
                begin
                    next_state = `STATE_COUNT;
                    count_en = `ENABLED;
                    lap = `DISABLED;
                    reset_out = 1'b1;
                end
            `STATE_LAP:
                if (in == 3'b000)
                begin
                    next_state = `STATE_LAP;
                    count_en = `ENABLED;
                    lap = `ENABLED;
                    reset_out = 1'b1;
                end
                else if (in == 3'b001)
                begin
                    next_state = `STATE_RESET;
                    count_en = `DISABLED;
                    lap = `DISABLED;
                    reset_out = 1'b0;
                end
                else if (in == 3'b100)
                begin
                    next_state = `STATE_COUNT;
                    count_en = `ENABLED;
                    lap = `DISABLED;
                    reset_out = 1'b1;
                end
                else
                begin
                    next_state = `STATE_LAP;
                    count_en = `ENABLED;
                    lap = `ENABLED;
                    reset_out = 1'b1;
                end
            `STATE_RESET:
                if (in == 3'b000)
                begin
                    next_state = `STATE_RESET;
                    count_en = `DISABLED;
                    lap = `DISABLED;
                    reset_out = 1'b0;
                end
                else if (in == 3'b010)
                begin
                    next_state = `STATE_COUNT;
                    count_en = `ENABLED;
                    lap = `DISABLED;
                    reset_out = 1'b1;
                end
                else
                begin
                    next_state = `STATE_RESET;
                    count_en = `DISABLED;
                    lap = `DISABLED;
                    reset_out = 1'b0;
                end
            default:
                begin
                    next_state = `STATE_PAUSE;
                    count_en = `DISABLED;
                    lap = `DISABLED;
                    reset_out = 1'b1;
                end
        endcase

    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            state <= `STATE_PAUSE;
        else
            state <= next_state;
endmodule
