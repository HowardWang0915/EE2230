`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/05 20:47:52
// Design Name: 
// Module Name: prelab03_01_tb
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

`define BCD_BIT_WIDTH 4

module prelab03_01_tb;

wire [`BCD_BIT_WIDTH - 1:0]q;
reg clk;
reg rst_n;

prelab03_01 U0 (.clk(clk), .rst_n(rst_n), .q(q));
initial 
begin
    rst_n = 0;
    #20 rst_n = 1;
end
initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

endmodule
