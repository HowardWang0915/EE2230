`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 16:39:32
// Design Name: 
// Module Name: lab03_01
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


`define FREQ_DIV_BIT 27

module lab03_01(
clk_out, // divided clock output
clk, // global clock input
rst_n // active low reset
);

output clk_out; // divided output
input clk; // global clock input
input rst_n; // active low reset

reg clk_out; // clk output (in always block)
reg [`FREQ_DIV_BIT-2:0] cnt; // remainder of the counter
reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input to dff (in always block)
// Combinational logics: increment, neglecting overflow
always @*
    cnt_tmp = {clk_out,cnt} + 1'b1;
// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
    if (~rst_n) 
        {clk_out, cnt} <= `FREQ_DIV_BIT'd0;
    else 
        {clk_out,cnt} <= cnt_tmp;
endmodule
