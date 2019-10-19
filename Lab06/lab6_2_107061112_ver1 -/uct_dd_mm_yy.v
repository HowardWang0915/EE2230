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

module uct_dd_mm_yy(
    val0,   // output value 0   day
    val1,   // output value 1   day
    val2,   // output value 2   month
    val3,   // output value 3   month
    val4,   // output value 4   year
    val5,   // output value 5   year
    clk,    
    rst_n
);
    output [`BCD_BIT_WIDTH - 1:0]val0, val1, val2, val3, val4, val5;
    input clk;
    input rst_n;

    wire car0, car1, car2, car3, car4, car5;  // wire for the carry signal of two counters
    reg day_reset;     // if the counter exceed days of a month, then reset
    reg month_reset;    // if the counter exceed december, then reset

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
            if ((val0 == 8) && (val1 == 2))
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

    upcounter Udc3d0(
        .value(val0), 
        .carry(car0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(1'b1), 
        .init_value(4'd1), 
        .limit(4'd9),
        .recur_reset(day_reset)
    );

    upcounter Udc3d1(
        .value(val1), 
        .carry(car1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(car0), 
        .init_value(4'd0),
        .limit(4'd5),
        .recur_reset(day_reset)
    );

    upcounter Udc3d2(
        .value(val2),
        .carry(car2),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car1),
        .init_value(4'd1),
        .limit(4'd9),
        .recur_reset(month_reset)
    );
    upcounter Udc3d3(
        .value(val3),
        .carry(car3),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car2),
        .init_value(4'd0),
        .limit(4'd5),
        .recur_reset(month_reset)
    );
    upcounter Udc3d4(
        .value(val4),
        .carry(car4),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car3),
        .init_value(4'd0),
        .limit(4'd9),
        .recur_reset(1'b0)
    );
    upcounter Udc3d5(
        .value(val5),
        .carry(car5),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car4),
        .init_value(4'd0),
        .limit(4'd9),
        .recur_reset(1'b0)
    );
endmodule