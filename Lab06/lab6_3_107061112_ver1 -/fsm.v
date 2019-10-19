`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 21:03:48
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
// define state
`define STATE_12        3'b000
`define STATE_12_SEC    3'b001
`define STATE_24        3'b010
`define STATE_24_SEC    3'b011
`define STATE_MMDD      3'b100
`define STATE_YYYY      3'b101
// define counter sel
`define COUNTER_12      3'b000
`define COUNTER_12_SEC  3'b001
`define COUNTER_24      3'b010
`define COUNTER_24_SEC  3'b011
`define COUNTER_YYYY    3'b100
`define COUNTER_MMDD    3'b101
module fsm(
    clk,    // crystal clock
    rst_n,  // low active reset
    in,     // input control
    counter_sel     // for mux display
    );

    input clk;
    input rst_n;
    input [2:0]in;  // input control
    output [2:0]counter_sel;     // select data for scan_ctl

    reg [2:0]counter_sel;
    reg [2:0]state;
    reg [2:0]next_state;
    
    always @*
        case (state)
            `STATE_12:
                if (in == 3'b000)
                begin
                    next_state = `STATE_12;
                    counter_sel = `COUNTER_12;
                end
                else if (in == 3'b001)
                begin
                    next_state = `STATE_12_SEC;
                    counter_sel = `COUNTER_12_SEC;
                end
                else if (in == 3'b010)
                begin
                    next_state = `STATE_24;
                    counter_sel = `COUNTER_24;
                end
                else if (in == 3'b100)
                begin
                    next_state = `STATE_MMDD;
                    counter_sel = `COUNTER_MMDD;
                end
                else
                begin
                    next_state = `STATE_12;
                    counter_sel = `COUNTER_12;
                end
            `STATE_12_SEC:
                if (in == 3'b000)
                begin
                    next_state = `STATE_12_SEC;
                    counter_sel = `COUNTER_12_SEC;
                end
                else if (in == 3'b001)
                begin
                    next_state = `STATE_12;
                    counter_sel = `COUNTER_12;
                end
                else if (in == 3'b010)
                begin
                    next_state = `STATE_24;
                    counter_sel = `COUNTER_24;
                end
                else if (in == 3'b100)
                begin
                    next_state = `STATE_MMDD;
                    counter_sel = `COUNTER_MMDD;
                end
                else
                begin
                    next_state = `STATE_12_SEC;
                    counter_sel = `COUNTER_12_SEC;
                end
            `STATE_24:
                if (in == 3'b000)
                begin
                    next_state = `STATE_24;
                    counter_sel = `COUNTER_24;
                end
                else if (in == 3'b001)
                begin
                    next_state = `STATE_24_SEC;
                    counter_sel = `COUNTER_24_SEC;
                end
                else if (in == 3'b010)
                begin
                    next_state = `STATE_12;
                    counter_sel = `COUNTER_12;
                end
                else if (in == 3'b100)
                begin
                    next_state = `STATE_MMDD;
                    counter_sel = `COUNTER_MMDD;
                end
                else
                begin
                    next_state = `STATE_24;
                    counter_sel = `COUNTER_24;
                end       
            `STATE_24_SEC:
                if (in == 3'b000)
                begin
                    next_state = `STATE_24_SEC;
                    counter_sel = `COUNTER_24_SEC;
                end
                else if (in == 3'b001)
                begin
                    next_state = `STATE_24;
                    counter_sel = `COUNTER_24;
                end
                else if (in == 3'b010)
                begin
                    next_state = `STATE_12;
                    counter_sel = `COUNTER_12;
                end
                else if (in == 3'b100)
                begin
                    next_state = `STATE_MMDD;
                    counter_sel = `COUNTER_MMDD;
                end
                else
                begin
                    next_state = `STATE_24_SEC;
                    counter_sel = `COUNTER_24_SEC;
                end
            `STATE_MMDD:
                if (in == 3'b000)
                begin
                    next_state = `STATE_MMDD;
                    counter_sel = `COUNTER_MMDD;
                end
                else if (in == 3'b001)
                begin
                    next_state = `STATE_YYYY;
                    counter_sel = `COUNTER_YYYY;
                end
                else if (in == 3'b100)
                begin
                    next_state = `STATE_12;
                    counter_sel = `COUNTER_12;
                end
                else
                begin
                    next_state = `STATE_MMDD;
                    counter_sel = `COUNTER_MMDD;
                end
            `STATE_YYYY:
                if (in == 3'b000)
                begin
                    next_state = `STATE_YYYY;
                    counter_sel = `COUNTER_YYYY;
                end
                else if (in == 3'b001)
                begin
                    next_state = `STATE_MMDD;
                    counter_sel = `COUNTER_MMDD;
                end
                else if (in == 3'b100)
                begin
                    next_state = `STATE_12;
                    counter_sel = `COUNTER_12;
                end
                else
                begin
                    next_state = `STATE_YYYY;
                    counter_sel = `COUNTER_YYYY;
                end
            default:
                begin
                    next_state = `STATE_12;
                    counter_sel = `COUNTER_YYYY;
                end
        endcase
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            state <= `STATE_12;
        else
            state <= next_state;
endmodule
