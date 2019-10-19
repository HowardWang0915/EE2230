`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/30 10:38:19
// Design Name: 
// Module Name: scan_ctl_3d
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


module scan_ctl_3d(
    intossd,
    lightctl,
    sel,
    in0,
    in1,
    in2
    );
    output reg [3:0]intossd;
    output reg [3:0]lightctl;
    input [1:0]sel;
    input [3:0]in0, in1, in2;

    always @*
        case(sel)
            2'b01:
            begin
                lightctl = 4'b1110;
                intossd = in0;
            end
            2'b10:
            begin
                lightctl = 4'b1101;
                intossd = in1;
            end
            2'b11:
            begin
                lightctl = 4'b1011;
                intossd = in2;
            end
            default:
            begin
                lightctl = 4'b1111;
                intossd = 4'b0000;
            end
        endcase
endmodule
