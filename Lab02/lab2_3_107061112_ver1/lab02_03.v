`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 23:15:36
// Design Name: 
// Module Name: lab02_03
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

// define seven segment 
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_a 8'b00010001
`define SS_b 8'b11000001
`define SS_c 8'b01100011
`define SS_d 8'b10000101
`define SS_e 8'b01100001
`define SS_f 8'b01110001

module ssd(i, D, d);
input [3:0]i;
output [3:0]d;
output [7:0]D;
reg [7:0]D;

assign d = i;
always @*
    case (i)
        4'b0000: D = `SS_0;
        4'b0001: D = `SS_1;
        4'b0010: D = `SS_2;
        4'b0011: D = `SS_3;
        4'b0100: D = `SS_4;
        4'b0101: D = `SS_5;
        4'b0110: D = `SS_6;
        4'b0111: D = `SS_7;
        4'b1000: D = `SS_8;
        4'b1001: D = `SS_9;
        4'b1010: D = `SS_a;
        4'b1011: D = `SS_b;
        4'b1100: D = `SS_c;
        4'b1101: D = `SS_d;
        4'b1110: D = `SS_e;
        default: D = `SS_f;
    endcase
endmodule
