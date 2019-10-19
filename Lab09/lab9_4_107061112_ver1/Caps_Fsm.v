`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 20:55:47
// Design Name: 
// Module Name: Caps_Fsm
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

`define STATE_CAPS      1
`define STATE_NO_CAPS   0
module FSM(
    clk,
    rst,
	caps,
	last_change,
	key_valid
	);

	input clk;
    input rst;	
	input [8:0]last_change;
	input key_valid;
	
    output reg caps;

	reg state, next_state;	

	always@*
		case(state)
			`STATE_NO_CAPS:
				if (last_change == 9'h058 && key_valid)
                begin
                    caps = `STATE_CAPS;
					next_state = `STATE_CAPS;
                end
				else
                begin
                    caps = `STATE_NO_CAPS;
					next_state = `STATE_NO_CAPS;
                end
			`STATE_CAPS:
				if (last_change == 9'h058 && key_valid)
                begin
                    caps = `STATE_NO_CAPS;
					next_state = `STATE_NO_CAPS;
                end
				else
                begin
                    caps = `STATE_CAPS;
					next_state = `STATE_CAPS;
                end
            default:
                begin
                    caps = `STATE_NO_CAPS;
                    next_state = `STATE_NO_CAPS;
                end
		endcase

	always@(posedge clk or posedge rst)
        if (rst)
            state <= 1'b0;
        else
		    state <= next_state;
		
endmodule
