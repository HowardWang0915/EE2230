`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 20:49:48
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

`define STATE_12 0
`define STATE_24 1

`define dis_12 0
`define dis_24 1
module fsm(
    sel_display,    //   select which one to display
    rst_n,
    clk,    // global clock signal
    in      // input control
    );

    input clk;
    input rst_n;
    input in;

    output reg sel_display;

    reg state;
    reg next_state;

    always @*
        case (state)
            `STATE_12:
                if (in == 1'b0)
                begin
                    next_state = `STATE_12;
                    sel_display = `dis_12;
                end
                else
                begin
                    next_state = `STATE_24;
                    sel_display = `dis_24;
                end
            `STATE_24:
                if (in == 1'b0)
                begin
                    next_state = `STATE_24;
                    sel_display = `dis_24;
                end
                else
                begin
                    next_state = `STATE_12;
                    sel_display = `dis_24;
                end
            default:
                begin
                    next_state = `STATE_12;
                    sel_display = `dis_24;
                end
        endcase

    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            state <= `STATE_12;
        else
            state <= next_state;
endmodule
