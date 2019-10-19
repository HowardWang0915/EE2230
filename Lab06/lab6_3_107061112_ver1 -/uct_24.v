`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/04 11:13:18
// Design Name: 
// Module Name: dct_6d_24
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
module uct_24(
    val0,   // output value 0 
    val1,   // output value 1
    val2,   // output value 2
    val3,   // output value 3
    val4,   // output value 4
    val5,   // output value 5
    clk,    
    rst_n,
    car5    // output carry
);
    output [`BCD_BIT_WIDTH - 1:0]val0, val1, val2, val3, val4, val5;
    output car5;
    input clk;
    input rst_n;

    wire car0, car1, car2, car3, car4;  // wire for the borrow signal of two counters
    reg hour_reset;
    always @*
    begin
        if ((val5 == 2) && (val4 == 3))
            hour_reset = 1'b1;
        else
            hour_reset = 1'b0;
    end
    upcounter Udc3d0(
        .value(val0), 
        .carry(car0), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(1'b1), 
        .init_value(4'd0), 
        .limit(4'd9),
        .hour_reset(1'b0)
    );

    upcounter Udc3d1(
        .value(val1), 
        .carry(car1), 
        .clk(clk), 
        .rst_n(rst_n), 
        .increase(car0), 
        .init_value(4'd0),
        .limit(4'd5),
        .hour_reset(1'b0)
    );

    upcounter Udc3d2(
        .value(val2),
        .carry(car2),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car1),
        .init_value(4'd9),
        .limit(4'd9),
        .hour_reset(1'b0)
    );
    upcounter Udc3d3(
        .value(val3),
        .carry(car3),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car2),
        .init_value(4'd5),
        .limit(4'd5),
        .hour_reset(1'b0)
    );
    upcounter Udc3d4(
        .value(val4),
        .carry(car4),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car3),
        .init_value(4'd3),
        .limit(4'd9),
        .hour_reset(hour_reset)
    );
    upcounter Udc3d5(
        .value(val5),
        .carry(car5),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car4),
        .init_value(4'd2),
        .limit(4'd2),
        .hour_reset(hour_reset)
    );
endmodule