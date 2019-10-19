`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 23:07:24
// Design Name: 
// Module Name: clk_100HZ
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


module clk_100HZ(
    clk_out,    // output clock
    clk,    // crystal clock
    rst_n,   // low active reset
    clk_ctl
    );

    output clk_out;
    input clk;
    input rst_n;
    output [1:0]clk_ctl;
    
    reg [1:0]clk_ctl; 
    reg clk_out;
    reg clk_out_tmp;    // t-ff, toggle
    reg [25:0]cnt_tmp;
    reg [25:0]cnt;
    reg [8:0]cnt_h;
    reg [14:0]cnt_l;


    // Combinational Logic
    always @*
    if ({cnt_h, clk_ctl, cnt_l} ==26'd499999)
    begin
        cnt_tmp = 26'd0;
        clk_out_tmp = ~clk_out;
    end
    else
    begin
        cnt_tmp = {clk_out,cnt_h, clk_ctl, cnt_l} + 1'b1;
        clk_out_tmp = clk_out;
    end

    // Sequential Logic
    always @(posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        {cnt_h, clk_ctl, cnt_l} <= 26'b0;
        clk_out <= 1'b0;
    end
    else
    begin
        {clk_out, cnt_h, clk_ctl, cnt_l} <= cnt_tmp;
        clk_out <= clk_out_tmp;
    end
endmodule

