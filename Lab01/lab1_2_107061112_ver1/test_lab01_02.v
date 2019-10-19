`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/18 23:00:31
// Design Name: 
// Module Name: test_lab01_02
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


module test_lab01_02;
wire [3:0]S;
wire COUT;
reg [3:0]A;
reg [3:0]B;
reg CIN;

lab01_02 U0 (.s(S), .cout(COUT), .a(A), .b(B), .cin(CIN));

initial
begin
    A = 0; B = 0; CIN = 0;
    repeat (2) begin
        repeat (9) begin
            #10 A = A + 1;
            repeat (9) begin
                #10 B = B + 1;
            end
            B = 0;
        end
        CIN = 1;
        A = 0;
    end
end
endmodule
