`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/07 15:41:45
// Design Name: 
// Module Name: shift_tb
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

`define BCD_BIT_WIDTH 8
module shift_tb;
    wire [`BCD_BIT_WIDTH - 1:0]q;
    reg clk;
    reg rst_n;
    shifter U1(.clk(clk), .rst_n(rst_n), .q(q));
    initial
    begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial 
    begin
        rst_n = 0;
        #20 rst_n = 1;
    end
endmodule
