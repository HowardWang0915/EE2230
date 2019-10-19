`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 10:13:51
// Design Name: 
// Module Name: lab03_04
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


module lab03_04(ssd, lightctl, clk, rst_n);
output [7:0]ssd;    // seven segment display
output[3:0]lightctl;
input clk;
input rst_n;

wire clk_out;
wire [1:0]clk_ctl;
wire [7:0]q0, q1, q2, q3;

div_clock U0(.clk(clk), .clk_out(clk_out), .rst_n(rst_n), .clk_ctl(clk_ctl));
shifter U1(.q0(q0), .q1(q1), .q2(q2), .q3(q3), .clk(clk_out), .rst_n(rst_n));
mux_ssd U2(.rst_n(rst_n), .sel(clk_ctl), .lightctl(lightctl), .in0(q0), .in1(q1), .in2(q2), .in3(q3), .intossd(ssd));
endmodule
