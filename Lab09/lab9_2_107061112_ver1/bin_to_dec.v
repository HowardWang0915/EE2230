`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 18:31:05
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
    output reg [3:0] BCD1,
    output reg [3:0] BCD0,
    input [3:0]addend,
    input [3:0]augend
    );
    
    wire [4:0]tmp;
    assign tmp = addend + augend;
    always @*
        if (tmp <= 4'd9)
        begin
            BCD1 = 4'd0;
            BCD0 = tmp;
        end
        else if (tmp <= 4'd15)
            {BCD1, BCD0} = addend + augend + 4'd6;
        else if (tmp == 5'd16)
        begin
            BCD1 = 4'd1;
            BCD0 = 4'd6;
        end
        else if (tmp == 5'd17)
        begin
            BCD1 = 4'd1;
            BCD0 = 4'd7;
        end
        else if (tmp == 5'd18)
        begin
            BCD1 = 4'd1;
            BCD0 = 4'd8;
        end
        else
        begin
            BCD1 = 4'd0;
            BCD0 = 4'd0;
        end
endmodule
