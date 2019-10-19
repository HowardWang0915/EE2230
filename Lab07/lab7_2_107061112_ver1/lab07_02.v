`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/19 07:55:26
// Design Name: 
// Module Name: lab07_02
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


module lab07_02(
    clk,
    rst_n,
    display,
    lightctl_out,
    in_stop,
    in_pause,
    in_min,
    in_sec,
    in_set,
    led
    );

    input in_stop;
    input in_pause;
    input in_min;
    input in_sec;
    input in_set;
    input clk;
    input rst_n;

    output [7:0]display;
    output [3:0]lightctl_out;
    output [15:0]led;
    // clock
    wire [1:0]clk_ctl;
    wire clk_100HZ;
    wire clk_1HZ;
    // debounce
    wire debounced_rst_n;
    wire debounced_in_stop_min;
    wire debounced_in_pause_sec;
    wire debounced_in_min;
    wire debounced_in_sec;
    // one pulse
    wire one_pulse_rst_n;
    wire one_pulse_in_stop_min;
    wire one_pulse_in_pause_sec;
    wire one_pulse_in_min;
    wire one_pulse_in_sec;
    // fsm
    wire decrease_en;
    wire stop;
    wire setting;
    // counters and initial values
    wire [3:0]val0, val1, val2, val3;
    wire [3:0]init0, init1, init2, init3;
    wire [3:0]out0, out1, out2, out3;
    wire [3:0]intossd;
    wire stop1;

    clk_1HZ U0_clk_1HZ(
        .clk(clk),
        .rst_n(~one_pulse_rst_n),
        .clk_out(clk_1HZ),
        .clk_ctl(clk_ctl)
    );

    clk_100HZ U0_clk_100HZ(
        .clk(clk),
        .rst_n(~one_pulse_rst_n),
        .clk_out(clk_100HZ)
    );

    debounce U1_debounce_rst_n(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .pb_in(rst_n),
        .pb_debounced(debounced_rst_n)
    );

    debounce U1_debounce_in_stop_min(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .pb_in(in_stop),
        .pb_debounced(debounced_in_stop_min)
    );
    debounce U1_debounce_in_pause_sec(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .pb_in(in_pause),
        .pb_debounced(debounced_in_pause_sec)
    );
    debounce U1_debounce_in_sec(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .pb_in(in_sec),
        .pb_debounced(debounced_in_sec)
    );
    debounce U2_debounce_in_min(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .pb_in(in_min),
        .pb_debounced(debounced_in_min)
    );
    one_pulse U2_one_pulse_rst_n(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .in_trig(debounced_rst_n),
        .out_pulse(one_pulse_rst_n)
    );
    one_pulse U2_one_pulse_in_stop_min(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .in_trig(debounced_in_stop_min),
        .out_pulse(one_pulse_in_stop_min)
    );
    one_pulse U2_one_pulse_in_pause_sec(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .in_trig(debounced_in_pause_sec),
        .out_pulse(one_pulse_in_pause_sec)
    );
    one_pulse U2_one_pulse_in_min(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .in_trig(debounced_in_min),
        .out_pulse(one_pulse_in_min)
    );
    one_pulse U2_one_pulse_in_sec(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .in_trig(debounced_in_sec),
        .out_pulse(one_pulse_in_sec)
    );
    FSM_7_2 U4_fsm(
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n),
        .hour_set(in_set),
        .set(set),
        .pb_stop(one_pulse_in_stop_min),
        .pb_pause(one_pulse_in_pause_sec),
        .count_enable(decrease_en),
        .stop(stop)
    );
    assign setting = set | stop;

    dct_4d U5_dct_4d(
        .clk(clk_1HZ),
        .rst_n(~setting),
        .en(decrease_en),
        .val0(val0),
        .val1(val1),
        .val2(val2),
        .val3(val3),
        .init_val0(init0),
        .init_val1(init1),
        .init_val2(init2),
        .init_val3(init3),
        .stop(stop1)
    );
    uct_min U6_uct_min(
        .val2(init2),
        .val3(init3),
        .count_en(1'b1),
        .clk(one_pulse_in_min),
        .rst_n(~one_pulse_rst_n)
    );
    uct_sec U7_uct_sec(
        .val0(init0),
        .val1(init1),
        .count_en(one_pulse_in_sec),
        .clk(clk_100HZ),
        .rst_n(~one_pulse_rst_n)
    );
    uct_dct_display_sel U8_dis_sel(
        .in0dct(val0),
        .in1dct(val1),
        .in2dct(val2),
        .in3dct(val3),
        .in0uct(init0),
        .in1uct(init1),
        .in2uct(init2),
        .in3uct(init3),
        .out0(out0),
        .out1(out1),
        .out2(out2),
        .out3(out3),
        .set(in_set)
    );
    scan_ctl U9_scan_ctl(
        .in0(out0),
        .in1(out1),
        .in2(out2),
        .in3(out3),
        .intossd(intossd),
        .lightctl(lightctl_out),
        .sel(clk_ctl)
    );
    display U10_display(
        .i(intossd),
        .D(display)
    );
    LED U11_LED(
        .stop(stop1),
        .display(led)
    );
endmodule
