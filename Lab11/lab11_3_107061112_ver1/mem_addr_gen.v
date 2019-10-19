`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/01 21:38:41
// Design Name: 
// Module Name: mem_addr_gen
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


module mem_addr_gen(
    random,
    h_cnt,
    v_cnt,
    clk,
    rst,
    pixel_addr,
    position
    );
    input clk;
    input rst;
    input [2:0]random;
    input [9:0]v_cnt, h_cnt;
    output reg [16:0]pixel_addr;
    output reg [8:0]position; 
    reg [8:0]position_next;
    
    always @*
        if (random == 3'b0)     // I-block
        begin
            if ((h_cnt <= 304 || h_cnt >= 336) || (v_cnt >= position + 128 || v_cnt <= position))
                pixel_addr = 17'b0;
            else
                pixel_addr = (v_cnt - position) * 416 + h_cnt - 304;
        end
        else if (random == 3'd1)    // j-block
        begin
            if ((h_cnt >= 288 && h_cnt <= 320 && v_cnt <= position + 64 && v_cnt >= position) || 
                (h_cnt <= 288 || h_cnt >= 352 || v_cnt >= position + 96 || v_cnt <= position))
                pixel_addr = 17'b0;
            else    
                pixel_addr = (v_cnt - position) * 416 + h_cnt - 256;
        end
        else if (random == 3'd2)    // l-block
        begin
            if ((h_cnt >= 320 && h_cnt <= 352 && v_cnt <= position + 64 && v_cnt >= position) ||
                (h_cnt <= 288 || h_cnt >= 352 || v_cnt >= position + 96 || v_cnt <= position))
                pixel_addr = 17'b0;
            else
                pixel_addr = (v_cnt - position) * 416 + h_cnt - 192;
        end
        else if (random == 3'd3)    // O-block
        begin
            if (h_cnt <= 288 || h_cnt >= 352 || v_cnt >= position + 64 || v_cnt <= position)
                pixel_addr = 17'b0;
            else
                pixel_addr = (v_cnt - position) * 416 + h_cnt - 128;
        end
        else if (random == 3'd4)    // Z-block
        begin
            if ((h_cnt >= 288 && h_cnt <= 320 && v_cnt <= position + 32 && v_cnt >= position) ||
                (h_cnt >= 320 && h_cnt <= 352 && v_cnt <= position + 96 && v_cnt >= position + 64) ||
                (h_cnt <= 288 || h_cnt >= 352 || v_cnt >= position + 96 || v_cnt <= position))
                pixel_addr = 17'b0;
            else
                pixel_addr = (v_cnt - position) * 416 + h_cnt - 64;
        end
        else if (random == 3'd5)    // T-block
        begin
            if ((h_cnt >= 288 && h_cnt <= 320 && v_cnt <= position + 32 && v_cnt >= position) ||
                (h_cnt >= 288 && h_cnt <= 320 && v_cnt <= position + 96 && v_cnt >= position + 64) ||
                (h_cnt <= 288 || h_cnt >= 352 || v_cnt >= position + 96 || v_cnt <= position))
                pixel_addr = 17'b0;
            else
                pixel_addr = (v_cnt - position) * 416 + h_cnt;
        end
        else if (random == 3'd6)
         begin
            if ((h_cnt >= 288 && h_cnt <= 320 && v_cnt <= position + 32 && v_cnt >= position) ||
                (h_cnt >= 320 && h_cnt <= 352 && v_cnt <= position + 96 && v_cnt >= position + 64) ||
                (h_cnt <= 288 || h_cnt >= 352 || v_cnt >= position + 96 || v_cnt <= position))
                pixel_addr = 17'b0;
            else
                pixel_addr = (v_cnt - position) * 416 + h_cnt + 64;
            end
        else
            begin
            if ((h_cnt <= 304 || h_cnt >= 336) || (v_cnt >= position + 128 || v_cnt <= position))
                pixel_addr = 17'b0;
            else
                pixel_addr = (v_cnt - position) * 416 + h_cnt - 304;
        end
        

    always @*
        if (position < 480)
            position_next = position + 32;
        else
            position_next = 0;
    always @(posedge clk or posedge rst)
	    if (rst)
		    position <= 8'b0;
	    else 
            position <= position_next;
    

endmodule
