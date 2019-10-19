`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 09:49:17
// Design Name: 
// Module Name: data_mux
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


module data_mux(
    sel_yy_mmdd,  // select pm or am
    intossd_yy,
    intossd_mmdd,
    lightctl_yy,
    lightctl_mmdd,
    intossd_out,
    lightctl_out
    );

    input sel_yy_mmdd;
    input [3:0]intossd_yy;
    input [3:0]intossd_mmdd;
    input [3:0]lightctl_yy;
    input [3:0]lightctl_mmdd;

    output reg [3:0]intossd_out;
    output reg [3:0]lightctl_out;

    always @*
        if (sel_yy_mmdd == 0)
        begin
            intossd_out = intossd_yy;
            lightctl_out = lightctl_yy;
        end
        else 
        begin
            intossd_out = intossd_mmdd;
            lightctl_out = lightctl_mmdd;
        end

endmodule

