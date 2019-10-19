`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 20:37:34
// Design Name: 
// Module Name: bin_to_dec
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


module bin_to_dec(
    output reg [3:0]BCD3,
    output reg [3:0]BCD2,
    output reg [3:0]BCD1,
    output reg [3:0]BCD0,
    input [6:0]ans
    );

    always @*
    begin
        BCD3 = 4'd0;
        BCD2 = (ans / 7'd100) - (BCD3 *7'd10);
        BCD1 = (ans / 7'd10) - (BCD3 * 7'd100) - (BCD2 * 7'd10);
        BCD0 = ans % 7'd10;
    end
endmodule