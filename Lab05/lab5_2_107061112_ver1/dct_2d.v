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

module dct_2d(
    lsb,    // value of lsb
    msb,    // value of msb
    clk,
    rst_n,
    en,  // enable / disable for the stopwatch
    stop
);
    output [`BCD_BIT_WIDTH - 1:0]msb;
    output [`BCD_BIT_WIDTH - 1:0]lsb;
    input clk;
    input rst_n;
    input en;

    output stop;

    wire br0, br1;  // wire for the borrow signal of two counters
    wire decrease_enable;   // decrease signal for the lsb to start

    assign stop  = ((lsb == 0) && (msb == 0));
    assign decrease_enable = 
        en && (~((lsb == 0) && (msb == 0)));

    dct_LSB Udc0(
        .value(lsb), 
        .borrow(br0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(decrease_enable), 
        .init_value(4'd0), 
        .limit(4'd9)
    );

    dct_MSB Udc1(
        .value(msb), 
        .borrow(br1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(br0), 
        .init_value(4'd3),
        .limit(4'd9)
    );
endmodule
