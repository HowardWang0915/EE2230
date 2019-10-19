`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/24 21:42:56
// Design Name: 
// Module Name: lab08_01_test
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


module lab08_01_test;
    reg clk;          // clock from the crystal
    reg rst_n;        // active low reset
    wire audio_mclk;  // master clock
    wire audio_lrck;  // left-right clock
    wire audio_sck;   // serial clock
    wire audio_sdin;  // serial audio data input      

    lab08_01 Uut(
        .clk(clk),
        .rst_n(rst_n),
        .audio_mclk(audio_mclk),
        .audio_lrck(audio_lrck),
        .audio_sck(audio_sck),
        .audio_sdin(audio_sdin)
    );
    initial 
    begin
        clk = 0;
        forever #2 clk = ~clk;
    end 
    initial
    begin
        rst_n = 0;
        #5 rst_n = 1;
    end

endmodule
