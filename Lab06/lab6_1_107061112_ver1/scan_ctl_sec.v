`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 21:28:24
// Design Name: 
// Module Name: scan_ctl_sec
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


module scan_ctl_sec(intossd, lightctl, sel, in0, in1);
output reg [3:0]intossd; // this will later go in the ssd
output reg [3:0]lightctl; // control which light
input [1:0]sel;   // MUX selector
input [3:0]in0, in1;  // attached to q's


always @*
    case(sel)
        2'b00:
        begin
            lightctl = 4'b1110; // low active
            intossd = in0;
        end
        2'b10:
        begin
            lightctl = 4'b1101;
            intossd = in1;
        end
        default:
        begin
            lightctl = 4'b1111;
            intossd = 4'b0;
        end
    endcase
endmodule
