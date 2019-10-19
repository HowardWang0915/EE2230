`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/26 23:24:23
// Design Name: 
// Module Name: lab08_02
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


module lab08_02(
    clk,        // clock from crystal
    rst_n,      // active low reset
    audio_mclk, // master clock
    audio_lrck, // left-right clock
    audio_sck,  // serial clock
    audio_sdin, // serial audio data input
    indo,       // do
    inre,       // re
    inmi,       // mi
    inup,       // volume up
    indown,     // volume down
    lightctl_out,
    display
);
// I/O declaration
input clk;          // clock from the crystal
input rst_n;        // active low reset
input indo;         // input select do
input inre;         // input select re
input inmi;         // input select mi
input inup;
input indown;
output audio_mclk;  // master clock
output audio_lrck;  // left-right clock
output audio_sck;   // serial clock
output audio_sdin;  // serial audio data input
output [3:0]lightctl_out;
output [7:0]display;
// clock 100HZ
wire clk_100HZ;
wire [1:0]clk_ctl;
// debounce signal
wire debounced_do;
wire debounced_re;
wire debounced_mi;
wire debounced_up;
wire debounced_down;
// one pulse
wire one_pulse_up;
wire one_pulse_down;
// buzz control
wire [21:0]note_freq;
// volume set
wire [3:0]level;
// Declare internal nodes
wire [15:0] audio_in_left, audio_in_right;
// Hex to decimal display
wire [3:0]val0, val1;
// display
wire [3:0]intossd;

clk_100HZ U0_clk_100HZ(
    .clk(clk),
    .clk_out(clk_100HZ),
    .rst_n(rst_n),
    .clk_ctl(clk_ctl)
);
debounce U1_debounce_do(
    .clk(clk_100HZ),
    .rst_n(rst_n),
    .pb_in(indo),
    .pb_debounced(debounced_do)
);
debounce U1_debounce_re(
    .clk(clk_100HZ),
    .rst_n(rst_n),
    .pb_in(inre),
    .pb_debounced(debounced_re)
);
debounce U1_debounce_mi(
    .clk(clk_100HZ),
    .rst_n(rst_n),
    .pb_in(inmi),
    .pb_debounced(debounced_mi)
);
debounce U1_debounce_up(
    .clk(clk_100HZ),
    .rst_n(rst_n),
    .pb_in(inup),
    .pb_debounced(debounced_up)
);
debounce U1_debounce_down(
    .clk(clk_100HZ),
    .rst_n(rst_n),
    .pb_in(indown),
    .pb_debounced(debounced_down)
);
sound_sel U2_sound_sel(
    .indo(debounced_do),
    .inre(debounced_re),
    .inmi(debounced_mi),
    .out_sound(note_freq)
);
one_pulse U5_one_pulse_up(
    .clk(clk_100HZ),
    .rst_n(rst_n),
    .in_trig(debounced_up),
    .out_pulse(one_pulse_up)
);
one_pulse U5_one_pulse_down(
    .clk(clk_100HZ),
    .rst_n(rst_n),
    .in_trig(debounced_down),
    .out_pulse(one_pulse_down)
);

buzzer_control U3_buzz_ctl(
    .clk(clk), // clock from crystal
    .rst_n(rst_n), // active low reset
    .note_div(note_freq), // div for note generation
    .audio_left(audio_in_left), // left sound audio
    .audio_right(audio_in_right), // right sound audio
    .level(level)
);
speaker_control U4_speaker_ctl(
    .clk(clk),                          // clock from the crystal
    .rst_n(rst_n),                      // active low reset
    .audio_left(audio_in_left),      // left channel audio data input
    .audio_right(audio_in_right),    // right channel audio data input
    .audio_mclk(audio_mclk),            // master clock
    .audio_lrck(audio_lrck),            // left-right clock
    .audio_sck(audio_sck),              // serial clock
    .audio_sdin(audio_sdin)             // serial audio data input
);
level U5_level (
    .level(level), 
    .in_up(one_pulse_up), 
    .in_down(one_pulse_down),
    .clk(clk_100HZ), 
    .rst_n(rst_n)
);
Hex_to_dec U6_Hex_to_dec(
    .BCD1(val1),
    .BCD0(val0),
    .binary(level)
);
scan_ctl U7_scan_ctl(
    .in0(val0),
    .in1(val1),
    .in2(1'b0),
    .in3(1'b0),
    .intossd(intossd),
    .lightctl(lightctl_out),
    .sel(clk_ctl)
);
display U8_display(
    .i(intossd),
    .D(display)
);

endmodule
