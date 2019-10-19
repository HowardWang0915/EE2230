`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 17:12:26
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
            9'h45: out = 4'd0;
            9'h16: out = 4'd1;
            9'h1E: out = 4'd2;
            9'h26: out = 4'd3;
            9'h25: out = 4'd4;
            9'h2E: out = 4'd5;
            9'h36: out = 4'd6;
            9'h3D: out = 4'd7;
            9'h3E: out = 4'd8;
            9'h46: out = 4'd9;
            9'h1C: out = 4'd10;
            9'h1B: out = 4'd11;
            9'h3A: out = 4'd12;
            default: out = 4'd0;
        endcase
endmodule
