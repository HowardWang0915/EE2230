`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 20:37:34
// Design Name: 
// Module Name: key_valid
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


`define PRESS 1
`define RELEASE 0

module key_valid(
input key_valid,
input clk,
input rst,
output reg out
);
reg state, state_next;

always@*
    case(state)
        `PRESS: 
            if (key_valid == 1)
            begin
                state_next = `RELEASE;
                out = 0;
            end
            else
            begin
                state_next = `PRESS;
                out = 0;
            end
        `RELEASE:
            if (key_valid == 1)
            begin 
                state_next = `PRESS;
                out = 1;
            end
            else
            begin
                state_next = `RELEASE;
                out = 0;
            end
        default: state_next = `RELEASE;
    endcase
    
always@(posedge clk or posedge rst)
    if(rst) 
        state <= `RELEASE;
    else 
        state <= state_next;
endmodule