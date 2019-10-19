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

module uct_12(
    val0,   // output value 0 
    val1,   // output value 1
    val2,   // output value 2
    val3,   // output value 3
    val4,   // output value 4
    val5,   // output value 5
    clk,    
    rst_n
);
    output [`BCD_BIT_WIDTH - 1:0]val0, val1, val2, val3, val4, val5;
    input clk;
    input rst_n;

    wire car0, car1, car2, car3, car4, car5;  // wire for the borrow signal of two counters
    wire [`BCD_BIT_WIDTH - 1:0]val4_tmp, val5_tmp;  // becuase there are no 00:00 in p.m., we make 00:00 12:00
    reg hour_reset;     // if the counter exceed 12/24, then reset
    reg [`BCD_BIT_WIDTH - 1:0]val4, val5;
    always @*
    begin
        if ((val5_tmp == 1) && (val4_tmp == 1))
            hour_reset = 1'b1;
        else
            hour_reset = 1'b0;
    end
    always @*
    begin
        if ((val4_tmp == 0) && (val5_tmp == 0))
        begin
            val4 = 2;
            val5 = 1;
        end
        else
        begin  
            val4 = val4_tmp;
            val5 = val5_tmp;
        end
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
        .value(val4_tmp),
        .carry(car4),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car3),
        .init_value(4'd1),
        .limit(4'd9),
        .hour_reset(hour_reset)
    );
    upcounter Udc3d5(
        .value(val5_tmp),
        .carry(car5),
        .clk(clk),
        .rst_n(rst_n),
        .increase(car4),
        .init_value(4'd1),
        .limit(4'd1),
        .hour_reset(hour_reset)
    );
endmodule
