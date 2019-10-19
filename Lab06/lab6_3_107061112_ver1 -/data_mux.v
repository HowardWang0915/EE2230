`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 23:28:11
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
    counter_sel,
    intossd_12hm,
    intossd_12s,
    intossd_24hm,
    intossd_24s,
    intossd_mmdd,
    intossd_yyyy,
    lightctl_12hm,
    lightctl_12s,
    lightctl_24hm,
    lightctl_24s,
    lightctl_mmdd,
    lightctl_yyyy,
    intossd_out,
    lightctl_out
    );
    input [2:0]counter_sel;
    input [3:0]intossd_12hm;
    input [3:0]intossd_12s;
    input [3:0]intossd_24hm;
    input [3:0]intossd_24s;
    input [3:0]intossd_mmdd;
    input [3:0]intossd_yyyy;
    input [3:0]lightctl_12hm;
    input [3:0]lightctl_12s;
    input [3:0]lightctl_24hm;
    input [3:0]lightctl_24s;
    input [3:0]lightctl_mmdd;
    input [3:0]lightctl_yyyy;
    output reg [3:0]intossd_out;
    output reg [3:0]lightctl_out;

    always @*
        if (counter_sel == 3'b000)
        begin
            intossd_out = intossd_12hm;
            lightctl_out = lightctl_12hm; 
        end
        else if (counter_sel == 3'b001)
        begin
            intossd_out = intossd_12s;
            lightctl_out = lightctl_12s;
        end
        else if (counter_sel == 3'b010)
        begin
            intossd_out = intossd_24hm;
            lightctl_out = lightctl_24hm;
        end
        else if (counter_sel == 3'b011)
        begin
            intossd_out = intossd_24s;
            lightctl_out = lightctl_24s;
        end
        else if (counter_sel == 3'b100)
        begin
            intossd_out = intossd_mmdd;
            lightctl_out = lightctl_mmdd;
        end
        else if(counter_sel == 3'b101)
        begin
            intossd_out = intossd_yyyy;
            lightctl_out = lightctl_yyyy;
        end
        else
        begin
            intossd_out = 4'b0;
            lightctl_out = 4'b1;
        end
endmodule
