`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/24 22:26:41
// Design Name: 
// Module Name: buzzer_control
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


module buzzer_control(
    clk, // clock from crystal
    rst_n, // active low reset
    note_div, // div for note generation
    audio_left, // left sound audio
    audio_right, // right sound audio
    level           // volume level
);
// I/O declaration
input clk; // clock from crystal
input rst_n; // active low reset
input [21:0] note_div; // div for note generation
input [3:0]level;

output reg [15:0]audio_left; // left sound audio
output reg [15:0]audio_right; // right sound audio

// Declare internal signals
reg [21:0]clk_cnt_next, clk_cnt;
reg b_clk, b_clk_next;
// Note frequency generation
always @(posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        clk_cnt <= 22'd0;
        b_clk <= 1'b0;
    end
    else
    begin
        clk_cnt <= clk_cnt_next;
        b_clk <= b_clk_next;
    end
always @*
    if (clk_cnt == note_div)
    begin
        clk_cnt_next = 22'd0;
        b_clk_next = ~b_clk;
    end
    else
    begin
        clk_cnt_next = clk_cnt + 1'b1;
        b_clk_next = b_clk;
    end
/*
assign audio_left = (b_clk == 1'b0) ? 16'h0000 - (level * 16'h0060): 16'h0000 + (level * 16'h0060);
assign audio_right = (b_clk == 1'b0) ? 16'h0000 - (level * 16'h0060): 16'h0000 + (level * 16'h0060); */
always @*
    case(level)
        4'd15:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h03C0: 16'h0000 + 16'h03C0;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h03C0: 16'h0000 + 16'h03C0;
        end
        4'd14:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0380: 16'h0000 + 16'h0380;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0380: 16'h0000 + 16'h0380;
        end 
        4'd13:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0340: 16'h0000 + 16'h0340;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0340: 16'h0000 + 16'h0340;
        end
        4'd12:begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0300: 16'h0000 + 16'h0300;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0300: 16'h0000 + 16'h0300;
        end
        4'd11:begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h02C0: 16'h0000 + 16'h02C0;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h02C0: 16'h0000 + 16'h02C0;
        end
        4'd10:begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0280: 16'h0000 + 16'h0280;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0280: 16'h0000 + 16'h0280;
        end
        4'd9:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0240: 16'h0000 + 16'h0240;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0240: 16'h0000 + 16'h0240;
        end
        4'd8:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0200: 16'h0000 + 16'h0200;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0200: 16'h0000 + 16'h0200;
        end
        4'd7:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h01C0: 16'h0000 + 16'h01C0;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h01C0: 16'h0000 + 16'h01C0;
        end
        4'd6:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0180: 16'h0000 + 16'h0180;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0180: 16'h0000 + 16'h0180;
        end
        4'd5:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0140: 16'h0000 + 16'h0140;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0140: 16'h0000 + 16'h0140;
        end
        4'd4:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0100: 16'h0000 + 16'h0100;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0100: 16'h0000 + 16'h00C0;
        end
        4'd3:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h00C0: 16'h0000 + 16'h00C0;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h00C0: 16'h0000 + 16'h00C0;
        end
        4'd2:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0080: 16'h0000 + 16'h0080;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0080: 16'h0000 + 16'h0080;
        end
        4'd1:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 - 16'h0040: 16'h0000 + 16'h0040;
            audio_right = (b_clk == 1'b0) ? 16'h0000 - 16'h0040: 16'h0000 + 16'h0040;     
        end                 
        4'd0:
        begin
            audio_left = (b_clk == 1'b0) ? 16'h0000 : 16'h0000;
            audio_right = (b_clk == 1'b0) ? 16'h0000 : 16'h0000;                               
        end
        endcase 
endmodule
