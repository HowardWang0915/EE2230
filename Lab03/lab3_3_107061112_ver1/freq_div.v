`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 23:38:27
// Design Name: 
// Module Name: freq_div
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
module freq_div(clk_out, clk, rst_n);

output clk_out;
input clk;
input rst_n;

reg clk_out;
reg[`FREQ_DIV_BIT - 2:0]cnt;
reg[`FREQ_DIV_BIT - 1:0]cnt_tmp;

//Combinational Logic
always @*
    cnt_tmp = {clk_out, cnt} + 1'b1;

// Sequential Logic
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        {clk_out, cnt} <= `FREQ_DIV_BIT'b0;
    else
    begin
        {clk_out, cnt} <= cnt_tmp;
        if (cnt == `FREQ_DIV_BIT'd50000000)
        begin
            cnt <= `FREQ_DIV_BIT'b0;
            clk_out <= ~clk_out;
        end
    end
endmodule
