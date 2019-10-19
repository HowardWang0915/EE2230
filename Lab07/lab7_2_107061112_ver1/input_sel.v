`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/20 12:40:33
// Design Name: 
// Module Name: input_sel
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


module input_sel(
    in_set,
    in0,
    in1,
    pause_resume,
    start_stop,
    set_min,
    set_sec,
    set,
    clk,
    rst_n
    );
    input clk;
    input rst_n;
    input in_set;
    input in0, in1;
    output reg set;
    output reg pause_resume;
    output reg start_stop;
    output reg set_min;
    output reg set_sec;
    
    reg pause_resume_tmp;
    reg start_stop_tmp;
    reg set_min_tmp;
    reg set_sec_tmp;

    always @*
    if (in_set == 1'b0)
    begin
        set = 1'b0;
        pause_resume_tmp = in0;
        start_stop_tmp = in1;
        set_min_tmp = 1'b0;
        set_sec_tmp = 1'b0;
    end
    else 
    begin
        set = 1'b1;
        pause_resume_tmp = 1'b0;
        start_stop_tmp = 1'b0;
        set_min_tmp = in1;
        set_sec_tmp = in0;
    end
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
        begin
            pause_resume <= 1'b0;
            start_stop <= 1'b0;
            set_min <= 1'b0;
            set_sec <= 1'b0;
        end
        else 
        begin
            pause_resume <= pause_resume_tmp;
            start_stop <= start_stop_tmp;
            set_min <= set_min_tmp;
            set_sec <= set_sec_tmp;
        end

endmodule
