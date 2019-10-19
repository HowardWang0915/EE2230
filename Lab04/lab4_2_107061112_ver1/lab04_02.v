`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 16:19:36
// Design Name: 
// Module Name: lab04_02
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


module lab04_02(clk, rst_n, display);

input clk;
input rst_n;
output [7:0]display;

wire clk_out;
wire [3:0]out; // ouput from the counter

div_clock U0(.clk(clk), .clk_out(clk_out), .rst_n(rst_n));
up_counter U1(.clk(clk_out), .rst_n(rst_n), .out(out));
display U2(.i(out), .D(display)); 

endmodule
