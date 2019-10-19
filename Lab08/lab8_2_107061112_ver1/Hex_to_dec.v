`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 00:20:17
// Design Name: 
// Module Name: Hex_to_dec
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


module Hex_to_dec(
    output reg [3:0] BCD1,
    output reg [3:0] BCD0,
    input [3:0] binary
    );
    
    always @*
    begin
        if(binary <= 4'd9)
        begin
            BCD1 = 4'd0;
            BCD0 = binary;
        end
        else
            {BCD1, BCD0} = binary + 4'd6;
    end
endmodule