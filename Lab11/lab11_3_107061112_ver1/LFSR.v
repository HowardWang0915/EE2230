`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/01 21:43:23
// Design Name: 
// Module Name: LFSR
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


module LFSR(
	q,
	position,
	rst,
    clk
    );
	 
	input [8:0]position;
	input rst;
    input clk;
	output reg [2:0]q;
	reg [2:0]q_tmp;
	
	always@*
	    if(position == 9'd448)
        begin
	        q_tmp[0] = q[1] ^ q[2];
            q_tmp[1] = q[0];
            q_tmp[2] = q[1];
        end
        else
        begin
            q_tmp[0] = q[0];
            q_tmp[1] = q[1];
            q_tmp[2] = q[2];
        end
	always@(posedge clk or posedge rst)
	    if(rst)
	    begin
            q[0] <= 1'b1;
            q[1] <= 1'b1;
            q[2] <= 1'b1;
        end
	    else
	    begin
	        q[0] <= q_tmp[0];
		    q[1] <= q_tmp[1];
		    q[2] <= q_tmp[2];
	    end
endmodule