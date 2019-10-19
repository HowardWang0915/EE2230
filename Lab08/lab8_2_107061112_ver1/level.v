`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 22:41:33
// Design Name: 
// Module Name: level
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


module level(
    level,
    in_up,
    in_down,
    clk,
    rst_n
    );
    input clk;
    input in_up;
    input in_down;
    input rst_n;

    output reg [3:0]level;
    reg [3:0] next_level;
    
    always @(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            level <= 4'd0;
        else
            level <= next_level;
    end
    
    always @*
    begin
        if(in_up == 1'b1 && level < 4'd15)
            next_level = level + 4'd1;
        else if(in_down == 1'b1 && level > 0)
            next_level = level - 4'd1;
        else
            next_level = level;
    end
    
endmodule