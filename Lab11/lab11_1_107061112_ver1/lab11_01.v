`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/25 23:09:55
// Design Name: 
// Module Name: lab11_01
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


module lab11_01(
    clk,
    rst,
	pb_in,
    vgaRed,
    vgaGreen,
    vgaBlue,
    hsync,
    vsync
);

	input clk;
    input rst;
	input pb_in;
    output [3:0] vgaRed;
    output [3:0] vgaGreen;
    output [3:0] vgaBlue;
    output hsync;
    output vsync;

	wire pb_debounced;
	wire pb_debounced_rst;
	wire pb_one_pulse;
	wire pb_one_pulse_rst;
	wire count;
	wire [11:0] data;
	wire clk_25MHz;
	wire clk_22;
	wire [16:0] pixel_addr;
	wire [11:0] pixel;
	wire valid;
	wire [9:0] h_cnt; //640
	wire [9:0] v_cnt;  //480

	assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

	// Frequency Divider
	freq_div U0(
	    .clk(clk),
	    .clk1(clk_25MHz),
	    .clk22(clk_22)
		);
	debounce U1_rst(
		.clk(clk_22),
		.pb_in(rst),
		.pb_debounced(pb_debounced_rst),
		.rst_n(pb_one_pulse_rst)
	);
	debounce U1(
		.clk(clk_22),  //clock control
		.pb_in(pb_in),  //push botton input
		.pb_debounced(pb_debounced),  //debounced push botton output
        .rst_n(pb_one_pulse_rst)
		);
	one_pulse U2(
		.out_pulse(pb_one_pulse),  //output one pulse
		.clk(clk),  //clock input
		.in_trig(pb_debounced),  //input trigger
        .rst_n(pb_one_pulse_rst)
		);
	one_pulse U2_rst(
		.out_pulse(pb_one_pulse_rst),  //output one pulse
		.clk(clk),  //clock input
		.in_trig(pb_debounced_rst),  //input trigger
        .rst_n(pb_one_pulse_rst)
		);
	Fsm U3(
		.state(count),
		.in(pb_one_pulse),
		.clk(clk),
		.rst(pb_one_pulse_rst)
		);
		
	// Render the picture by VGA controller
	vga U4(
	    .pclk(clk_25MHz),
	    .reset(pb_one_pulse_rst),
	    .hsync(hsync),
	    .vsync(vsync),
	    .valid(valid),
	    .h_cnt(h_cnt),
	    .v_cnt(v_cnt)
		);

	// Reduce frame address from 640x480 to 320x240
	mem_addr_gen U5(
	    .clk(clk_22),
	    .rst(pb_one_pulse_rst),
		.en(count),
	    .h_cnt(h_cnt),
	    .v_cnt(v_cnt),
	    .pixel_addr(pixel_addr)
		);
	blk_mem_gen_0 U6(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel)
		); 
		 
endmodule
