`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 22:20:39
// Design Name: 
// Module Name: lab07_01
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


module lab07_01(
    clk,
    rst_n,
    display, 
    lightctl_out,
    lap,
    start_pause
    );

    input clk;
    input rst_n;
    input lap;  // lap signal input
    input start_pause;

    output [7:0]display;
    output [3:0]lightctl_out;

    wire [1:0]clk_ctl;
    wire clk_1HZ;
    wire clk_100HZ;
    // debounce
    wire debounced_rst_n;
    wire debounced_lap;
    wire debounced_start_pause;
    // one pulse
    wire one_pulse_rst_n;
    wire one_pulse_lap;
    wire one_pulse_start_pause;
    // fsm
    wire rst_n_out;
    wire count_en;
    wire lap_out;
    // for the up counter
    wire [3:0]val0, val1, val2, val3;
    // lap
    wire [3:0]lap_out0, lap_out1, lap_out2, lap_out3;
    // scan ctl
    wire [3:0]intossd;

    clk_1HZ U0_clk_1HZ(
        .clk(clk),
        .rst_n(rst_n_out),
        .clk_out(clk_1HZ),
        .clk_ctl(clk_ctl)
    );

    clk_100HZ U0_clk_100HZ(
        .clk(clk),
        .rst_n(rst_n_out),
        .clk_out(clk_100HZ)
    );

    debounce U1_debounce_rst_n(
        .clk(clk_100HZ),
        .rst_n(rst_n_out),
        .pb_in(rst_n),
        .pb_debounced(debounced_rst_n)
    );
    debounce U1_debounce_lap(
        .clk(clk_100HZ),
        .rst_n(rst_n_out),
        .pb_in(lap),
        .pb_debounced(debounced_lap)
    );
    debounce U1_debounce_start_pause(
        .clk(clk_100HZ),
        .rst_n(rst_n_out),
        .pb_in(start_pause),
        .pb_debounced(debounced_start_pause)
    );

    one_pulse U2_one_pulse_rst_n(
        .clk(clk_100HZ),
        .rst_n(rst_n_out),
        .in_trig(debounced_rst_n),
        .out_pulse(one_pulse_rst_n)
    );
    one_pulse U2_one_pulse_lap(
        .clk(clk_100HZ),
        .rst_n(rst_n_out),
        .in_trig(debounced_lap),
        .out_pulse(one_pulse_lap)
    );
    one_pulse U2_one_pulse_start_pause(
        .clk(clk_100HZ),
        .rst_n(rst_n_out),
        .in_trig(debounced_start_pause),
        .out_pulse(one_pulse_start_pause)
    );

    fsm U3_fsm(
        .clk(clk_100HZ),
        .rst_n(rst_n_out),
        .in({one_pulse_lap, one_pulse_start_pause, one_pulse_rst_n}),
        .count_en(count_en),
        .lap(lap_out),
        .reset_out(rst_n_out)
    );

    uct_mmss U4_uct(
        .clk(clk_1HZ),
        .rst_n(rst_n_out),
        .count_en(count_en),
        .val0(val0),
        .val1(val1),
        .val2(val2),
        .val3(val3)
    );
    lap U5_lap(
        .clk(clk_100HZ),
        .rst_n(rst_n_out),
        .enable(lap_out),
        .val0(val0),
        .val1(val1),
        .val2(val2),
        .val3(val3),
        .out0(lap_out0),
        .out1(lap_out1),
        .out2(lap_out2),
        .out3(lap_out3)
    );
    scan_ctl U6_scan_ctl(
        .sel(clk_ctl),
        .intossd(intossd),
        .lightctl(lightctl_out),
        .in0(lap_out0),
        .in1(lap_out1),
        .in2(lap_out2),
        .in3(lap_out3)
    );
    display U7(
        .i(intossd),
        .D(display)
    );
endmodule
