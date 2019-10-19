`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/25 10:31:32
// Design Name: 
// Module Name: lab05_01
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


module lab05_02(
    in_trig,    // input trigger
    clk,    // Crystal clock
    led,    // led display
    display, // ssd
    lightctl,
    rst_n   
    );

    input in_trig;
    input clk;
    input rst_n;    // low active reset

    output [15:0]led;
    output [7:0]display;
    output [3:0]lightctl;
    
    wire one_pulse_rst;   
    wire out_pulse;     // one pulse output
    wire clk_out_1HZ;   // for generating the 1HZ clock
    wire clk_out_100HZ; // for generating the 100HZ clock 
    wire [1:0]clk_ctl;   // for scanning
    wire debounced_in;  // input signal after debouncing
 
    wire count_enable;  // fsm to the counter
    wire state;         // state output
    wire [3:0]msb;   // output of counter
    wire [3:0]lsb;   // output of counter
    wire stop;       // stop signal from counter
    wire [3:0]intossd;   // display number

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

    debounce U2_start_pause(
        .pb_in(in_trig),
        .clk(clk_out_100HZ),
        .rst_n(rst_n),
        .pb_debounced(debounced_in)
    );

    one_pulse U3_start_pause(
        .clk(clk_out_100HZ),
        .rst_n(rst_n),
        .in_trig(debounced_in),
        .out_pulse(out_pulse)   
    );
    long_press_rst U4(
        .clk(clk_out_100HZ),
        .rst_n(rst_n),
        .in(debounced_in),
        .rst(one_pulse_rst)
    );
    fsm U5(
        .count_enable(count_enable),
        .clk(clk_out_100HZ),
        .rst_n(one_pulse_rst),
        .in(out_pulse),
        .state_out(state)
    );
    dct_2d U6(
        .clk(clk_out_1HZ),
        .stop(stop),
        .rst_n(one_pulse_rst),
        .en(count_enable),
        .msb(msb),
        .lsb(lsb)
    );
    scan_ctl U7(
        .sel(clk_ctl),
        .in0(msb),
        .in1(lsb),
        .intossd(intossd),
        .lightctl(lightctl)
    );
    LED U8(
        .state(state),
        .stop(stop),
        .display(led)
    );
    display U9(
        .i(intossd),
        .D(display)
    );

endmodule
