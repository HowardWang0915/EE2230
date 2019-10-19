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

module uct_mmdd(
    val0,   // output value 0   day
    val1,   // output value 1   day
    val2,   // output value 2   month
    val3,   // output value 3   month
    leap_year,  // leap year indicator
    clk,    
    rst_n,
    increase,   // increase signal
    car3    // output carry
);
    output car3;
    output [`BCD_BIT_WIDTH - 1:0]val0, val1, val2, val3;
    input increase;
    input clk;
    input rst_n;
    input leap_year;

    wire car0, car1, car2;  // wire for the carry signal of two counters
    reg day_reset;     // if the counter exceed days of a month, then reset
    reg month_reset;    // if the counter exceed december, then reset
    reg [`BCD_BIT_WIDTH - 1:0]leap_day;       // for February

    // leap year logic
    always @*
        if (leap_year == 1'b1)
            leap_day = 4'd9;
        else
            leap_day = 4'd8;
    // big month small month
    always @*
    begin
        if (((val2 == 1) && (val3 == 0)) | ((val2 == 3) && (val3 == 0)) |
            ((val2 == 5) && (val3 == 0)) | ((val2 == 7) && (val3 == 0)) |
            ((val2 == 8) && (val3 == 0)) | ((val2 == 0) && (val3 == 1)) |
            ((val2 == 2) && (val3 == 1)))
        begin
            if ((val0 == 1) && (val1 == 3))
                day_reset = 1'b1;
            else
                day_reset = 1'b0;
        end
        else if (((val2 == 4) && (val3 == 0)) | ((val2 == 6) && (val3 == 0)) |
                 ((val2 == 9) && (val3 == 0)) | ((val2 == 1) && (val3 == 1)))
        begin
            if ((val0 == 0) && (val1 == 3))
                day_reset = 1'b1;
            else
                day_reset = 1'b0;
        end
        else
        begin
            if ((val0 == leap_day) && (val1 == 2))
                day_reset = 1'b1;
            else
                day_reset = 1'b0;
        end
    end
    // month reset
    always @*
    begin
        if ((val2 == 2) && (val3 == 1))
            month_reset = 1'b1;
        else
            month_reset = 1'b0;
    end

    upcounter_mdy Udc3d0(
        .value(val0), 
        .carry(car0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(increase), 
        .init_value(4'd1), 
        .limit(4'd9),
        .recur_reset(day_reset)
    );

    upcounter_mdy Udc3d1(
        .value(val1), 
        .carry(car1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(car0), 
        .init_value(4'd0),
        .limit(4'd5),
        .recur_reset(day_reset)
    );

    upcounter_mdy Udc3d2(
        .value(val2),
        .carry(car2),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car1),
        .init_value(4'd1),
        .limit(4'd9),
        .recur_reset(month_reset)
    );
    upcounter_mdy Udc3d3(
        .value(val3),
        .carry(car3),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car2),
        .init_value(4'd0),
        .limit(4'd5),
        .recur_reset(month_reset)
    );

endmodule