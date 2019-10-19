`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 21:30:29
// Design Name: 
// Module Name: dct_MSB
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
module dct_MSB(clk, rst_n, out, decrease, stop);
    output stop;
    output[`CNT_BIT_WIDTH - 1:0]out;    // counter output
    input clk;
    input rst_n;
    input decrease;
    
    reg[`CNT_BIT_WIDTH-1:0]out;
    reg[`CNT_BIT_WIDTH-1:0]tmp_cnt;
    reg stop;
// Combinational Logic
always @*
    if (out == 4'd0 && decrease)
    begin
        tmp_cnt = 4'd0;
        stop = 0;
    end
    else if (out != 4'd0 && decrease)
    begin
        tmp_cnt = out - 4'b1;
        stop = 1;
    end
    else
    begin
        tmp_cnt = out;
        stop = 1;
    end
            
// Sequential Logic
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        out <= 3;
    else
        out <= tmp_cnt;
endmodule