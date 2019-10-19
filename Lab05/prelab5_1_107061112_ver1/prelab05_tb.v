`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 14:34:47
// Design Name: 
// Module Name: prelab05_tb
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
module prelab05_tb;

    reg clk;
    reg rst_n;
    reg in;

    wire [`BCD_BIT_WIDTH - 1:0]msb;
    wire [`BCD_BIT_WIDTH - 1:0]lsb;
    wire [15:0]led;
;
    prelab05 U0(.clk(clk), .rst_n(rst_n), .in(in), .msb(msb), .lsb(lsb), .led(led));
    initial
    begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial 
    begin
        rst_n = 0;
        #20 rst_n = 1;
        #700
            rst_n = 0;
    end
    initial
    begin 
        in = 0;
        #5 in = 1;
        forever #10 in = ~in;
    end
endmodule
