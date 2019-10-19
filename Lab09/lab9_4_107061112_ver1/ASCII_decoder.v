`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 21:04:59
// Design Name: 
// Module Name: ASCII_decoder
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

`include "ASCII_global.v"
module ASCII_decoder(
    clk,
    rst,
	ASCII,
	key_down,
	last_change,
	caps,
    caps_out
    );
	
	output reg [6:0]ASCII;
	output reg caps_out;

    input clk;
    input rst;
	input [511:0]key_down;
	input [8:0]last_change;
	input caps;
	
	reg [6:0]ASCII_next;
	
	always@*
		if((~caps & ~(key_down[9'h012] | key_down[9'h059])) | (caps & (key_down[9'h012] | key_down[9'h059])))
        begin
			caps_out = 1'b0;
            case(last_change)
				9'h01c: ASCII_next = `ASCII_a;
				9'h032: ASCII_next = `ASCII_b;
				9'h021: ASCII_next = `ASCII_c;
				9'h023: ASCII_next = `ASCII_d;
				9'h024: ASCII_next = `ASCII_e;
				9'h02b: ASCII_next = `ASCII_f;
				9'h034: ASCII_next = `ASCII_g;
				9'h033: ASCII_next = `ASCII_h;
				9'h043: ASCII_next = `ASCII_i;
				9'h03b: ASCII_next = `ASCII_j;
				9'h042: ASCII_next = `ASCII_k;
				9'h04b: ASCII_next = `ASCII_l;
				9'h03a: ASCII_next = `ASCII_m;
				9'h031: ASCII_next = `ASCII_n;
				9'h044: ASCII_next = `ASCII_o;
				9'h04d: ASCII_next = `ASCII_p;
				9'h015: ASCII_next = `ASCII_q;
				9'h02d: ASCII_next = `ASCII_r;
				9'h01b: ASCII_next = `ASCII_s;
				9'h02c: ASCII_next = `ASCII_t;
				9'h03c: ASCII_next = `ASCII_u;
				9'h02a: ASCII_next = `ASCII_v;
				9'h01d: ASCII_next = `ASCII_w;
				9'h022: ASCII_next = `ASCII_x;
				9'h035: ASCII_next = `ASCII_y;
				9'h01a: ASCII_next = `ASCII_z;
				default: ASCII_next = 7'b0;
			endcase
        end
		else
        begin
            caps_out = 1'b1;
			case(last_change)
				9'h01c: ASCII_next = `ASCII_A;
				9'h032: ASCII_next = `ASCII_B;
				9'h021: ASCII_next = `ASCII_C;
				9'h023: ASCII_next = `ASCII_D;
				9'h024: ASCII_next = `ASCII_E;
				9'h02b: ASCII_next = `ASCII_F;
				9'h034: ASCII_next = `ASCII_G;
				9'h033: ASCII_next = `ASCII_H;
				9'h043: ASCII_next = `ASCII_I;
				9'h03b: ASCII_next = `ASCII_J;
				9'h042: ASCII_next = `ASCII_K;
				9'h04b: ASCII_next = `ASCII_L;
				9'h03a: ASCII_next = `ASCII_M;
				9'h031: ASCII_next = `ASCII_N;
				9'h044: ASCII_next = `ASCII_O;
				9'h04d: ASCII_next = `ASCII_P;
				9'h015: ASCII_next = `ASCII_Q;
				9'h02d: ASCII_next = `ASCII_R;
				9'h01b: ASCII_next = `ASCII_S;
				9'h02c: ASCII_next = `ASCII_T;
				9'h03c: ASCII_next = `ASCII_U;
				9'h02a: ASCII_next = `ASCII_V;
				9'h01d: ASCII_next = `ASCII_W;
				9'h022: ASCII_next = `ASCII_X;
				9'h035: ASCII_next = `ASCII_Y;
				9'h01a: ASCII_next = `ASCII_Z;
				default: ASCII_next = 7'b0;
			endcase
        end
				
	always@(posedge clk or posedge rst)
        if (rst)
            ASCII <= 7'b0;
        else
		    ASCII <= ASCII_next;
	
endmodule

