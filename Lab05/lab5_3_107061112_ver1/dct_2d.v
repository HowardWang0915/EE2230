`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 13:36:20
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

module dct_3d(
    val0,    // value 
    val1,    // value 
    val2,   // value
    clk,
    rst_n,
    en,  // enable / disable for the stopwatch
    stop
);
    output [`BCD_BIT_WIDTH - 1:0]val0;
    output [`BCD_BIT_WIDTH - 1:0]val1;
    output [`BCD_BIT_WIDTH - 1:0]val2;
    input clk;
    input rst_n;
    input en;

    output stop;

    wire br0, br1, br2;  // wire for the borrow signal of two counters
    wire decrease_enable;   // decrease signal for the lsb to start

    assign stop  = ((val0 == 0) && (val1 == 0) && val2 == 0);
    assign decrease_enable = 
        en && (~((val0 == 0) && (val1 == 0) && (val2 == 0)));

    downcounter Udc3d0(
        .value(val0), 
        .borrow(br0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(decrease_enable), 
        .init_value(4'd0), 
        .limit(4'd9)
    );

    downcounter Udc3d1(
        .value(val1), 
        .borrow(br1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(br0), 
        .init_value(4'd0),
        .limit(4'd5)
    );

    downcounter Udc3d2(
        .value(val2),
        .borrow(br2),
        .clk(clk),
        .rst_n(rst_n),
        .decrease(br1),
        .init_value(4'd1),
        .limit(4'd9)
    );
endmodule