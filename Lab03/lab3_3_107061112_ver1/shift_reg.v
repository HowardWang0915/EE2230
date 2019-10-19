`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 23:38:27
// Design Name: 
// Module Name: shift_reg
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


`define BIT_WIDTH 8
module shift_reg(
    q, // shifter output
    clk, // global clock
    rst_n // active low reset
);
output [`BIT_WIDTH-1:0] q; // output
input clk; // global clock
input rst_n; // active low reset
reg [`BIT_WIDTH-1:0] q; // output
// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        q <= `BIT_WIDTH'b01010101;
    end
    else
    begin
        q[0] <= q[7];
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
        q[4] <= q[3];
        q[5] <= q[4];
        q[6] <= q[5];
        q[7] <= q[6]; 
    end
endmodule
