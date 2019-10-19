`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/01 21:38:41
// Design Name: 
// Module Name: lab11_03
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


module lab11_03(
	clk,
	rst,
    vgaRed,
    vgaGreen,
    vgaBlue,
    hsync,
    vsync
    );
    input clk;
    input rst;
    output [3:0] vgaRed;
    output [3:0] vgaGreen;
    output [3:0] vgaBlue;
    output hsync;
    output vsync;

    wire clk_1Hz;
	wire [9:0]v_cnt;
	wire [9:0]h_cnt;
    wire clk_25MHz;
    wire clk_22;
	wire valid;
    wire [8:0]position;
    wire [2:0]random;
    wire [16:0]pixel_addr;
	wire [11:0]pixel;
	wire [11:0]data;

	
	assign {vgaRed, vgaGreen, vgaBlue} = (valid == 1'b1) ? pixel:12'h0;

	fast_clk U1(
		.clk(clk),
	    .clk1(clk_25MHz),
	    .clk22(clk_22)
		);
    clk U2(
        .clk(clk),
        .rst_n(rst),
        .clk_out(clk_1Hz)
    );
    LFSR U3(
        .clk(clk_1Hz),
        .rst(rst),
        .position(position),
        .q(random)
    );
	vga U4(
	    .pclk(clk_25MHz),
	    .reset(rst),
	    .hsync(hsync),
	    .vsync(vsync),
	    .valid(valid),
	    .h_cnt(h_cnt),
	    .v_cnt(v_cnt)
		);
    mem_addr_gen U5(
        .clk(clk_1Hz),
        .rst(rst),
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .random(random),
        .position(position),
        .pixel_addr(pixel_addr)
		);
	blk_mem_gen_0 blk_mem_gen_0_inst(
  		.clka(clk_25MHz),
  		.wea(0),
  		.addra(pixel_addr),
  		.dina(data[11:0]),
  		.douta(pixel)
	); 
endmodule