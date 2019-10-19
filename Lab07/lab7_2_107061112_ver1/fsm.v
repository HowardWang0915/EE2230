`define STATE_HOUR_SET 2'b00
`define STATE_PAUSE    2'b01
`define STATE_COUNT    2'b10
`define STATE_STOP     2'b11
module FSM_7_2(
    count_enable,
    set,
    stop,
    clk,
    hour_set,
    pb_stop,
    pb_pause,
    rst_n
    );
    
    output reg count_enable;
    output reg set;
    output reg stop;
    input clk;
    input hour_set;
    input pb_stop;
    input pb_pause;
    input rst_n; 
    
    reg [1:0]state;
    reg [1:0]next_state;
    
    always@*
        case(state)
            `STATE_HOUR_SET:  //hour_set
                if(hour_set == 1'b1)
                    begin
                        count_enable = 1'b0;
                        set = 1'b1;
                        stop = 1'b0;
                        next_state = `STATE_HOUR_SET;
                    end
                else
                    begin
                        count_enable = 1'b0;
                        set = 1'b0;
                        stop = 1'b0;
                        next_state = `STATE_PAUSE;
                    end
            `STATE_PAUSE:  //pause
                if(hour_set == 1'b1)
                    begin
                        count_enable = 1'b0;
                        set = 1'b1;
                        stop = 1'b0;
                        next_state = `STATE_HOUR_SET;
                    end
                else if(pb_stop == 1'b1)
                    begin
                        count_enable = 1'b0;
                        set = 1'b0;
                        stop = 1'b1;
                        next_state = `STATE_STOP;
                    end
                else if(pb_pause == 1'b1)
                    begin
                        count_enable = 1'b1;
                        set = 1'b0;
                        stop = 1'b0;
                        next_state = `STATE_COUNT;
                    end
                else
                    begin
                        count_enable = 1'b0;
                        set = 1'b0;
                        stop = 1'b0;
                        next_state = `STATE_PAUSE;
                    end
            `STATE_COUNT:  //count
                if(hour_set == 1'b1)
                    begin
                        count_enable = 1'b0;
                        set = 1'b1;
                        stop = 1'b0;
                        next_state = `STATE_HOUR_SET;
                    end
                else if(pb_stop == 1'b1)
                    begin
                        count_enable = 1'b0;
                        set = 1'b0;
                        stop = 1'b1;
                        next_state = `STATE_STOP;
                    end
                else if(pb_pause == 1'b1)
                    begin
                        count_enable = 1'b0;
                        set = 1'b0;
                        stop = 1'b0;
                        next_state = `STATE_PAUSE;
                    end
                else
                    begin
                        count_enable = 1'b1;
                        set = 1'b0;
                        stop = 1'b0;
                        next_state = `STATE_COUNT;
                    end
                `STATE_STOP:
                    if(hour_set == 1'b1)
                    begin
                        count_enable = 1'b0;
                        set = 1'b1;
                        stop = 1'b0;
                        next_state = `STATE_HOUR_SET;
                    end
                else if(pb_stop == 1'b1)
                    begin
                        count_enable = 1'b1;
                        set = 1'b0;
                        stop = 1'b0;
                        next_state = `STATE_COUNT;
                    end
                else if(pb_pause == 1'b1)
                    begin
                        count_enable = 1'b1;
                        set = 1'b0;
                        stop = 1'b0;
                        next_state = `STATE_STOP;
                    end
                else
                    begin
                        count_enable = 1'b0;
                        set = 1'b0;
                        stop = 1'b0;
                        next_state = `STATE_PAUSE;
                    end

            default:
                begin
                    count_enable = 1'b0;
                    set = 1'b0;
                    stop = 1'b0;
                    next_state = `STATE_HOUR_SET;
                end
        endcase
    
    always@(posedge clk or negedge rst_n)
        if (~rst_n)
            state <= `STATE_STOP;
        else
            state <= next_state;
    
endmodule
