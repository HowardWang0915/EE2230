`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/24 22:26:41
// Design Name: 
// Module Name: debounce
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


module debounce(
    pb_in,
    clk,
    rst_n,
    pb_debounced
    );
    input pb_in;
    input clk;
    input rst_n;
    output pb_debounced;

    reg pb_debounced;
    reg [3:0]debounced_window;
    reg pb_debounced_next;

    // four shift registers shift the inputs
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            debounced_window <= 4'b0;
        else
            debounced_window <= {debounced_window[2:0], pb_in};
    // And block
    always @*
        if (debounced_window == 4'b1111)
            pb_debounced_next = 1'b1;
        else    
            pb_debounced_next = 1'b0;
    // last shift register
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            pb_debounced <= 1'b0;
        else    
            pb_debounced <= pb_debounced_next;  
endmodule
