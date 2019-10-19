`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 22:48:44
// Design Name: 
// Module Name: lab04_04
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


module lab04_04(num, lightctl, clk, rst_n);
output [7:0]num;
output [3:0]lightctl;
input clk;
input rst_n;

wire clk_out;
wire[1:0]clk_ctl;
wire[3:0]in0, in1;
wire bor_dec;
wire stop;
wire [3:0]ssd;


div_clock U0(.clk(clk), .clk_out(clk_out), .rst_n(rst_n), .clk_ctl(clk_ctl));
dct_LSB U1(.clk(clk_out), .rst_n(rst_n), .borrow(bor_dec), .out(in1), .stop(stop));
dct_MSB U2(.clk(clk_out), .rst_n(rst_n), .decrease(bor_dec), .out(in0), .stop(stop));
scan_ctl U3(.rst_n(rst_n), .sel(clk_ctl), .lightctl(lightctl), .in0(in0), .in1(in1), .intossd(ssd));
display U4(.i(ssd), .D(num));

endmodule
