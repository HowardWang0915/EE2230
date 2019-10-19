`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/13 17:36:34
// Design Name: 
// Module Name: fsm
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

`define PLUS        2'b01
`define MINUS       2'b10
`define TIMES       2'b11
`define NO          2'b00
module operations(
    clk,
    rst,
    key_valid,
    in_num,
    ans,
    negative
);
    input clk;
    input rst;
    input key_valid;
    input [3:0]in_num;          // input number
    
    output reg negative;        // if the answer is negative
    output reg [15:0]ans;       // operation answer
    reg negative_tmp;
    reg [15:0]ans_tmp;
    reg [1:0]operator, operator_tmp;
    reg [1:0]init, init_tmp;    // determine which state
    reg [8:0]num1, num2, num1_tmp, num2_tmp;
    // two input numbers
    always @*
        if (key_valid && in_num <= 4'd9 && init == 2'd0)
        begin
            init_tmp = init + 2'b1;
            num1_tmp = 10 * in_num;
            num2_tmp = num2;
        end
        else if (key_valid && in_num <= 4'd9 && init == 2'd1)
        begin
            init_tmp = init + 2'b1;
            num1_tmp = num1 + in_num;
            num2_tmp = num2;
        end
        else if (key_valid && in_num <= 4'd9 && init == 2'd2)
        begin
            init_tmp = init + 2'b1;
            num1_tmp = num1;
            num2_tmp = 10 * in_num;
        end
        else if (key_valid && in_num <= 4'd9 && init == 2'd3)
        begin
            init_tmp = 2'd0;
            num1_tmp = num1;
            num2_tmp = num2 + in_num;
        end
        else
        begin
            init_tmp = init;
            num1_tmp = num1;
            num2_tmp = num2;
        end

    // operators
    always @*
        if (key_valid && in_num == 4'd10 && init == 2'd2)
            operator_tmp = `PLUS;
        else if (key_valid && in_num == 4'd11 && init == 2'd2)
            operator_tmp = `MINUS;
        else if (key_valid && in_num == 4'd12 && init == 2'd2)
            operator_tmp = `TIMES;
        else
            operator_tmp = operator;
            
    // answers
    always @*
        if (key_valid && in_num == 4'd13 && init == 2'd0 && operator == `PLUS)
        begin
            negative_tmp = 1'b0;
            ans_tmp =  num1 + num2;
        end
        else if (key_valid && in_num == 4'd13 && init == 2'd0 && operator == `MINUS && num1 >= num2)
        begin
            negative_tmp = 1'b0;
            ans_tmp =  num1 - num2;
        end
        else if (key_valid && in_num == 4'd13 && init == 2'd0 && operator == `MINUS && num1 < num2)
        begin
            negative_tmp = 1'b1;
            ans_tmp =  num2 - num1;
        end
        else if (key_valid && in_num == 4'd13 && init == 2'd0 && operator == `TIMES)
        begin
            negative_tmp = 1'b0;
            ans_tmp = num1 * num2;
        end
        else
        begin
            negative_tmp = negative;
            ans_tmp = ans;
        end
        
    always @(posedge clk or posedge rst)
        if (rst)
        begin
            ans <= 16'b0;
            num1 <= 4'b0;
            num2 <= 4'b0;
            init <= 1'b0;
            operator <= 2'b0;
            negative <= 1'b0;
        end
        else
        begin
            ans <= ans_tmp;
            num1 <= num1_tmp;
            num2 <= num2_tmp;
            init <= init_tmp;
            operator <= operator_tmp;
            negative <= negative_tmp;
        end
            

endmodule

