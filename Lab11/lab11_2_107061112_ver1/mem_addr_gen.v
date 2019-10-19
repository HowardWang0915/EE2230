`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/30 16:16:32
// Design Name: 
// Module Name: mem_addr_gen
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
/*
`define PLUS        2'b01
`define MINUS       2'b10
`define TIMES       2'b11
`define NO          2'b00
module mem_addr_gen(
    h_cnt, 
    v_cnt,
    pixel_addr,
    ans3,
    ans2,
    ans1,
    ans0,
    num1, 
    num2,
	num3,
	num4,
    operation,
    negative
);
    input [8:0]num1, num2, num3, num4;
    input [3:0]ans0, ans1, ans2, ans3;
    input [1:0]operation;
    input negative;
    input [9:0]h_cnt;
    input [9:0]v_cnt;
    output reg [16:0]pixel_addr;

    always @*
        if (v_cnt < 128 | v_cnt > 191)
            pixel_addr = 17'b0;
        else 
        begin
            if (h_cnt < 64)
            begin
                case (num1 /10)
                    4'd0: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 256;
                    4'd1: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 320;
                    4'd2: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 384;
                    4'd3: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 448;
                    4'd4: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 512;
                    4'd5: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 576;
                    4'd6: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 640;
                    4'd7: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 704;
                    4'd8: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 768;
                    4'd9: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 832;
                    default: pixel_addr = 17'b0;
                endcase
            end
            else if (h_cnt >= 64 && h_cnt < 128)
            begin
                case (num2)
                    4'd0: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 192;
                    4'd1: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 256;
                    4'd2: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 320;
                    4'd3: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 384;
                    4'd4: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 448;
                    4'd5: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 512;
                    4'd6: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 576;
                    4'd7: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 640;
                    4'd8: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 704;
                    4'd9: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 768;
                    default: pixel_addr = 17'b0;
                endcase
            end
            else if (h_cnt >= 128 && h_cnt < 192)
            begin
                case (operation)
                    `PLUS:  pixel_addr = (v_cnt - 128) * 896 + h_cnt - 128;
                    `MINUS: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 64;
                    `TIMES: pixel_addr = (v_cnt - 128) * 896 + h_cnt;
                    default: pixel_addr = 17'b0;
                endcase
            end
            else if (h_cnt >= 192 && h_cnt < 256)
            begin
                case (num3 / 10)
                    4'd0: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 64;
                    4'd1: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 128;
                    4'd2: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 192;
                    4'd3: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 256;
                    4'd4: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 320;
                    4'd5: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 384;
                    4'd6: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 448;
                    4'd7: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 512;
                    4'd8: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 576;
                    4'd9: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 640;
                    default: pixel_addr = 17'b0;
                endcase
            end
            else if (h_cnt >= 256 && h_cnt < 320)
            begin
                case (num4)
                    4'd0: pixel_addr = (v_cnt - 128) * 896 + h_cnt;
                    4'd1: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 64;
                    4'd2: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 128;
                    4'd3: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 192;
                    4'd4: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 256;
                    4'd5: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 320;
                    4'd6: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 384;
                    4'd7: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 448;
                    4'd8: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 512;
                    4'd9: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 576;
                    default: pixel_addr = 17'b0;
                endcase
            end
            else if (h_cnt >= 320 && h_cnt < 384)
                pixel_addr = (v_cnt - 128) * 896 + h_cnt - 128;
            else if (h_cnt >= 384 && h_cnt < 448)
            begin
                if (negative)
                    pixel_addr = (v_cnt - 128) * 896 + h_cnt - 320;
                else
                begin
                    case (ans3)
                        4'd0: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 128;
                        4'd1: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 64;
                        4'd2: pixel_addr = (v_cnt - 128) * 896 + h_cnt;
                        4'd3: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 64;
                        4'd4: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 128;
                        4'd5: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 192;
                        4'd6: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 256;
                        4'd7: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 320;
                        4'd8: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 384;
                        4'd9: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 448;
                        default: pixel_addr = 17'b0;
                    endcase
                end
            end
            else if (h_cnt >= 448 && h_cnt < 512)
            begin
                case (ans2)
                        4'd0: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 192;
                        4'd1: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 128;
                        4'd2: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 64;
                        4'd3: pixel_addr = (v_cnt - 128) * 896 + h_cnt;
                        4'd4: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 64;
                        4'd5: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 128;
                        4'd6: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 192;
                        4'd7: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 256;
                        4'd8: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 320;
                        4'd9: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 384;
                        default: pixel_addr = 17'b0;
                    endcase
            end
            else if (h_cnt >= 512 && h_cnt < 576)
            begin
                case (ans1)
                        4'd0: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 256;
                        4'd1: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 192;
                        4'd2: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 128;
                        4'd3: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 64;
                        4'd4: pixel_addr = (v_cnt - 128) * 896 + h_cnt ;
                        4'd5: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 64;
                        4'd6: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 128;
                        4'd7: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 192;
                        4'd8: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 256;
                        4'd9: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 320;
                        default: pixel_addr = 17'b0;
                    endcase
            end
            else if (h_cnt >= 576 && h_cnt < 640)
            begin
                case (ans0)
                        4'd0: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 320;
                        4'd1: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 256;
                        4'd2: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 192;
                        4'd3: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 128;
                        4'd4: pixel_addr = (v_cnt - 128) * 896 + h_cnt - 64;
                        4'd5: pixel_addr = (v_cnt - 128) * 896 + h_cnt ;
                        4'd6: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 64;
                        4'd7: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 128;
                        4'd8: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 192;
                        4'd9: pixel_addr = (v_cnt - 128) * 896 + h_cnt + 256;
                        default: pixel_addr = 17'b0;
                    endcase
            end
            else 
                pixel_addr = 17'b0;
        end
