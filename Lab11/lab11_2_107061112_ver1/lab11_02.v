`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 16:16:32
// Design Name: 
// Module Name: lab11_02
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


module lab11_02(
	clk,
	rst,
    vgaRed,
    vgaGreen,
    vgaBlue,
    hsync,
    vsync,
	PS2_CLK,
	PS2_DATA
    );
    input clk;
    input rst;
    output reg[3:0] vgaRed;
    output reg[3:0] vgaGreen;
    output reg[3:0] vgaBlue;
    output hsync;
    output vsync;
	inout PS2_CLK;
	inout PS2_DATA;
    wire [511:0]key_down;
	wire [8:0]last_change;
	wire [9:0]v_cnt;
	wire [9:0]h_cnt;
    wire clk_25MHz;
    wire clk_22;
    wire key_valid;
    wire key_release;
    wire [15:0]ans;						// operation answer
    wire [3:0]conv_out;					// last change converted
    wire [3:0]bcd0, bcd1, bcd2, bcd3;	// answer bits
    wire [16:0]pixel_addr1;
	wire [16:0]piexl_addr2;
    wire [8:0]num1, num2, num3, num4;	// input numbers bits
	wire [1:0]operator;
	wire [11:0]pixel1;
	wire [11:0]pixel2;
	wire [11:0]data;
	wire negative;

	always @*
		if (v_cnt > 64)
			{vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
		else
			{vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
    KeyboardDecoder U0(
		.key_down(key_down),
		.last_change(last_change),
		.key_valid(key_valid),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
		);
		
	freq_div U1(
		.clk(clk),
	    .clk1(clk_25MHz),
	    .clk22(clk_22)
		);
    key_valid U2_kv(
        .key_valid(key_valid),
        .clk(clk),
        .rst(rst),
        .out(key_release)
    );
    last_change U3_last(
        .last_change(last_change),
        .out(conv_out)
    );
    Operations U4_operations(
        .clk(clk),
        .rst(rst),
        .in_num(conv_out),
        .key_valid(key_release),
        .ans(ans),
        .negative(negative),
        .num1(num1),
        .num2(num2),
		.num3(num3),
		.num4(num4),
		.operator(operator)
    );
    bin_to_dec U5_btd(
        .ans(ans),
        .BCD0(bcd0),
        .BCD1(bcd1),
        .BCD2(bcd2),
        .BCD3(bcd3)
    );
	vga U6(
	    .pclk(clk_25MHz),
	    .reset(rst),
	    .hsync(hsync),
	    .vsync(vsync),
	    .valid(valid),
	    .h_cnt(h_cnt),
	    .v_cnt(v_cnt)
		);
    mem_addr_gen U7(
		.ans3(bcd3),
		.ans2(bcd2),
		.ans1(bcd1),
		.ans0(bcd0),
		.num1(num1),
		.num2(num2),
		.num3(num3),
		.num4(num4),
		.h_cnt(h_cnt),
		.v_cnt(v_cnt),
		.pixel_addr1(pixel_addr1),
		.pixel_addr2(pixel_addr2),
		.operation(operator),
		.negative(negative)
		);
	blk_mem_gen_0 blk_mem_gen_0_inst(
  		.clka(clk_25MHz),
  		.wea(0),
  		.addra(pixel_addr1),
  		.dina(data[11:0]),
  		.douta(pixel1)
	); 
	blk_mem_gen_1 blk_mem_gen_1_inst(
  		.clka(clk_25MHz),
  		.wea(0),
  		.addra(pixel_addr2),
  		.dina(data[11:0]),
  		.douta(pixel2)
	); 
endmodule
