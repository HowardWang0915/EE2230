`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/19 07:55:05
// Design Name: 
// Module Name: uct_min
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


module uct_min(
    val2, 
    val3, 
    clk, 
    rst_n,
    count_en
    );
    input clk;
    input rst_n;
    input count_en;

    output [3:0]val2, val3;
    wire car0, car1;
    reg hour_reset;
    
    always @*
    if ((val2 == 3) && (val3 == 2))
        hour_reset = 1'b1;
    else
        hour_reset = 1'b0;
    
    upcounter Uct_min0(
        .value(val2), 
        .carry(car0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(count_en), 
        .init_value(4'd0), 
        .limit(4'd9),
        .recur_reset(hour_reset)
    );

    upcounter Uct_min1(
        .value(val3), 
        .carry(car1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(car0), 
        .init_value(4'd0),
        .limit(4'd2),
        .recur_reset(hour_reset)
    );
endmodule