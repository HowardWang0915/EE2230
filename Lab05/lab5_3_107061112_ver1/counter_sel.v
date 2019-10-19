`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/30 10:02:22
// Design Name: 
// Module Name: counter_sel
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


module counter_sel(
count_enable, 
counter_sel, 
reset_en,
count_enable_assign_2d,
count_enable_assign_3d,
reset_assign_2d,
reset_assign_3d
);

input counter_sel;
input count_enable;
input reset_en;

output reg count_enable_assign_2d;
output reg count_enable_assign_3d;
output reg reset_assign_2d;
output reg reset_assign_3d;

always @*
    case(counter_sel)
        1'b0:
        begin
            count_enable_assign_2d = count_enable;
            count_enable_assign_3d = 1'b0;
            reset_assign_2d = reset_en;
            reset_assign_3d = 1'b1;     
        end
        1'b1:
        begin
            count_enable_assign_2d = 1'b0;
            count_enable_assign_3d = count_enable;
            reset_assign_2d = 1'b1;
            reset_assign_3d = reset_en;
        end
        default:
        begin
            count_enable_assign_2d = 1'b1;
            count_enable_assign_3d = 1'b1;
            reset_assign_2d = 1'b1;
            reset_assign_3d = 1'b1;
        end
    endcase
endmodule
