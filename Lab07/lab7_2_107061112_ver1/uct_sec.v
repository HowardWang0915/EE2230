`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/19 07:55:05
// Design Name: 
// Module Name: uct_sec
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


module uct_sec(
    val0, 
    val1,
    clk, 
    rst_n,
    count_en
    );
    input clk;
    input rst_n;
    input count_en;

    output [3:0]val0, val1;
    wire car0, car1;

    upcounter Uct_sec0(
        .value(val0), 
        .carry(car0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(count_en), 
        .init_value(4'd0), 
        .limit(4'd9),
        .recur_reset(1'b0)
    );

    upcounter Uct_sec1(
        .value(val1), 
        .carry(car1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(car0), 
        .init_value(4'd0),
        .limit(4'd5),
        .recur_reset(1'b0)
    );
endmodule