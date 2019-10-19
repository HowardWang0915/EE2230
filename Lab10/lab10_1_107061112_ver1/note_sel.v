`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/20 11:42:09
// Design Name: 
// Module Name: note_sel
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


module note_sel(
    clk,
    rst_n,
    note
    );
    input clk;
    input rst_n;

    output reg [21:0]note;
    reg [4:0]cnt, cnt_next;


    always @*
        case (cnt)
            4'd0: note = 22'd0;
            4'd1: note = 22'd383141;
            4'd2: note = 22'd341296;
            4'd3: note = 22'd303030;
            4'd4: note = 22'd286532;
            4'd5: note = 22'd255102;
            4'd6: note = 22'd227272;
            4'd7: note = 22'd202492;
            4'd8: note = 22'd190839;
            4'd9: note = 22'd170068;
            4'd10:note = 22'd151515;
            4'd11:note = 22'd143266;
            4'd12:note = 22'd127551;
            4'd13:note = 22'd113636;
            4'd14:note = 22'd101214;
            default: note = 22'd0;
        endcase
    always @*
        if (cnt < 14)
            cnt_next = cnt + 1;
        else
            cnt_next = 4'd1;
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            cnt <= 4'd0;
        else
            cnt <= cnt_next;
endmodule
