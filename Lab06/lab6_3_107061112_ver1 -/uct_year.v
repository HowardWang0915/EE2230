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

module uct_year(
    val0,   // output value 0   day
    val1,   // output value 1   day
    val2,   // output value 2   month
    val3,   // output value 3   month
    increase,   // increase enable signal
    clk,    
    rst_n
);
    output [`BCD_BIT_WIDTH - 1:0]val0, val1, val2, val3;
    input clk;
    input rst_n;
    input increase;

    wire car1, car2, car3;  // wire for the carry signal of two counters
    reg year_reset;
    // big month small month
    always @*
        if ((val3 == 2) && (val2 == 1) && (val1 == 9) && (val0 == 9))
            year_reset = `ENABLED;
        else
            year_reset = `DISABLED;

    upcounter_mdy Udc3d0(
        .value(val0), 
        .carry(car0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(increase), 
        .init_value(4'd0), 
        .limit(4'd9),
        .recur_reset(year_reset)
    );

    upcounter_mdy Udc3d1(
        .value(val1), 
        .carry(car1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(car0), 
        .init_value(4'd0),
        .limit(4'd5),
        .recur_reset(year_reset)
    );

    upcounter_mdy Udc3d2(
        .value(val2),
        .carry(car2),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car1),
        .init_value(4'd0),
        .limit(4'd9),
        .recur_reset(year_reset)
    );
    upcounter_mdy Udc3d3(
        .value(val3),
        .carry(car3),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car2),
        .init_value(4'd2),
        .limit(4'd5),
        .recur_reset(year_reset)
    );

endmodule