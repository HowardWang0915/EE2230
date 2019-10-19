`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/09 23:10:48
// Design Name: 
// Module Name: lab09_01
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


module lab09_01(
    PS2_DATA,
    PS2_CLK,
    rst,
    clk,
    lightctl_out,
    display
    );
    inout PS2_DATA, PS2_CLK;    // keyboard datas
    input rst;                  // high active reset
    input clk;                  // crystal clock

    output [3:0]lightctl_out;
    output [7:0]display;

    wire [8:0]last_change;
    wire [511:0]key_down;
    wire key_valid;
    wire [3:0]conv_out;         // converted hexadecimal last change to decimal
    wire [1:0]clk_ctl;          // for display
    // seven segment display
    wire [3:0]intossd;
    KeyboardDecoder U0_kd(
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk),
        .last_change(last_change),
        .key_down(key_down),
        .key_valid
    );
    freq_div U1_fd(
        .clk(clk),
        .rst_n(rst),
        .clk_ctl(clk_ctl)
    );
    last_change U2_last(
        .last_change(last_change),
        .out(conv_out)
    );
    scan_ctl U3_scan_ctl(
        .in0(conv_out),
        .in1(4'b0),
        .in2(4'b0),
        .in3(4'b0),
        .intossd(intossd),
        .lightctl(lightctl_out),
        .sel(clk_ctl)
    );
    display U4_display(
        .i(intossd),
        .D(display)
    );

endmodule
