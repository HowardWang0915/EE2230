`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/20 16:17:57
// Design Name: 
// Module Name: Sound_sel
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


module Sound_sel(
    clk,
    rst,
	note,
	key_down,
	last_change,
	caps,
    caps_out
    );
	
	output reg [21:0]note;
	output reg caps_out;

    input clk;
    input rst;
	input [511:0]key_down;
	input [8:0]last_change;
	input caps;
	
	reg [21:0]note_next;
	
	always@*
		if((~caps & ~(key_down[9'h012] | key_down[9'h059])) | (caps & (key_down[9'h012] | key_down[9'h059])))
        begin
			caps_out = 1'b0;
            if (key_down[9'h021])
				note_next = 22'd383141;
            else if (key_down[9'h023])
				note_next = 22'd341296;
			else if (key_down[9'h024])
                note_next = 22'd303030; 
			else if (key_down[9'h02b])
                note_next = 22'd286532;
			else if (key_down[9'h034])
                note_next = 22'd255102;
			else if (key_down[9'h01c])
                note_next = 22'd227272;
			else if (key_down[9'h032])
                note_next = 22'd202492;
			else	
			    note_next = 22'b0;
        end
		else
        begin
            caps_out = 1'b1;
			if (key_down[9'h021])
				note_next = 22'd190839;
            else if (key_down[9'h023])
				note_next = 22'd170068;
			else if (key_down[9'h024])
                note_next = 22'd151515; 
			else if (key_down[9'h02b])
                note_next = 22'd143266;
			else if (key_down[9'h034])
                note_next = 22'd127551;
			else if (key_down[9'h01c])
                note_next = 22'd113636;
			else if (key_down[9'h032])
                note_next = 22'd101214;
			else	
			    note_next = 22'b0;
        end
				
	always@(posedge clk or posedge rst)
        if (rst)
            note <= 22'b0;
        else
		    note <= note_next;
	
endmodule


