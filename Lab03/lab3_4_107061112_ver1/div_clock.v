`define FREQ_DIV_BIT 27
module div_clock(
    clk_out, // divided clock output
    clk_ctl, // divided clock output for scan freq
    clk, // global clock input
    rst_n // active low reset
    );
    output clk_out; // divided output
    output [1:0]clk_ctl; // divided output for scan freq
    input clk; // global clock input
    input rst_n; // active low reset
    reg clk_out; // clk output (in always block)
    reg [1:0] clk_ctl; // clk output (in always block)
    reg [14:0] cnt_l; // temp buf of the counter
    reg [8:0] cnt_h; // temp buf of the counter
    reg [`FREQ_DIV_BIT-1:0] cnt_tmp; // input to dff (in always block)
// Combinational logics: increment, neglecting overflow
    always @*
        cnt_tmp = {clk_out,cnt_h,clk_ctl,cnt_l} + 1'b1;
// Sequential logics: Flip flops
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            {clk_out, cnt_h, clk_ctl, cnt_l}<=`FREQ_DIV_BIT'd0;
        else 
            {clk_out,cnt_h, clk_ctl, cnt_l}<=cnt_tmp;
endmodule