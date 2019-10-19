`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 17:21:18
// Design Name: 
// Module Name: adder
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

`define STATE_ADDEND 1'b0
`define STATE_AUGEND 1'b1
module adder_fsm(
    rst,
    clk,
    last_change,
    key_valid,
    addend,
    augend
);
    input clk;
    input rst;
    input key_valid;
    input [3:0]last_change;
    output reg[3:0]addend;
    output reg[3:0]augend;
    reg [3:0]addend_next, augend_next;
    reg state, next_state;
    always @*
        case(state)
            `STATE_ADDEND:
                if (key_valid)
                begin
                    addend_next = last_change;
                    augend_next = augend;
                    next_state = `STATE_AUGEND;
                end
                else
                begin
                    addend_next = addend;
                    augend_next = augend;
                    next_state = `STATE_ADDEND;
                end
            `STATE_AUGEND:
                if (key_valid)
                begin
                    addend_next = addend;
                    augend_next = last_change;
                    next_state = `STATE_ADDEND;
                end
                else
                begin
                    addend_next = addend;
                    augend_next = augend;
                    next_state = `STATE_AUGEND;
                end
            default:
                begin
                    addend_next = addend;
                    augend_next = augend;
                    next_state = `STATE_ADDEND;
                end
        endcase

    always @(posedge clk or posedge rst)
        if (rst)
        begin
            state <= `STATE_ADDEND;
            addend <= 4'b0;
            augend <= 4'b0;
        end
        else 
        begin
            state <= next_state;
            addend <= addend_next;
            augend <= augend_next;
        end
endmodule
