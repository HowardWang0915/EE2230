`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/20 00:33:21
// Design Name: 
// Module Name: uct_dct_display_sel
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


module uct_dct_display_sel(
    in0dct,
    in1dct, 
    in2dct, 
    in3dct,
    in0uct,
    in1uct,
    in2uct, 
    in3uct,
    out0, 
    out1, 
    out2, 
    out3,
    set
    );
    input [3:0]in0dct, in1dct, in2dct, in3dct;
    input [3:0]in0uct, in1uct, in2uct, in3uct;
    input set;

    output reg [3:0]out0, out1, out2, out3;

    always @*
        if (set == 1'b1)
            begin
                out0 = in0uct;
                out1 = in1uct;
                out2 = in2uct;
                out3 = in3uct;
            end
        else 
            begin
                out0 = in0dct;
                out1 = in1dct;
                out2 = in2dct;
                out3 = in3dct;
            end
endmodule
