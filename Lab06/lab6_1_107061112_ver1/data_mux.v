`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 21:38:25
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
    sel_12_24,  // select pm or am
    sel_hm_s,   // select hour minute or second
    intossd_12hm,
    intossd_12s,
    intossd_24hm,
    intossd_24s,
    lightctl_12hm,
    lightctl_12s,
    lightctl_24hm,
    lightctl_24s,
    intossd_out,
    lightctl_out
    );

    input sel_12_24;
    input sel_hm_s;
    input [3:0]intossd_12hm;
    input [3:0]intossd_12s;
    input [3:0]intossd_24hm;
    input [3:0]intossd_24s;
    input [3:0]lightctl_12hm;
    input [3:0]lightctl_12s;
    input [3:0]lightctl_24hm;
    input [3:0]lightctl_24s;

    output reg [3:0]intossd_out;
    output reg [3:0]lightctl_out;

    always @*
        if (sel_12_24 == 0 && sel_hm_s == 0)
        begin
            intossd_out = intossd_12hm;
            lightctl_out = lightctl_12hm;
        end
        else if (sel_12_24 == 0 && sel_hm_s == 1)
        begin
            intossd_out = intossd_12s;
            lightctl_out = lightctl_12s;
        end
        else if (sel_12_24 == 1 && sel_hm_s == 0)
        begin
            intossd_out = intossd_24hm;
            lightctl_out = lightctl_24hm;
        end
        else
        begin
            intossd_out = intossd_24s;
            lightctl_out = lightctl_24s;
        end
endmodule
