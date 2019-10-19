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

`define STATE_30PAUSE 2'b00
`define STATE_30COUNT 2'b10
`define STATE_60PAUSE 2'b01
`define STATE_60COUNT 2'b11
`define COUNTER2d 0
`define COUNTER3d 1
`define ON 1
`define OFF 0
module fsm(
    count_enable,   // if counter os enabled
    counter_sel,    // counter selector
    reset,
    in, // input control
    clk, // global clock signal
    rst_n,   // high active reset
    long_press_rst
    );

    output count_enable;
    output counter_sel;
    output reset;   // reset a counter
    input clk;
    input rst_n;
    input [1:0]in;
    input long_press_rst;      // long press reset

    reg count_enable;   // enable a counter
    reg counter_sel;    // determine which counter to count
    reg reset;
    reg [1:0]state;
    reg [1:0]next_state;

    always @*
        case (state)
            `STATE_30PAUSE:
                if (in == 2'b00)
                begin
                    next_state = `STATE_30PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER2d;
                    reset = (`OFF | long_press_rst);
                end
                else if (in == 2'b01)
                begin
                    next_state = `STATE_30COUNT;
                    count_enable = 1;
                    counter_sel = `COUNTER2d;
                    reset = (`OFF | long_press_rst);
                end
                else if (in == 2'b10)
                begin
                    next_state = `STATE_60PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER3d;
                    reset = `ON;
                end
                else
                begin
                    next_state = `STATE_30PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER2d;
                    reset = `ON;
                end
            `STATE_30COUNT:
                if (in == 2'b00)
                begin
                    next_state = `STATE_30COUNT;
                    count_enable = 1;
                    counter_sel = `COUNTER2d;
                    reset = (`OFF | long_press_rst);
                end
                else if (in == 2'b01)
                begin
                    next_state = `STATE_30PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER2d;
                    reset = (`OFF | long_press_rst);
                end
                else if (in == 2'b10)
                begin
                    next_state = `STATE_60PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER3d;
                    reset = `ON;
                end
                else
                begin
                    next_state = `STATE_30PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER2d;
                    reset = `ON;
                end
            `STATE_60PAUSE:
                if (in == 2'b00)
                begin
                    next_state = `STATE_60PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER3d;
                    reset = (`OFF | long_press_rst);
                end
                else if (in == 2'b01)
                begin
                    next_state = `STATE_60COUNT;
                    count_enable = 1;
                    counter_sel =  `COUNTER3d;
                    reset = (`OFF | long_press_rst);
                end
                else if (in == 2'b10)
                begin
                    next_state = `STATE_30PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER2d;
                    reset = `ON;
                end
                else
                begin
                    next_state = `STATE_60PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER3d;
                    reset = `ON;
                end
            `STATE_60COUNT:
                if (in == 2'b00)
                begin
                    next_state = `STATE_60COUNT;
                    count_enable = 1;
                    counter_sel = `COUNTER3d;
                    reset = (`OFF | long_press_rst);
                end
                else if (in == 2'b01)
                begin
                    next_state = `STATE_60PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER3d;
                    reset = (`OFF | long_press_rst);
                end
                else if (in == 2'b10)
                begin
                    next_state = `STATE_30PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER2d;
                    reset = `ON;
                end
                else
                begin
                    next_state = `STATE_60PAUSE;
                    count_enable = 0;
                    counter_sel = `COUNTER3d;
                    reset = `ON;
                end
            default:
            begin
                next_state = `STATE_30PAUSE;
                count_enable = 0;
                counter_sel = `COUNTER3d;
                reset = `ON;
            end
        endcase
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            state <= `STATE_30PAUSE;
        else
            state <= next_state;
endmodule
