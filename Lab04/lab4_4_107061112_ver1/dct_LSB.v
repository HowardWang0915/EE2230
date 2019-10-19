`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 21:30:29
// Design Name: 
// Module Name: dct_LSB
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
module dct_LSB(clk, rst_n, out, decrease, borrow, stop);
    output[`CNT_BIT_WIDTH - 1:0]out;    // counter output
    output borrow;
    input clk;
    input rst_n;
    input decrease;
    input stop; // low active stop, to tell the counter to stop at 00
    
    reg[`CNT_BIT_WIDTH-1:0]out;
    reg[`CNT_BIT_WIDTH-1:0]tmp_cnt;
    reg borrow;

assign decrease = 1;
// Combinational Logic
always @*
    if (out == 4'd0 && decrease)
    begin
        tmp_cnt = 4'd9;
        borrow = 1;
    end
    else if (out != 4'd0 && decrease)
    begin
        tmp_cnt = out - 4'b1;
        borrow = 0;
    end
    else
    begin
        tmp_cnt = out;
        borrow = 0;
    end



// Sequential Logic
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        out <= 0;
    else if (~stop)
        out <= 0;
    else
        out <= tmp_cnt;
endmodule