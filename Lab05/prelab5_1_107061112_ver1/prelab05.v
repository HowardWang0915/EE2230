`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/19 21:48:57
// Design Name: 
// Module Name: prelab05
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
module prelab05(
    clk,    // global clock
    rst_n,  // low actie reset
    in,      // input for FSM
    msb,
    lsb,
    led,
);

    input clk;
    input rst_n;
    input in;

    output [`BCD_BIT_WIDTH - 1:0]msb;
    output [`BCD_BIT_WIDTH - 1:0]lsb;
    output [15:0]led;

    wire count_enable;  // for connection of fsm and counter
    wire stop;  // decrease enable signal will connect to the led signal


    fsm U_fsm(
        .count_enable(count_enable),
        .in(in),    // input control
        .clk(clk), 
        .rst_n(rst_n)
    );

    dct_2d U_dct(
      .msb(msb),
      .lsb(lsb), 
      .clk(clk), 
      .rst_n(rst_n), 
      .en(count_enable),
      .stop(stop)
    );

    LED U_led(
        .stop(stop),
        .display(led)
    );
endmodule
