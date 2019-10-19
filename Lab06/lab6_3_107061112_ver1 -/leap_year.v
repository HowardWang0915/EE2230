`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 22:44:30
// Design Name: 
// Module Name: leap_year
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


module leap_year(
    val0,   
    val1,
    val2,
    val3,
    leap_year
    );
    input [3:0]val0, val1, val2, val3;
    output leap_year;   // leap year indicator

    // similar to clock
    
    reg leap_year;
    always @*
    if (val2 == 0 && val1 == 0 && val0 == 0)
        leap_year = 1'b1;
    else if (val1 % 2 == 0 && val0 % 4 == 0)
        leap_year = 1'b1;
    else if (val1 % 2 == 1 && val0 % 4 == 2)
        leap_year = 1'b1;
    else 
        leap_year = 1'b0;
endmodule