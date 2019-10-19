`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/19 23:47:15
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

`define STATE_COUNT 1
`define STATE_PAUSE 0
module fsm(
    count_enable,   // if counter os enabled
    in, // input control
    clk, // global clock signal
    rst_n,   // high active reset
    state_out
    );

    output state_out;
    output count_enable;

    input clk;
    input rst_n;
    input in;

    reg count_enable;
    reg state;
    reg next_state;
    reg state_out;

    always @*
        state_out = state;
    always @*
        case (state)
            `STATE_PAUSE:
                if (in == 1)
                begin
                  next_state = `STATE_COUNT;
                  count_enable = 1;
                end
                else
                begin
                    next_state = `STATE_PAUSE;
                    count_enable = 0;
                end
            `STATE_COUNT:
                if (in == 1)
                begin
                    next_state = `STATE_PAUSE;
                    count_enable = 0;
                end
                else
                begin
                    next_state = `STATE_COUNT;
                    count_enable = 1;
                end
            default
            begin
                next_state = 0;
                count_enable = 0;
            end
        endcase
    always @(posedge clk or posedge rst_n)
        if (rst_n)
            state <= `STATE_PAUSE;
        else
            state <= next_state;
endmodule
