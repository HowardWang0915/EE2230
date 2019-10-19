`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 20:26:03
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

`define LOWDO 22'd383141
`define LOWRE 22'd341296
`define LOWMI 22'd303030
`define LOWFA 22'd286532
`define LOWSO 22'd255102
`define LOWLA 22'd227272
`define LOWSI 22'd202492
`define HIDO  22'd190839
`define HIRE  22'd170068
`define HIMI  22'd151515
`define HIFA  22'd143266
`define HISO  22'd127551
`define HILA  22'd113636
`define HISI  22'd101214
module Sound_sel(
    clk,
    rst,
	note_left,
	note_right,
	key_down,
	last_change,
	caps,
    caps_out,
	dip
    );
	
	output reg [21:0]note_left, note_right;
	output reg caps_out;

    input clk;
    input rst;
	input [511:0]key_down;
	input [8:0]last_change;
	input caps;
	input dip;
	
	reg [21:0]note_next_left, note_next_right;
	
	always@*
		if(((~caps & ~(key_down[9'h012] | key_down[9'h059])) | (caps & (key_down[9'h012] | key_down[9'h059]))) && ~dip)
        begin
			caps_out = 1'b0;
            if (key_down[9'h021])
			begin
				note_next_left = 22'd383141;
				note_next_right = 22'd383141;
			end
            else if (key_down[9'h023])
			begin
				note_next_left = 22'd341296;
				note_next_right = 22'd341296;
			end
			else if (key_down[9'h024])
			begin
                note_next_left = 22'd303030; 
				note_next_right = 22'd303030;
			end
			else if (key_down[9'h02b])
			begin
                note_next_left = 22'd286532;
				note_next_right = 22'd286532;
			end
			else if (key_down[9'h034])
			begin
                note_next_left = 22'd255102;
				note_next_right = 22'd255102;
			end
			else if (key_down[9'h01c])
			begin
                note_next_left = 22'd227272;
				note_next_right = 22'd227272;
			end
			else if (key_down[9'h032])
			begin
                note_next_left = 22'd202492;
				note_next_right = 22'd202492;
			end
			else
			begin	
			    note_next_left = 22'b0;
				note_next_right = 22'b0;
			end
        end
		else if(~((~caps & ~(key_down[9'h012] | key_down[9'h059])) | (caps & (key_down[9'h012] | key_down[9'h059]))) && ~dip)
        begin
            caps_out = 1'b1;
			if (key_down[9'h021])
			begin
				note_next_left = 22'd190839;
				note_next_right = 22'd190839;
			end
            else if (key_down[9'h023])
			begin
				note_next_left = 22'd170068;
				note_next_right = 22'd170068;
			end
			else if (key_down[9'h024])
			begin
                note_next_left = 22'd151515; 
				note_next_right = 22'd151515; 
			end
			else if (key_down[9'h02b])
			begin
                note_next_left = 22'd143266;
				note_next_right = 22'd143266;
			end
			else if (key_down[9'h034])
			begin
                note_next_left = 22'd127551;
				note_next_right = 22'd127551;
			end
			else if (key_down[9'h01c])
			begin
                note_next_left = 22'd113636;
				note_next_right = 22'd113636;
			end
			else if (key_down[9'h032])
			begin
                note_next_left = 22'd101214;
				note_next_right = 22'd101214;
			end
			else	
			begin
			    note_next_left = 22'b0;
				note_next_right = 22'b0;
			end
		end
		else if (((~caps & ~(key_down[9'h012] | key_down[9'h059])) | (caps & (key_down[9'h012] | key_down[9'h059]))) && dip)
		begin
			caps_out = 1'b0;
			if (key_down[9'h021])
			begin
				note_next_left = 22'd383141;
				note_next_right = `LOWMI;
			end
            else if (key_down[9'h023])
			begin
				note_next_left = 22'd341296;
				note_next_right = `LOWFA;
			end
			else if (key_down[9'h024])
			begin
                note_next_left = 22'd303030; 
				note_next_right =`LOWSO;
			end
			else if (key_down[9'h02b])
			begin
                note_next_left = 22'd286532;
				note_next_right = `LOWLA;
			end
			else if (key_down[9'h034])
			begin
                note_next_left = 22'd255102;
				note_next_right = `LOWSI;
			end
			else	
			begin
			    note_next_left = 22'b0;
				note_next_right = 22'b0;
			end
		end
		else
		begin
            caps_out = 1'b1;
			if (key_down[9'h021])
			begin
				note_next_left = 22'd190839;
				note_next_right = `HIMI;
			end
            else if (key_down[9'h023])
			begin
				note_next_left = 22'd170068;
				note_next_right = `HIFA;
			end
			else if (key_down[9'h024])
			begin
                note_next_left = 22'd151515; 
				note_next_right = `HISO; 
			end
			else if (key_down[9'h02b])
			begin
                note_next_left = 22'd143266;
				note_next_right = `HILA;
			end
			else if (key_down[9'h034])
			begin
                note_next_left = 22'd127551;
				note_next_right = `HISI;
			end
			else	
			begin
			    note_next_left = 22'b0;
				note_next_right = 22'b0;
			end
        end
				
	always@(posedge clk or posedge rst)
        if (rst)
		begin
            note_left <= 22'b0;
			note_right <= 22'b0;
		end
        else
		begin
		    note_left <= note_next_left;
			note_right <= note_next_right;
		end
endmodule