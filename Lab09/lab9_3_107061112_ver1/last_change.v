`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 17:36:34
// Design Name: 
// Module Name: last_change
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


module last_change(
    last_change,
    out
    );
    input [8:0]last_change;      // last change signal
    output reg [3:0]out;             // converted last change

    always @*
        case (last_change)
            9'h70: out = 4'd0;
            9'h69: out = 4'd1;
            9'h72: out = 4'd2;
            9'h7A: out = 4'd3;
            9'h6B: out = 4'd4;
            9'h73: out = 4'd5;
            9'h74: out = 4'd6;
            9'h6C: out = 4'd7;
            9'h75: out = 4'd8;
            9'h7D: out = 4'd9;
            9'h79: out = 4'd10;
            9'h7B: out = 4'd11;
            9'h7C: out = 4'd12;
            9'h5A: out = 4'd13;
            default: out = 4'd0;
        endcase
endmodule
