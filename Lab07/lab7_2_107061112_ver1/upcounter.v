`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/19 07:55:05
// Design Name: 
// Module Name: upcounter
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
module upcounter(
    value,  // counter value
    carry, // carry indicator for counter to next stage
    clk,    // global clock
    rst_n,
    increase,   // decrease input from previuos stage of counter
    init_value, // initial value for the counter
    limit,   // limit for the counter
    recur_reset
);

    output [`BCD_BIT_WIDTH - 1:0]value;
    output carry;
    
    input clk;
    input rst_n;
    input increase;
    input [`BCD_BIT_WIDTH - 1:0]init_value;
    input [`BCD_BIT_WIDTH - 1:0]limit;
    input recur_reset;

    reg [`BCD_BIT_WIDTH - 1:0]value;    
    reg [`BCD_BIT_WIDTH - 1:0]value_tmp;    // input to dff(always block)
    reg carry;

    // Combinational logic
    always@*
        if (increase && recur_reset)
        begin
            value_tmp = 4'd0;
            carry = 1'b1;
        end
        else if ((value == limit) && increase)
        begin
            value_tmp = 4'd0;
            carry = 1'b1;  
        end
        else if (increase == 1)
        begin
            value_tmp = value + 1;
            carry = 1'b0;
        end
        else
        begin
            value_tmp = value;
            carry = 1'b0;
        end

    // Counter
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            value <= init_value;
        else
            value <= value_tmp;
endmodule