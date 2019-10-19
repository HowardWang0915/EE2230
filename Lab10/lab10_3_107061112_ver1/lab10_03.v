`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 20:26:03
// Design Name: 
// Module Name: lab10_03
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


module lab10_03(
    PS2_DATA,
    PS2_CLK,
    clk,
    rst,
    audio_mclk, // master clock
    audio_lrck, // left-right clock
    audio_sck,  // serial clock
    audio_sdin, // serial audio data input
    dip,
    lightctl_out,
    display
    );
    inout PS2_DATA, PS2_CLK;    // keyboard datas
    input rst;                  // high active reset
    input clk;                  // crystal clock
    input dip;
    // ssd
    output [3:0]lightctl_out;
    output [7:0]display;
    // speaker
    output audio_mclk;  // master clock
    output audio_lrck;  // left-right clock
    output audio_sck;   // serial clock
    output audio_sdin;  // serial audio data input
    // keyboard
    wire [8:0]last_change;
    wire [511:0]key_down;
    wire key_valid;
    wire key_release;
    wire caps;                   // caps lock indicator
    wire [1:0]clk_ctl;          // for display
    // sound selecting
    // Declare internal nodes
    wire [15:0]audio_in_left, audio_in_right;
    wire [21:0]note_left, note_right;
    wire [3:0]note_out;
    // seven segment display
    wire [3:0]intossd;
    KeyboardDecoder U0_kd(
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk),
        .last_change(last_change),
        .key_down(key_down),
        .key_valid(key_valid)
    );
    buzzer_Ctrl U2_bc_left(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_left), // div for note generation
        .audio(audio_in_left) // left sound audio
    );
    // Speak
    buzzer_Ctrl U2_bc_right(
        .clk(clk), // clock from crystal
        .rst_n(rst), // active low reset
        .note_div(note_right), // div for note generation
        .audio(audio_in_right) // right sound audio
    );
    // Speaker controllor
    freq_div U1_fd(
        .clk(clk),
        .rst_n(rst),
        .clk_ctl(clk_ctl)
    );
    speaker_Ctrl U3_sc(
        .clk(clk),                          // clock from the crystal
        .rst_n(rst),                      // active low reset
        .audio_left(audio_in_left),      // left channel audio data input
        .audio_right(audio_in_right),    // right channel audio data input
        .audio_mclk(audio_mclk),            // master clock
        .audio_lrck(audio_lrck),            // left-right clock
        .audio_sck(audio_sck),              // serial clock
        .audio_sdin(audio_sdin)             // serial audio data input
    );
    Key_Valid U4_kv(
        .key_valid(key_valid),
        .clk(clk),
        .rst(rst),
        .out(key_release)
    );
    Caps_FSM U5_fsm(
        .clk(clk),
        .rst(rst),
        .caps(caps),
        .last_change(last_change),
        .key_valid(key_release)
    );
    Sound_sel U6_ss(
        .clk(clk),
        .rst(rst),
        .key_down(key_down),
        .last_change(last_change),
        .caps(caps),
        .note_left(note_left),
        .note_right(note_right),
        .dip(dip)
    );
    display_sel U7_ds(
        .note(note_right),
        .note_out(note_out)
    );
    scan_ctl U8_scan_ctl(
        .in0(note_out),
        .in1(4'b0),
        .in2(4'b0),
        .in3(4'b0),
        .intossd(intossd),
        .lightctl(lightctl_out),
        .sel(clk_ctl)
    );
    display U9_display(
        .i(intossd),
        .D(display)
    );
endmodule
