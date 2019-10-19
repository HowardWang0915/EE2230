`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/18 17:52:29
// Design Name: 
// Module Name: lab01_01
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


module lab01_01(s, cout, x, y, cin);
    input x, y, cin;
    output s, cout;
    assign cout = (y & cin) | (x & y) | (cin & x);
    assign s = x ^ y ^ cin; 
endmodule
