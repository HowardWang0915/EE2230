`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/22 23:50:14
// Design Name: 
// Module Name: lab08_01
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


module lab08_01(
    clk,        // clock from crystal
    rst_n,      // active low reset
    audio_mclk, // master clock
    audio_lrck, // left-right clock
    audio_sck,  // serial clock
    audio_sdin  // serial audio data input
);
// I/O declaration
input clk;          // clock from the crystal
input rst_n;        // active low reset
output audio_mclk;  // master clock
output audio_lrck;  // left-right clock
output audio_sck;   // serial clock
output audio_sdin;  // serial audio data input

// Declare internal nodes
wire [15:0] audio_in_left, audio_in_right;
// Note generation
buzzer_control Ung(
    .clk(clk), // clock from crystal
    .rst_n(rst_n), // active low reset
    .note_div(22'd113636), // div for note generation
    .audio_left(audio_in_left), // left sound audio
    .audio_right(audio_in_right) // right sound audio
);
// Speaker controllor
speaker_control Usc(
    .clk(clk),                          // clock from the crystal
    .rst_n(rst_n),                      // active low reset
    .audio_left(audio_in_left),      // left channel audio data input
    .audio_right(audio_in_right),    // right channel audio data input
    .audio_mclk(audio_mclk),            // master clock
    .audio_lrck(audio_lrck),            // left-right clock
    .audio_sck(audio_sck),              // serial clock
    .audio_sdin(audio_sdin)             // serial audio data input
);
endmodule