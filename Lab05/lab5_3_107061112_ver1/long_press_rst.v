`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/31 22:02:26
// Design Name: 
// Module Name: long_press_rst
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


module long_press_rst(
    in,
    clk,
    rst_n,  // low active reset
    rst     // output reset
);
    input in;   // input trigger
    input clk; 
    input rst_n;
    output rst;

    reg rst;
    reg [7:0]cnt;
    reg [7:0]cnt_tmp0;
    reg [7:0]cnt_tmp1;

    always @*
    if (in == 1'b1)
        cnt_tmp0 = cnt + 1;
    else
        cnt_tmp0 = 7'b0;
    
    always @*
    if (cnt_tmp0 == 7'd100)
    begin
        rst = 1;
        cnt_tmp1 = 7'b0;
    end
    else
    begin
        rst = 0;
        cnt_tmp1 = cnt_tmp0;
    end
    always @(posedge clk or negedge rst_n)
    if (~rst_n)
        cnt <= 0;
    else
        cnt <= cnt_tmp1;

endmodule