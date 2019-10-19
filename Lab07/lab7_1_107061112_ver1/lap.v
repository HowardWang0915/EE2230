`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 16:59:00
// Design Name: 
// Module Name: lap
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


module lap(
    clk,    
    rst_n,
    val0,   // input values of counters
    val1,
    val2,
    val3,
    out0,
    out1,
    out2, 
    out3,
    enable  // lap enable
    );
    input clk;
    input rst_n;
    input [3:0]val0, val1, val2, val3;
    input enable;
    
    output [3:0]out0, out1, out2, out3;

    reg [3:0]out0, out1, out2, out3;
    reg [3:0]tmp0, tmp1, tmp2, tmp3;

    always@*
        if(enable == 1'b1)
            begin
                tmp3 = out3;
                tmp2 = out2;
                tmp1 = out1;
                tmp0 = out0;
            end
        else
            begin
                tmp3 = val3;
                tmp2 = val2;
                tmp1 = val1;
                tmp0 = val0;
            end
    
    always@(posedge clk or posedge rst_n)
        if(~rst_n)
            begin
                out3 <= 4'd0;
                out2 <= 4'd0;
                out1 <= 4'd0;
                out0 <= 4'd0;
            end
        else
            begin
                out3 <= tmp3;
                out2 <= tmp2;
                out1 <= tmp1;
                out0 <= tmp0;
            end          
endmodule