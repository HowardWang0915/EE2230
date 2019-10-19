`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 22:07:07
// Design Name: 
// Module Name: lab06_01
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


module lab06_01(
    sec_sel,
    sel_12_24,
    clk,
    rst_n,
    display,
    lightctl_out,
    sel_clock   // for selecting clock to use
    );
    input clk;
    input rst_n;
    input sec_sel;
    input sel_12_24;
    input sel_clock;
    output [3:0]lightctl_out;
    output [7:0]display;

    wire [1:0]clk_ctl_1HZ;   // for scanning
    wire [1:0]clk_ctl_100HZ;    
    wire selected_clk;  
    wire [1:0]selected_clk_ctl;
    wire clk_1HZ;   // 1hz clock
    wire clk_100HZ; // 100hz clock
    wire debounced; // debounced input
    wire one_pulse; // one_pulse signal
    wire sel_display;   // display select for am/pm
    // for the output from the 12hr dct
    wire [3:0]val0_12, val1_12, val2_12, val3_12, val4_12, val5_12;
    // for the output from the 24hr dct
    wire [3:0]val0_24, val1_24, val2_24, val3_24, val4_24, val5_24;
    // scanctl
    wire [3:0]intossd_12_hm, intossd_12_s, intossd_24_hm, intossd_24_s;
    wire [3:0]lightctl_12_hm, lightctl_12_s, lightctl_24_hm,lightctl_24_s;
    wire [3:0]intossd_out;
    //display

    div_clock_1HZ U0_clk_1HZ(
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(clk_1HZ),
        .clk_ctl(clk_ctl_1HZ)
    );
    div_clock_100HZ U1_clk_100HZ(
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(clk_100HZ),
        .clk_ctl(clk_ctl_100HZ) 
    );

    debounce U2_debounce(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .pb_in(sel_12_24),
        .pb_debounced(debounced)
    );
    one_pulse U3_op(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .in_trig(debounced),
        .out_pulse(one_pulse)
    );
    fsm U4_fsm(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .in(one_pulse),
        .sel_display(sel_display)
    );
    uct_6d_12 U5_uct_6d_12(
        .clk(selected_clk),
        .rst_n(rst_n),
        .val0(val0_12),
        .val1(val1_12),
        .val2(val2_12),
        .val3(val3_12),
        .val4(val4_12),
        .val5(val5_12)
    );
    uct_6d_24 U5_uct_6d_24(
        .clk(selected_clk),
        .rst_n(rst_n),
        .val0(val0_24),
        .val1(val1_24),
        .val2(val2_24),
        .val3(val3_24),
        .val4(val4_24),
        .val5(val5_24)
    );

    scan_ctl_hour_min U6_scanctl_12hm(
        .sel(selected_clk_ctl),
        .intossd(intossd_12_hm),
        .lightctl(lightctl_12_hm),
        .in0(val2_12),
        .in1(val3_12),
        .in2(val4_12),
        .in3(val5_12)
    );
    scan_ctl_sec U6_scanctl_12s(
        .sel(selected_clk_ctl),
        .intossd(intossd_12_s),
        .lightctl(lightctl_12_s),
        .in0(val0_12),
        .in1(val1_12)
    );

    scan_ctl_hour_min U6_scanctl_24hm(
        .sel(selected_clk_ctl),
        .intossd(intossd_24_hm),
        .lightctl(lightctl_24_hm),
        .in0(val2_24),
        .in1(val3_24),
        .in2(val4_24),
        .in3(val5_24)
    );

    scan_ctl_sec U6_scanctl_24s(
        .sel(selected_clk_ctl),
        .intossd(intossd_24_s),
        .lightctl(lightctl_24_s),
        .in0(val0_24),
        .in1(val1_24)
    );

    data_mux U7_mux(
        .sel_12_24(sel_display),
        .sel_hm_s(sec_sel),
        .intossd_12hm(intossd_12_hm),
        .intossd_12s(intossd_12_s),
        .intossd_24hm(intossd_24_hm),
        .intossd_24s(intossd_24_s),
        .lightctl_12hm(lightctl_12_hm),
        .lightctl_12s(lightctl_24_s),
        .lightctl_24hm(lightctl_24_hm),
        .lightctl_24s(lightctl_24_s),
        .intossd_out(intossd_out),
        .lightctl_out(lightctl_out)
    );

    display U8_display(
        .i(intossd_out),
        .D(display)
    );
    clock_sel U9_clk_sel(
        .clk_100HZ(clk_100HZ),
        .clk_1HZ(clk_1HZ),
        .sel_clock(sel_clock),
        .clk_ctl_1HZ(clk_ctl_1HZ),
        .clk_ctl_100HZ(clk_ctl_100HZ),
        .clk_out(selected_clk),
        .clk_ctl_out(selected_clk_ctl)
    );
endmodule
