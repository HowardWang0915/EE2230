`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/19 23:21:58
// Design Name: 
// Module Name: LED
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


module LED(
    stop,
    display
);
    input stop;
    output [15:0]display;
    
    reg [15:0]display;

    always @*
        if (stop == 1)
            display = 16'b1111111111111111;
        else 
            display = 16'b0;
endmodule
