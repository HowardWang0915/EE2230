`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/29 21:50:25
// Design Name: 
// Module Name: lab05_03
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


module lab05_03(
    in_trig,    // input trigger
    clk,    // Crystal clock
    led,    // led display
    display, // ssd
    lightctl_out,
    rst_n,
    mode_trig
    );

    input in_trig;  // start pause select
    input mode_trig;    // 30 60 select input
    input clk;
    input rst_n;    // low active reset

    output [15:0]led;
    output [7:0]display;
    output [3:0]lightctl_out;
    
    
    wire clk_out_1HZ;   // for generating the 1HZ clock
    wire clk_out_100HZ; // for generating the 100HZ clock 
    wire [1:0]clk_ctl;   // for scanning
    // debounce signal
    wire debounced_in;  // input signal after debouncing
    wire debounced_mode;    // mode signal after debouncing
    // onepulse
    wire out_pulse_in;     // one pulse output start pause
    wire out_pulse_mode;    // one pulse mode select
    wire one_pulse_rst;     // from long press reset
    // from the fsm
    wire count_enable;  // fsm to the counter
    wire counter_sel;   // select counter
    wire rst_en;        // reset for the counter
    // counters
    wire rst_2d;
    wire rst_3d;
    wire count_en_2d;
    wire count_en_3d;
    wire [3:0]val0_2d;   // output of counter
    wire [3:0]val1_2d;   // output of counter
    wire [3:0]val0_3d;
    wire [3:0]val1_3d;
    wire [3:0]val2_3d;
    wire stop_2d;       // stop signal from counter
    wire stop_3d;
    wire [3:0]intossd_2d;   // display number
    wire [3:0]intossd_3d;
    wire [3:0]lightctl_2d;
    wire [3:0]lightctl_3d;
    // mux
    wire [3:0]intossd_out;

    div_clock_1HZ U0(
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(clk_out_1HZ),
        .clk_ctl(clk_ctl)
    );

    div_clock_100HZ U1(
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(clk_out_100HZ)
    );
    debounce U2_mode_select(
        .pb_in(mode_trig),
        .clk(clk_out_100HZ),
        .rst_n(rst_n),
        .pb_debounced(debounced_mode)
    );
    debounce U2_start_pause(
        .pb_in(in_trig),
        .clk(clk_out_100HZ),
        .rst_n(rst_n),
        .pb_debounced(debounced_in)
    );
    long_press_rst U3lprst(
        .clk(clk_out_100HZ),
        .rst_n(rst_n),
        .in(debounced_in),
        .rst(one_pulse_rst)
    );
    one_pulse U4_start_pause(
        .clk(clk_out_100HZ),
        .rst_n(rst_n),
        .in_trig(debounced_in),
        .out_pulse(out_pulse_in)  
    );
    one_pulse U4_mode(
        .clk(clk_out_100HZ),
        .rst_n(rst_n),
        .in_trig(debounced_mode),
        .out_pulse(out_pulse_mode)
    );
    fsm U5(
        .long_press_rst(one_pulse_rst),
        .count_enable(count_enable),
        .counter_sel(counter_sel),
        .clk(clk_out_100HZ),
        .rst_n(rst_n),
        .in({out_pulse_mode, out_pulse_in}),
        .reset(rst_en)
    );
    counter_sel U6(
        .count_enable(count_enable),
        .counter_sel(counter_sel),
        .reset_en(rst_en),
        .count_enable_assign_2d(count_en_2d),
        .count_enable_assign_3d(count_en_3d),
        .reset_assign_2d(rst_2d),
        .reset_assign_3d(rst_3d)
    );
    dct_2d U7_cnt2d(
        .clk(clk_out_1HZ),
        .stop(stop_2d),
        .rst_n(rst_2d),
        .en(count_en_2d),
        .val0(val0_2d),
        .val1(val1_2d)
    );
    dct_3d U7_cnt3d(
        .clk(clk_out_1HZ),
        .stop(stop_3d),
        .rst_n(rst_3d),
        .en(count_en_3d),
        .val0(val0_3d),
        .val1(val1_3d),
        .val2(val2_3d)
    );
    scan_ctl_2d U82d(
        .sel(clk_ctl),
        .in0(val0_2d),
        .in1(val1_2d),
        .intossd(intossd_2d),
        .lightctl(lightctl_2d)
    );
    scan_ctl_3d U83d(
        .sel(clk_ctl),
        .in0(val0_3d),
        .in1(val1_3d),
        .in2(val2_3d),
        .intossd(intossd_3d),
        .lightctl(lightctl_3d)
    );
    counter_data_mux U9(
        .counter_sel(counter_sel),
        .intossd_2d(intossd_2d),
        .intossd_3d(intossd_3d),
        .lightctl_2d(lightctl_2d),
        .lightctl_3d(lightctl_3d),
        .stop_2d(stop_2d),
        .stop_3d(stop_3d),
        .intossd_out(intossd_out),
        .light_ctl_out(lightctl_out),
        .stop_out(stop_out)
    );
    LED U10(
        .stop(stop_out),
        .display(led)
    );
    display U11(
        .i(intossd_out),
        .D(display)
    );

endmodule
