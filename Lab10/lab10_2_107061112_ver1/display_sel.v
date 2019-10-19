`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 19:11:18
// Design Name: 
// Module Name: display_sel
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


module display_sel(
    note,
    note_out
    );
    input [21:0]note;
    output reg[3:0]note_out;
always @*
    if (note == 22'd383141 || note == 22'd190839)
        note_out = 4'd1;
    else if (note == 22'd341296 || note == 22'd170068)
        note_out = 4'd2;
    else if (note == 22'd303030 || note == 22'd151515)
        note_out = 4'd3;
    else if (note == 22'd286532 || note == 22'd143266)
        note_out = 4'd4;
    else if (note == 22'd255102 || note == 22'd127551)
        note_out = 4'd5;
    else if (note == 22'd227272 || note == 22'd113636)
        note_out = 4'd6;
    else if (note == 22'd202492 || note == 22'd101214)
        note_out = 4'd7;
    else 
        note_out = 4'd0;
endmodule
