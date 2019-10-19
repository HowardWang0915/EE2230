`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 23:09:46
// Design Name: 
// Module Name: div_clock
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


module div_clock(
    clk_out,    // output clock
    clk,    // crystal clock
    rst_n   // low active reset
    );

    output clk_out;
    input clk;
    input rst_n;

    reg clk_out;
    reg clk_out_tmp;    // t-ff, toggle
    reg [26:0]cnt_tmp;
    reg [26:0]cnt;

    // Combinational Logic
    always @*
    if (cnt == 27'd4999999)
    begin
        cnt_tmp = 27'd0;
        clk_out_tmp = ~clk_out;
    end
    else
    begin
        cnt_tmp = cnt + 1;
        clk_out_tmp = clk_out;
    end

    // Sequential Logic
    always @(posedge clk or posedge rst_n)
        if (rst_n)
        begin
            cnt <= 0;
            clk_out <= 1'b0;
        end
        else
        begin
            cnt <= cnt_tmp;
            clk_out <= clk_out_tmp;
        end
endmodule