/*
module speaker_control(
    clk, 
    rst_n, 
    audio_left,
    audio_right, 
    audio_mclk,
    audio_lrck,
    audio_sck,
    audio_sdin
);

    input clk;
    input rst_n;
    input [15:0]audio_left;
    input [15:0]audio_right;
    output reg audio_mclk;  // count 4 master clock
    output reg audio_lrck;  // count 4 * 128    
    output reg audio_sck;   // count 16
    output reg audio_sdin;  // poso signal

    reg [1:0]mclk_cnt;
    reg [1:0]mclk_cnt_next;
    reg audio_mclk_next;
    reg [3:0]sck_cnt;
    reg [3:0]sck_cnt_next;
    reg audio_sck_next;
    reg [8:0]lrck_cnt;
    reg [8:0]lrck_cnt_next;
    reg audio_lrck_next;
    reg [3:0]piso_cnt;
    reg [3:0]piso_cnt_next;
    // master clock
    always @*
        if (mclk_cnt == 2'd3)
        begin
            mclk_cnt_next = 2'd0;
            audio_mclk_next = ~audio_mclk;
        end 
        else
        begin
            mclk_cnt_next = mclk_cnt + 1;
            audio_mclk_next = audio_mclk;
        end
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
        begin
            mclk_cnt <= 2'b0;
            audio_mclk <= 1'b0;
        end
        else
        begin
            mclk_cnt <= mclk_cnt_next;
            audio_mclk <= audio_mclk_next;
        end
    // Serial clock
    always @*
        if (sck_cnt == 4'd15)
        begin
            sck_cnt_next = 4'd0;
            audio_sck_next = ~audio_sck;
            piso_cnt_next = piso_cnt + 1;
        end 
        else
        begin
            sck_cnt_next = sck_cnt + 1;
            audio_sck_next = audio_sck;
            piso_cnt_next = piso_cnt;
        end
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
        begin
            sck_cnt <= 4'b0;
            audio_sck <= 1'b0;
            piso_cnt <= 4'b0;
        end
        else
        begin
            sck_cnt <= sck_cnt_next;
            audio_sck <= audio_sck_next;
            piso_cnt <= piso_cnt_next;
        end
    // Left - Right clock
    always @*
        if (lrck_cnt == 9'd511)
        begin
            lrck_cnt_next = 9'd0;
            audio_lrck_next = ~audio_lrck;
        end 
        else
        begin
            lrck_cnt_next = lrck_cnt + 1;
            audio_lrck_next = audio_lrck;
        end
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
        begin
            lrck_cnt <= 9'b0;
            audio_lrck <= 1'b0;
        end
        else
        begin
            lrck_cnt <= lrck_cnt_next;
            audio_lrck <= audio_lrck_next;
        end
    // audio out
    always @*
    case ({audio_mclk, piso_cnt})
        5'b0_0000: audio_sdin = audio_left[15];
        5'b0_0001: audio_sdin = audio_left[14];
        5'b0_0010: audio_sdin = audio_left[13];
        5'b0_0011: audio_sdin = audio_left[12];
        5'b0_0100: audio_sdin = audio_left[11];
        5'b0_0101: audio_sdin = audio_left[10];
        5'b0_0110: audio_sdin = audio_left[9];
        5'b0_0111: audio_sdin = audio_left[8];
        5'b0_1000: audio_sdin = audio_left[7];
        5'b0_1001: audio_sdin = audio_left[6];
        5'b0_1010: audio_sdin = audio_left[5];
        5'b0_1011: audio_sdin = audio_left[4];
        5'b0_1100: audio_sdin = audio_left[3];
        5'b0_1101: audio_sdin = audio_left[2];
        5'b0_1110: audio_sdin = audio_left[1];
        5'b0_1111: audio_sdin = audio_left[0];
        5'b1_0000: audio_sdin = audio_right[15];
        5'b1_0001: audio_sdin = audio_right[14];
        5'b1_0010: audio_sdin = audio_right[13];
        5'b1_0011: audio_sdin = audio_right[12];
        5'b1_0100: audio_sdin = audio_right[11];
        5'b1_0101: audio_sdin = audio_right[10];
        5'b1_0110: audio_sdin = audio_right[9];
        5'b1_0111: audio_sdin = audio_right[8];
        5'b1_1000: audio_sdin = audio_right[7];
        5'b1_1001: audio_sdin = audio_right[6];
        5'b1_1010: audio_sdin = audio_right[5];
        5'b1_1011: audio_sdin = audio_right[4];
        5'b1_1100: audio_sdin = audio_right[3];
        5'b1_1101: audio_sdin = audio_right[2];
        5'b1_1110: audio_sdin = audio_right[1];
        5'b1_1111: audio_sdin = audio_right[0];
        default:   audio_sdin = 1'b0;
    endcase
endmodule
*/
module speaker_control(
    audio_mclk,
    audio_lrck,
    audio_sck,
    audio_sdin,
    audio_left,
    audio_right,
    clk,
    rst_n
    );
    input clk;
    input rst_n;
    input [15:0]audio_left, audio_right;
    output audio_mclk;
    output audio_lrck;
    output audio_sck;

    output reg audio_sdin;
    reg [8:0] cnt;
    wire [8:0] next_cnt;
    
    assign audio_mclk = cnt[1];
    assign audio_sck = cnt[3];
    assign audio_lrck = cnt[8];
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n == 0)
        begin
            cnt <= 9'd0;
        end
        else
        begin
            cnt <= next_cnt;
        end
    end
    
    assign next_cnt = cnt + 9'd1;
    
    always @*
    begin
        case(cnt[8:4])
            5'd0: audio_sdin = audio_right[0];
            5'd1: audio_sdin = audio_left[15];
            5'd2: audio_sdin = audio_left[14];
            5'd3: audio_sdin = audio_left[13];
            5'd4: audio_sdin = audio_left[12];
            5'd5: audio_sdin = audio_left[11];
            5'd6: audio_sdin = audio_left[10];
            5'd7: audio_sdin = audio_left[9];
            5'd8: audio_sdin = audio_left[8];
            5'd9: audio_sdin = audio_left[7];
            5'd10: audio_sdin = audio_left[6];
            5'd11: audio_sdin = audio_left[5];
            5'd12: audio_sdin = audio_left[4];
            5'd13: audio_sdin = audio_left[3];
            5'd14: audio_sdin = audio_left[2];
            5'd15: audio_sdin = audio_left[1];
            5'd16: audio_sdin = audio_left[0];
            5'd17: audio_sdin = audio_right[15];
            5'd18: audio_sdin = audio_right[14];
            5'd19: audio_sdin = audio_right[13];
            5'd20: audio_sdin = audio_right[12];
            5'd21: audio_sdin = audio_right[11];
            5'd22: audio_sdin = audio_right[10];
            5'd23: audio_sdin = audio_right[9];
            5'd24: audio_sdin = audio_right[8];
            5'd25: audio_sdin = audio_right[7];
            5'd26: audio_sdin = audio_right[6];
            5'd27: audio_sdin = audio_right[5];
            5'd28: audio_sdin = audio_right[4];
            5'd29: audio_sdin = audio_right[3];
            5'd30: audio_sdin = audio_right[2];
            5'd31: audio_sdin = audio_right[1];
            default: audio_sdin = 1'b0;
        endcase
    end
    
endmodule

