`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 16:40:42
// Design Name: 
// Module Name: lab06_02
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


module lab06_02(
    sel_yy_mmdd,
    clk,
    rst_n,
    display,
    lightctl_out,
    sel_clock
    );
    input clk;
    input rst_n;
    input sel_yy_mmdd;
    input sel_clock;
    output [3:0]lightctl_out;
    output [7:0]display;

    wire [1:0]clk_ctl_1HZ;   // for scanning
    wire [1:0]clk_ctl_100HZ;    
    wire selected_clk;  
    wire [1:0]selected_clk_ctl;
    wire clk_1HZ;   // 1hz clock
    wire clk_100HZ; // 100hz clock

    wire [3:0]val0, val1, val2, val3, val4, val5;
    wire [3:0]intossd_yy, intossd_mmdd;
    wire [3:0]lightctl_yy, lightctl_mmdd;
    wire [3:0]intossd_out;

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
    uct_dd_mm_yy U2_uct(
        .clk(selected_clk),
        .rst_n(rst_n),
        .val0(val0),
        .val1(val1),
        .val2(val2),
        .val3(val3),
        .val4(val4),
        .val5(val5)
    );
    scan_ctl_2bit U3_scan2b(
        .sel(selected_clk_ctl),
        .intossd(intossd_yy),
        .lightctl(lightctl_yy),
        .in0(val4),
        .in1(val5)
    );
    scan_ctl_4bit U4_scan4b(
        .sel(selected_clk_ctl),
        .intossd(intossd_mmdd),
        .lightctl(lightctl_mmdd),
        .in0(val0),
        .in1(val1),
        .in2(val2),
        .in3(val3)
    );
    data_mux U5_mux(
        .sel_yy_mmdd(sel_yy_mmdd),
        .intossd_yy(intossd_yy),
        .intossd_mmdd(intossd_mmdd),
        .lightctl_yy(lightctl_yy),
        .lightctl_mmdd(lightctl_mmdd),
        .lightctl_out(lightctl_out),
        .intossd_out(intossd_out)
    );

    display U6_display(
        .i(intossd_out),
        .D(display)
    );
    clock_sel U7_clk_sel(
        .clk_100HZ(clk_100HZ),
        .clk_1HZ(clk_1HZ),
        .sel_clock(sel_clock),
        .clk_ctl_1HZ(clk_ctl_1HZ),
        .clk_ctl_100HZ(clk_ctl_100HZ),
        .clk_out(selected_clk),
        .clk_ctl_out(selected_clk_ctl)
    );    
endmodule
