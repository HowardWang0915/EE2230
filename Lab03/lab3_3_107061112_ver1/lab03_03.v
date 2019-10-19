`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 10:01:58
// Design Name: 
// Module Name: lab03_03
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


module lab03_03(q, rst_n, clk);

output [7:0]q;
input rst_n;
input clk;

wire clk_out;

freq_div U0(.clk_out(clk_out), .clk(clk), .rst_n(rst_n));
shift_reg U1(.q(q), .clk(clk_out), .rst_n(rst_n));

endmodule
