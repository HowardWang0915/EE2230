`define SS_N 8'b11010101
`define SS_T 8'b11100001
`define SS_H 8'b10010001
`define SS_U 8'b10000011
`define SS_E 8'b01100001
module shifter(q0, q1, q2, q3, clk, rst_n);
output [7:0]q0, q1, q2, q3; // output
input clk; // global clock
input rst_n; // active low reset

reg [7:0]q0, q1, q2, q3, q4, q5; 
// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
    if (~rst_n)
        begin
            q0 <= `SS_U;
            q1 <= `SS_H;
            q2 <= `SS_T;
            q3 <= `SS_N;
            q4 <= `SS_E;
            q5 <= `SS_E;
        end
    else
    begin
        q0 <= q5;
        q1 <= q0;
        q2 <= q1;
        q3 <= q2;
        q4 <= q3;
        q5 <= q4;
     end
endmodule