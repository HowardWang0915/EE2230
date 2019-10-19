`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 18:44:22
// Design Name: 
// Module Name: lab04_01
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

`define CNT_BIT_WIDTH 4
module lab04_01(clk, rst_n, out);

input clk;
input rst_n;
output[`CNT_BIT_WIDTH - 1:0]out;

wire clk_out;

div_clock U0(.clk(clk), .rst_n(rst_n), .clk_out(clk_out));
up_counter U1(.clk(clk_out), .out(out), .rst_n(rst_n));


endmodule
