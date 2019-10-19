`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/24 22:26:41
// Design Name: 
// Module Name: sound_sel
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


module sound_sel(
    indo,
    inre,
    inmi,
    out_sound
    );
    input indo, inre, inmi;
    output reg [21:0]out_sound;
always @*
    if (indo == 1'b1)
        out_sound = 22'd191571;
    else if (inre == 1'b1)
        out_sound = 22'd170648;
    else if (inmi == 1'b1)
        out_sound = 22'd151515;
    else
        out_sound = 22'b0;
endmodule
