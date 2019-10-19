`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/05 19:57:50
// Design Name: 
// Module Name: prelab03_01
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

module prelab03_01(q, clk, rst_n);

output [`BCD_BIT_WIDTH - 1:0]q; // ouput
input clk;
input rst_n;

reg[`BCD_BIT_WIDTH - 1:0]q;
reg[`BCD_BIT_WIDTH - 1:0]q_tmp;

// Combinational logics
always @*
    q_tmp = q + 4'd1;


// Sequential logic
always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
        q <= `BCD_BIT_WIDTH'd0;
    else
        q <= q_tmp;
end
endmodule
