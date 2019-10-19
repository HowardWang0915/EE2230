`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 23:16:06
// Design Name: 
// Module Name: clock_sel
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


module clock_sel(
    clk_100HZ,      // 100HZ signal
    clk_1HZ,        // 1HZ signal
    sel_clock,      // select which clock
    clk_ctl_1HZ,
    clk_ctl_100HZ,
    clk_out,        // output clock
    clk_ctl_out     // output clk_ctl
    );
    input clk_100HZ;
    input clk_1HZ;
    input sel_clock;
    input [1:0]clk_ctl_100HZ;
    input [1:0]clk_ctl_1HZ;
    output reg clk_out;
    output reg [1:0]clk_ctl_out;
// selcecting clock signal
always @*
    if (sel_clock == 1'b1)
    begin
        clk_out = clk_100HZ;
        clk_ctl_out = clk_ctl_100HZ;
    end
    else
    begin
        clk_out = clk_1HZ;
        clk_ctl_out = clk_ctl_1HZ;
    end
endmodule
