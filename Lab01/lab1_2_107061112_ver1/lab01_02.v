`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/18 22:59:06
// Design Name: 
// Module Name: lab01_02
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


module lab01_02(a, b, cin, s, cout);
output [3:0]s, cout;
input [3:0]a;
input [3:0]b;
input cin;
reg [3:0]s, cout;

always @*
begin
    if ((a + b + cin) > 4'd9)
        begin
            cout = 1'b1;
            s = a + b + cin + 4'd6;
        end
    else 
        begin
            cout = 1'b0;
            s = a + b + cin;
        end
end 
endmodule
