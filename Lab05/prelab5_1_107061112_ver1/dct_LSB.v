`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/14 21:30:29
// Design Name: 
// Module Name: dct_LSB
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


`define BCD_BIT_WIDTH 4
module dct_LSB(
    rst_n,
    value,  // counter value
    borrow, // borrow indicator for counter to next stage
    clk,    // global clock
    decrease,   // decrease input from previuos stage of counter
    init_value, // initial value for the counter
    limit   // limit for the counter
);

    output [`BCD_BIT_WIDTH - 1:0]value;
    output borrow;
    input clk;
    input rst_n;
    input decrease;
    input [`BCD_BIT_WIDTH - 1:0]init_value;
    input [`BCD_BIT_WIDTH - 1:0]limit;

    reg [`BCD_BIT_WIDTH - 1:0]value;    
    reg [`BCD_BIT_WIDTH - 1:0]value_tmp;    // input to dff(always block)
    reg borrow;

    // Combinational logic
    always @*
        if (value == 4'd0 && decrease)
        begin
          value_tmp = limit;
          borrow = 1;  
        end
        else if(decrease == 1)
        begin
          value_tmp = value - 1;
          borrow = 0;
        end
        else
        begin
          value_tmp = value;
          borrow = 0;
        end

    // Counter
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            value <= init_value;
        else
            value <= value_tmp;
endmodule