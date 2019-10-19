`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 18:07:33
// Design Name: 
// Module Name: up_counter
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
module up_counter(out, clk, rst_n);

output[`CNT_BIT_WIDTH - 1:0]out;    // counter output
input clk;
input rst_n;

reg[`CNT_BIT_WIDTH-1:0]out;
reg[`CNT_BIT_WIDTH-1:0]tmp_cnt;

// Combinational Logic
always @*
    tmp_cnt = out + 1'b1;

// Sequential Logic
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        out <= 0;
    else
        out <= tmp_cnt;
endmodule