endmodule
*/
`define PLUS        2'b01
`define MINUS       2'b10
`define TIMES       2'b11
`define NO          2'b00
module mem_addr_gen(
    h_cnt, 
    v_cnt,
    pixel_addr1,
    pixel_addr2,
    ans3,
    ans2,
    ans1,
    ans0,
    num1, 
    num2,
	num3,
	num4,
    operation,
    negative
);
    input [8:0]num1, num2, num3, num4;
    input [3:0]ans0, ans1, ans2, ans3;
    input [1:0]operation;
    input negative;
    input [9:0]h_cnt;
    input [9:0]v_cnt;
    output reg [16:0]pixel_addr1;
    output reg [16:0]pixel_addr2;

    always @*
    begin
        if (v_cnt > 64)
        begin
            pixel_addr1 = 17'b0;
            pixel_addr2 = ((h_cnt>>1) + 320 * ((v_cnt - 64)>>1));
        end
        else 
        begin
            if (h_cnt < 64)
            begin
                pixel_addr2 = 17'b0; 
                case (num1 /10)
                    4'd0: pixel_addr1 = (v_cnt) * 896 + h_cnt + 256;
                    4'd1: pixel_addr1 = (v_cnt) * 896 + h_cnt + 320;
                    4'd2: pixel_addr1 = (v_cnt) * 896 + h_cnt + 384;
                    4'd3: pixel_addr1 = (v_cnt) * 896 + h_cnt + 448;
                    4'd4: pixel_addr1 = (v_cnt) * 896 + h_cnt + 512;
                    4'd5: pixel_addr1 = (v_cnt) * 896 + h_cnt + 576;
                    4'd6: pixel_addr1 = (v_cnt) * 896 + h_cnt + 640;
                    4'd7: pixel_addr1 = (v_cnt) * 896 + h_cnt + 704;
                    4'd8: pixel_addr1 = (v_cnt) * 896 + h_cnt + 768;
                    4'd9: pixel_addr1 = (v_cnt) * 896 + h_cnt + 832;
                    default: pixel_addr1 = 17'b0;
                endcase
            end
            else if (h_cnt >= 64 && h_cnt < 128)
            begin
                pixel_addr2 = 17'b0; 
                case (num2)
                    4'd0: pixel_addr1 = (v_cnt) * 896 + h_cnt + 192;
                    4'd1: pixel_addr1 = (v_cnt) * 896 + h_cnt + 256;
                    4'd2: pixel_addr1 = (v_cnt) * 896 + h_cnt + 320;
                    4'd3: pixel_addr1 = (v_cnt) * 896 + h_cnt + 384;
                    4'd4: pixel_addr1 = (v_cnt) * 896 + h_cnt + 448;
                    4'd5: pixel_addr1 = (v_cnt) * 896 + h_cnt + 512;
                    4'd6: pixel_addr1 = (v_cnt) * 896 + h_cnt + 576;
                    4'd7: pixel_addr1 = (v_cnt) * 896 + h_cnt + 640;
                    4'd8: pixel_addr1 = (v_cnt) * 896 + h_cnt + 704;
                    4'd9: pixel_addr1 = (v_cnt) * 896 + h_cnt + 768;
                    default: pixel_addr1 = 17'b0;
                endcase
            end
            else if (h_cnt >= 128 && h_cnt < 192)
            begin
                pixel_addr2 = 17'b0; 
                case (operation)
                    `PLUS:  pixel_addr1 = (v_cnt) * 896 + h_cnt - 128;
                    `MINUS: pixel_addr1 = (v_cnt) * 896 + h_cnt - 64;
                    `TIMES: pixel_addr1 = (v_cnt) * 896 + h_cnt;
                    default: pixel_addr1 = 17'b0;
                endcase
            end
            else if (h_cnt >= 192 && h_cnt < 256)
            begin
                pixel_addr2 = 17'b0; 
                case (num3 / 10)
                    4'd0: pixel_addr1 = (v_cnt) * 896 + h_cnt + 64;
                    4'd1: pixel_addr1 = (v_cnt) * 896 + h_cnt + 128;
                    4'd2: pixel_addr1 = (v_cnt) * 896 + h_cnt + 192;
                    4'd3: pixel_addr1 = (v_cnt) * 896 + h_cnt + 256;
                    4'd4: pixel_addr1 = (v_cnt) * 896 + h_cnt + 320;
                    4'd5: pixel_addr1 = (v_cnt) * 896 + h_cnt + 384;
                    4'd6: pixel_addr1 = (v_cnt) * 896 + h_cnt + 448;
                    4'd7: pixel_addr1 = (v_cnt) * 896 + h_cnt + 512;
                    4'd8: pixel_addr1 = (v_cnt) * 896 + h_cnt + 576;
                    4'd9: pixel_addr1 = (v_cnt) * 896 + h_cnt + 640;
                    default: pixel_addr1 = 17'b0;
                endcase
            end
            else if (h_cnt >= 256 && h_cnt < 320)
            begin
                pixel_addr2 = 17'b0; 
                case (num4)
                    4'd0: pixel_addr1 = (v_cnt) * 896 + h_cnt;
                    4'd1: pixel_addr1 = (v_cnt) * 896 + h_cnt + 64;
                    4'd2: pixel_addr1 = (v_cnt) * 896 + h_cnt + 128;
                    4'd3: pixel_addr1 = (v_cnt) * 896 + h_cnt + 192;
                    4'd4: pixel_addr1 = (v_cnt) * 896 + h_cnt + 256;
                    4'd5: pixel_addr1 = (v_cnt) * 896 + h_cnt + 320;
                    4'd6: pixel_addr1 = (v_cnt) * 896 + h_cnt + 384;
                    4'd7: pixel_addr1 = (v_cnt) * 896 + h_cnt + 448;
                    4'd8: pixel_addr1 = (v_cnt) * 896 + h_cnt + 512;
                    4'd9: pixel_addr1 = (v_cnt) * 896 + h_cnt + 576;
                    default: pixel_addr1 = 17'b0;
                endcase
            end
            else if (h_cnt >= 320 && h_cnt < 384)
            begin
                pixel_addr2 = 17'b0; 
                pixel_addr1 = (v_cnt) * 896 + h_cnt - 128;
            end
            else if (h_cnt >= 384 && h_cnt < 448)
            begin
                pixel_addr2 = 17'b0; 
                if (negative)
                    pixel_addr1 = (v_cnt) * 896 + h_cnt - 320;
                else
                begin
                    case (ans3)
                        4'd0: pixel_addr1 = (v_cnt) * 896 + h_cnt - 128;
                        4'd1: pixel_addr1 = (v_cnt) * 896 + h_cnt - 64;
                        4'd2: pixel_addr1 = (v_cnt) * 896 + h_cnt;
                        4'd3: pixel_addr1 = (v_cnt) * 896 + h_cnt + 64;
                        4'd4: pixel_addr1 = (v_cnt) * 896 + h_cnt + 128;
                        4'd5: pixel_addr1 = (v_cnt) * 896 + h_cnt + 192;
                        4'd6: pixel_addr1 = (v_cnt) * 896 + h_cnt + 256;
                        4'd7: pixel_addr1 = (v_cnt) * 896 + h_cnt + 320;
                        4'd8: pixel_addr1 = (v_cnt) * 896 + h_cnt + 384;
                        4'd9: pixel_addr1 = (v_cnt) * 896 + h_cnt + 448;
                        default: pixel_addr1 = 17'b0;
                    endcase
                end
            end
            else if (h_cnt >= 448 && h_cnt < 512)
            begin
                pixel_addr2 = 17'b0; 
                case (ans2)
                        4'd0: pixel_addr1 = (v_cnt) * 896 + h_cnt - 192;
                        4'd1: pixel_addr1 = (v_cnt) * 896 + h_cnt - 128;
                        4'd2: pixel_addr1 = (v_cnt) * 896 + h_cnt - 64;
                        4'd3: pixel_addr1 = (v_cnt) * 896 + h_cnt;
                        4'd4: pixel_addr1 = (v_cnt) * 896 + h_cnt + 64;
                        4'd5: pixel_addr1 = (v_cnt) * 896 + h_cnt + 128;
                        4'd6: pixel_addr1 = (v_cnt) * 896 + h_cnt + 192;
                        4'd7: pixel_addr1 = (v_cnt) * 896 + h_cnt + 256;
                        4'd8: pixel_addr1 = (v_cnt) * 896 + h_cnt + 320;
                        4'd9: pixel_addr1 = (v_cnt) * 896 + h_cnt + 384;
                        default: pixel_addr1 = 17'b0;
                    endcase
            end
            else if (h_cnt >= 512 && h_cnt < 576)
            begin
                pixel_addr2 = 17'b0; 
                case (ans1)
                        4'd0: pixel_addr1 = (v_cnt) * 896 + h_cnt - 256;
                        4'd1: pixel_addr1 = (v_cnt) * 896 + h_cnt - 192;
                        4'd2: pixel_addr1 = (v_cnt) * 896 + h_cnt - 128;
                        4'd3: pixel_addr1 = (v_cnt) * 896 + h_cnt - 64;
                        4'd4: pixel_addr1 = (v_cnt) * 896 + h_cnt ;
                        4'd5: pixel_addr1 = (v_cnt) * 896 + h_cnt + 64;
                        4'd6: pixel_addr1 = (v_cnt) * 896 + h_cnt + 128;
                        4'd7: pixel_addr1 = (v_cnt) * 896 + h_cnt + 192;
                        4'd8: pixel_addr1 = (v_cnt) * 896 + h_cnt + 256;
                        4'd9: pixel_addr1 = (v_cnt) * 896 + h_cnt + 320;
                        default: pixel_addr1 = 17'b0;
                    endcase
            end
            else if (h_cnt >= 576 && h_cnt < 640)
            begin
                pixel_addr2 = 17'b0; 
                case (ans0)
                        4'd0: pixel_addr1 = (v_cnt) * 896 + h_cnt - 320;
                        4'd1: pixel_addr1 = (v_cnt) * 896 + h_cnt - 256;
                        4'd2: pixel_addr1 = (v_cnt) * 896 + h_cnt - 192;
                        4'd3: pixel_addr1 = (v_cnt) * 896 + h_cnt - 128;
                        4'd4: pixel_addr1 = (v_cnt) * 896 + h_cnt - 64;
                        4'd5: pixel_addr1 = (v_cnt) * 896 + h_cnt ;
                        4'd6: pixel_addr1 = (v_cnt) * 896 + h_cnt + 64;
                        4'd7: pixel_addr1 = (v_cnt) * 896 + h_cnt + 128;
                        4'd8: pixel_addr1 = (v_cnt) * 896 + h_cnt + 192;
                        4'd9: pixel_addr1 = (v_cnt) * 896 + h_cnt + 256;
                        default: pixel_addr1 = 17'b0;
                    endcase
            end
        end
    end
endmodule