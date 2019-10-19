`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/25 23:30:38
// Design Name: 
// Module Name: Fsm
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

`define STATE_PAUSE 1'b0
`define STATE_COUNT 1'b1
module Fsm(
	state,
	in,
	clk,
	rst
);
	
	output reg state;
	
	input in;
	input clk;
	input rst;
	
	reg next_state;
	
	always@*
		case(state)
			`STATE_PAUSE:  //pause
				if(in)
					next_state = `STATE_COUNT;
				else 
                    next_state = `STATE_PAUSE;
			`STATE_COUNT:  //count
				if(in)
					next_state = `STATE_PAUSE;
				else 
                    next_state = `STATE_COUNT;
			default:
				next_state = `STATE_PAUSE;
		endcase			
	
	always@(posedge clk or posedge rst)
		if(rst)
			state <= `STATE_PAUSE;
		else 
            state <= next_state;	
endmodule