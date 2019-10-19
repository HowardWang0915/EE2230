`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 20:31:14
// Design Name: 
// Module Name: mux_ssd
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


`define SS_N 8'b11010101
`define SS_T 8'b11100001
`define SS_H 8'b10010001
`define SS_U 8'b10000011
`define SS_E 8'b01100001

module mux_ssd(intossd, sel, in0, in1, in2, in3, lightctl, rst_n);
output reg [7:0]intossd; // this will later go in the ssd
output reg [3:0]lightctl; // control which light
input [1:0]sel;   // MUX selector
input [7:0]in0, in1, in2, in3;  // attached to q's
input rst_n;

always @*
if (~rst_n)
begin
    lightctl = 4'b0000;
    intossd = 8'b00000000;
end
else
begin
    case(sel)
        2'b00:
        begin
            lightctl = 4'b0111; // low active
            intossd = in0;
        end
        2'b01:
        begin
            lightctl = 4'b1011;
            intossd = in1;
        end
        2'b10:
        begin
            lightctl = 4'b1101; // low active
            intossd = in2;
        end
        2'b11:
        begin
            lightctl = 4'b1110; // low active
            intossd = in3;
        end
        default:
        begin
            lightctl = 4'b0000;
            intossd = 8'b00000000;
        end
    endcase
end
endmodule
