`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 20:37:34
// Design Name: 
// Module Name: lab09_04
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


module lab09_04(
    PS2_DATA,
    PS2_CLK,
    rst,
    clk,
    lightctl_out,
    display,
    caps_out,
    ASCII
    );
    inout PS2_DATA, PS2_CLK;    // keyboard datas
    input rst;                  // high active reset
    input clk;                  // crystal clock

    output [3:0]lightctl_out;
    output [7:0]display;
    output caps_out;
    output wire [6:0]ASCII;
    wire [8:0]last_change;
    wire [511:0]key_down;
    wire key_valid;
    wire caps;                   // caps lock indicator
    wire [1:0]clk_ctl;          // for display
    wire key_release;
    // adder
    // convert binary sum to decimal sum
    wire [3:0]bcd0, bcd1, bcd2, bcd3;
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
    freq_div U1_fd(
        .clk(clk),
        .rst_n(rst),
        .clk_ctl(clk_ctl),
        .clk_out(clk_100HZ)
    );
    FSM U2_fsm(
        .clk(clk),
        .rst(rst),
        .caps(caps),
        .last_change(last_change),
        .key_valid(key_release)
    );
    ASCII_decoder U3_Ud(
        .clk(clk),
        .rst(rst),
        .ASCII(ASCII),
        .key_down(key_down),
        .last_change(last_change),
        .caps(caps),
        .caps_out(caps_out)
    );
    bin_to_dec U3_btd(
        .ans(ASCII),
        .BCD0(bcd0),
        .BCD1(bcd1),
        .BCD2(bcd2),
        .BCD3(bcd3)
    );
    scan_ctl U4_scan_ctl(
        .in0(bcd0),
        .in1(bcd1),
        .in2(bcd2),
        .in3(bcd3),
        .intossd(intossd),
        .lightctl(lightctl_out),
        .sel(clk_ctl)
    );
    display U5_display(
        .i(intossd),
        .D(display)
    );
    key_valid U7_kv(
        .key_valid(key_valid),
        .clk(clk),
        .rst(rst),
        .out(key_release)
    );
endmodule