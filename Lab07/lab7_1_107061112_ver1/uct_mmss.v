`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 22:23:43
// Design Name: 
// Module Name: uct_mmss
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


module uct_mmss(
    val0, 
    val1, 
    val2, 
    val3,
    clk, 
    rst_n,
    count_en
    );
    input clk;
    input rst_n;
    input count_en;

    output [3:0]val0, val1, val2, val3;
    wire car0, car1, cal2, car3;

    upcounter Uct3d0(
        .value(val0), 
        .carry(car0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(count_en), 
        .init_value(4'd0), 
        .limit(4'd9)
    );

    upcounter Uct3d1(
        .value(val1), 
        .carry(car1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(car0), 
        .init_value(4'd0),
        .limit(4'd5)
    );

    upcounter Uct3d2(
        .value(val2),
        .carry(car2),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car1),
        .init_value(4'd0),
        .limit(4'd9)
    );

    upcounter Uct3d3(
        .value(val3),
        .carry(car3),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car2),
        .init_value(4'd0),
        .limit(4'd5)
    );
endmodule
