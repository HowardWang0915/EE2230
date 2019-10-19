`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 21:03:48
// Design Name: 
// Module Name: lab06_03
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


module lab06_03(
    clk,    // crystal clock
    rst_n,  // low active reset
    display,    
    lightctl_out,   
    sel_mmdd_time,  // select time mode or mmdd mode
    sel_mode,   // in time mode-> select 12/24, mmdd mode -> yy or mmdd
    sel_12_24,
    sel_clock
    );
    input clk;
    input rst_n;
    input sel_mmdd_time;
    input sel_mode;
    input sel_12_24;
    input sel_clock;    // select which clock
    output [3:0]lightctl_out;
    output [7:0]display;

    wire [1:0]clk_ctl;  // for scanning
    wire clk_1HZ;       // 1HZ clock
    wire clk_100HZ;     // 100HZ clock
    wire debounced_sel_mmdd_time;
    wire debounced_sel_mode;
    wire debounced_sel_12_24;
    wire one_pulse_sel_mmdd_time;
    wire one_pulse_sel_mode;
    wire one_pule_sel_12_24;
    // for selecting clock
    wire [1:0]clk_ctl_1HZ;
    wire [1:0]clk_ctl_100HZ;
    wire selected_clk;
    wire [1:0]selected_clk_ctl;
    // for counter
    wire leap_year;     // leap_year signal wire
    wire [2:0]counter_sel;   // output for mux data select
    // for the month date up counter
    wire [3:0]val0_mmdd, val1_mmdd, val2_mmdd, val3_mmdd;
    wire car_mmdd;
    // for the output from the 12hr uct
    wire [3:0]val0_12, val1_12, val2_12, val3_12, val4_12, val5_12;
    // for the output from the 24hr uct
    wire [3:0]val0_24, val1_24, val2_24, val3_24, val4_24, val5_24;
    wire car_24;
    // for the year uct
    wire [3:0]val0_yyyy, val1_yyyy, val2_yyyy, val3_yyyy;
    wire car_yyyy;
    // scanctl
    wire [3:0]intossd_12hm, intossd_12s, intossd_24hm, intossd_24s;
    wire [3:0]intossd_mmdd, intossd_yyyy;
    wire [3:0]intossd_out;

    wire [3:0]lightctl_12hm, lightctl_12s, lightctl_24hm, lightctl_24s;
    wire [3:0]lightctl_mmdd, lightctl_yyyy;
    wire [3:0]lightctl_out;

    clk_1HZ U0_clk_1HZ(
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(clk_1HZ),
        .clk_ctl(clk_ctl_1HZ)
    );
    clk_100HZ U1_clk_100HZ(
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(clk_100HZ),
        .clk_ctl(clk_ctl_100HZ)
    );
    debounce U2_debounce_mmdd_time(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .pb_in(sel_mmdd_time),
        .pb_debounced(debounced_sel_mmdd_time)
    );
    debounce U2_debounce_sel_mode(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .pb_in(sel_mode),
        .pb_debounced(debounced_sel_mode)
    );    
    debounce U2_debounce_sel_12_24(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .pb_in(sel_12_24),
        .pb_debounced(debounced_sel_12_24)
    );
    one_pulse U3_one_pulse_mmdd_time(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .in_trig(debounced_sel_mmdd_time),
        .out_pulse(one_pulse_sel_mmdd_time)
    );
    one_pulse U3_one_pulse_sel_mode(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .in_trig(debounced_sel_mode),
        .out_pulse(one_pulse_sel_mode)
    );
    one_pulse U3_one_pulse_sel_12_24(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .in_trig(debounced_sel_12_24),
        .out_pulse(one_pulse_sel_12_24)
    );
    fsm U4_fsm(
        .clk(clk_100HZ),
        .rst_n(rst_n),
        .in({one_pulse_sel_mmdd_time, one_pulse_sel_12_24, one_pulse_sel_mode}),
        .counter_sel(counter_sel)
    );
    uct_12 U5_uct_12(
        .clk(selected_clk),
        .rst_n(rst_n),
        .val0(val0_12),
        .val1(val1_12),
        .val2(val2_12),
        .val3(val3_12),
        .val4(val4_12),
        .val5(val5_12)
    );
    uct_24 U5_uct_24(
        .clk(selected_clk),
        .rst_n(rst_n),
        .val0(val0_24),
        .val1(val1_24),
        .val2(val2_24),
        .val3(val3_24),
        .val4(val4_24),
        .val5(val5_24),    
        .car5(car_24)  
    );
    uct_mmdd U5_uct_mmdd(
        .clk(selected_clk),
        .rst_n(rst_n),
        .leap_year(leap_year),
        .val0(val0_mmdd),
        .val1(val1_mmdd),
        .val2(val2_mmdd),
        .val3(val3_mmdd), 
        .car3(car_mmdd),
        .increase(car_24)      
    );
    uct_year U5_uct_year(
        .clk(selected_clk),
        .rst_n(rst_n),
        .val0(val0_yyyy),
        .val1(val1_yyyy),
        .val2(val2_yyyy),
        .val3(val3_yyyy),  
        .increase(car_mmdd)      
    );
    leap_year leap_year(
        .val0(val0_yyyy),
        .val1(val1_yyyy),
        .val2(val2_yyyy),
        .val3(val3_yyyy),
        .leap_year(leap_year)
    );
    scan_ctl U6_scan_ctl_12hm(
        .sel(clk_ctl_100HZ),
        .intossd(intossd_12hm),
        .lightctl(lightctl_12hm),
        .in0(val2_12),
        .in1(val3_12),
        .in2(val4_12),
        .in3(val5_12)
    );
    scan_ctl_sec U6_scan_ctl_12s(
        .sel(clk_ctl_100HZ),
        .intossd(intossd_12s),
        .lightctl(lightctl_12s),
        .in0(val0_12),
        .in1(val1_12)
    );
    scan_ctl U6_scan_ctl_24hm(
        .sel(clk_ctl_100HZ),
        .intossd(intossd_24hm),
        .lightctl(lightctl_24hm),
        .in0(val2_24),
        .in1(val3_24),
        .in2(val4_24),
        .in3(val5_24)
    );
    scan_ctl_sec U6_scan_ctl_24s(
        .sel(clk_ctl_100HZ),
        .intossd(intossd_24s),
        .lightctl(lightctl_24s),
        .in0(val0_24),
        .in1(val1_24)
    ); 
    scan_ctl U6_scan_ctl_mmdd(
        .sel(clk_ctl_100HZ),
        .intossd(intossd_mmdd),
        .lightctl(lightctl_mmdd),
        .in0(val0_mmdd),
        .in1(val1_mmdd),
        .in2(val2_mmdd),
        .in3(val3_mmdd)
    );
    scan_ctl U6_scan_ctl_yyyy(
        .sel(clk_ctl_100HZ),
        .intossd(intossd_yyyy),
        .lightctl(lightctl_yyyy),
        .in0(val0_yyyy),
        .in1(val1_yyyy),
        .in2(val2_yyyy),
        .in3(val3_yyyy)
    );
    data_mux U7_data_mux(
        .counter_sel(counter_sel),
        .intossd_12hm(intossd_12hm),
        .intossd_12s(intossd_12s),
        .intossd_24hm(intossd_24hm),
        .intossd_24s(intossd_24s),
        .intossd_mmdd(intossd_mmdd),
        .intossd_yyyy(intossd_yyyy),
        .intossd_out(intossd_out),
        .lightctl_12hm(lightctl_12hm),
        .lightctl_12s(lightctl_12s),
        .lightctl_24hm(lightctl_24hm),
        .lightctl_24s(lightctl_24s),
        .lightctl_mmdd(lightctl_mmdd),
        .lightctl_yyyy(lightctl_yyyy), 
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
