`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/19 07:55:05
// Design Name: 
// Module Name: dct_4d
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


module dct_4d(
    val0,    // value of downcounter
    val1,   
    val2,
    val3,
    init_val0, 
    init_val1,
    init_val2, 
    init_val3,
    clk,
    rst_n,
    en,
    stop
);
    output [`BCD_BIT_WIDTH - 1:0]val0, val1, val2, val3;
    output stop;

    input [`BCD_BIT_WIDTH - 1:0]init_val0, init_val1, init_val2, init_val3;
    input clk;
    input rst_n;
    input en;

    wire decrease_enable;
    wire br0, br1, br2, br3;  // wire for the borrow signal of four counters

    assign stop  = ((val0 == 0) && (val1 == 0) && (val2 == 0) && (val3 == 0));
    assign decrease_enable = 
        en && (~((val0 == 0) && (val1 == 0) && (val2 == 0) && ( val3 == 0)));
    
    downcounter Udc2d0(
        .value(val0), 
        .borrow(br0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(decrease_enable), 
        .init_value(init_val0), 
        .limit(4'd9)
    );

    downcounter Udc2d1(
        .value(val1), 
        .borrow(br1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(br0), 
        .init_value(init_val1),
        .limit(4'd5)
    );

    downcounter Udc2d2(
        .value(val2), 
        .borrow(br2), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(br1), 
        .init_value(init_val2),
        .limit(4'd3)
    );
    downcounter Udc2d3(
        .value(val3), 
        .borrow(br3), 
        .clk(clk), 
        .rst_n(rst_n), 
        .decrease(br2), 
        .init_value(init_val3),
        .limit(4'd2)
    );
endmodule
