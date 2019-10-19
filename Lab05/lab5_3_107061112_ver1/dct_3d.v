`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/29 22:02:45
// Design Name: 
// Module Name: dct_2d
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
`define ENABLED 1
`define DISABLED 0

module dct_2d(
    val0,    // value of lsb
    val1,    // value of msb
    clk,
    rst_n,
    en,  // enable / disable for the stopwatch
    stop
);
    output [`BCD_BIT_WIDTH - 1:0]val0;
    output [`BCD_BIT_WIDTH - 1:0]val1;
    input clk;
    input rst_n;
    input en;

    output stop;

    wire br0, br1;  // wire for the borrow signal of two counters
    wire decrease_enable;   // decrease signal for the lsb to start

    assign stop  = ((val0 == 0) && (val1 == 0));
    assign decrease_enable = 
        en && (~((val0 == 0) && (val1 == 0)));

    downcounter Udc2d0(
        .value(val0), 
        .borrow(br0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(decrease_enable), 
        .init_value(4'd0), 
        .limit(4'd9)
    );

    downcounter Udc2d1(
        .value(val1), 
        .borrow(br1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(br0), 
        .init_value(4'd3),
        .limit(4'd9)
    );
endmodule