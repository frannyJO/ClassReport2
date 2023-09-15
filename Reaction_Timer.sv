`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 01:19:23 PM
// Design Name: 
// Module Name: Reaction_Timer
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


module Reaction_Timer(
    input logic clk, rst,
    input clearButton, startButton, stopButton,
    output logic [6:0] sseg,
    output logic [3:0] an, 
    output led
    );
    
    //states 
    typedef enum {CLEAR, START, RUN, REG_GAME, CHECKING, JUMP_GUN, TOO_SLOW, DONE} state_type;
    
    state_type state_reg, state_next;
    //logic [6:0] sseg;
    logic [27:0] HI;
    logic [27:0] sseg_OFF;
    logic [27:0] ssegValues;
    logic [19:0] count;
    logic en;
    logic off_en;
    logic [3:0] random;
    logic go;
    logic go_game;
    logic done;
    logic [27:0] time_sseg;
    logic [27:0] slow;
    logic [27:0] early;
    
    assign HI = 28'b0001001000011011111111111111;
    assign sseg_OFF = 28'b1111111111111111111111111111;
    assign en = 1'b1;
    assign off_en = 1'b0;
    assign go = 1'b0;
    assign go_game = 1'b0;
    assign slow = 28'b1111001100000010000001000000;
    assign early = 28'b0011000001100000110000011000;
    assign random = $urandom%13 + 2;
    
    sseg_setter SET(
        .ssegValues(ssegValues), 
        .en(en),  
        .clk(clk),          
        .rst(rst),        
        .sseg(sseg),
        .an(an)
     );
    
    count_n# (.N(30)) PRE(
        .clk(clk),          
        .rst(rst),        
        .en(go),          
        .count(count)
     );
     
    game_timer game(
        .en(go_game),
        .cw(1'b1),
        .clk(clk),
        .rst(rst),
        .sseg(sseg),
        .an(an),
        .done(done),
        .time_sseg(time_sseg)
    );
    
    //master FSM
    always_ff @(posedge clk, posedge rst)
        if (rst)
            state_reg <= CLEAR;
        else
            state_reg <= state_next;
     
     
     always_comb
     begin
        //set a random value
        //random = 1'b1;
        case (state_reg)
            CLEAR:
            begin
                //LED = OFF
                led = 1'b0;
                //SSEG = "HI"
                ssegValues = HI;
                
                //Next state
                if (startButton == 1)
                    state_next = START; //May need to select a rand val here
            end
            START:
            begin
                //set SSEG to off 
                ssegValues = sseg_OFF;
                en = off_en;
                go = 1'b1;
                state_next = RUN;
            end
            RUN:
            begin
                if (count[29:25] == random)
                begin
                    go = 0;
                    led = 1'b1;
                    state_next = REG_GAME;
                end
                else if (stopButton == 1'b1) 
                begin
                    go = 0;
                    state_next = JUMP_GUN;
                end
                else 
                    state_next = RUN;
                
            end
            REG_GAME:
            begin   
                led = 1'b1;
                go_game = 1'b1;
                state_next = CHECKING;
            end
            CHECKING:
            begin
                if ((done == 1'b1) && (stopButton == 1'b1))
                    begin
                        go_game = 1'b0;
                        state_next = TOO_SLOW;
                    end
                else if ((done == 1'b0) && (stopButton == 1'b0))
                    begin
                        go_game = 1'b0;
                        ssegValues = time_sseg;
                        state_next = DONE;
                    end
                
            end
            JUMP_GUN:
            begin
                en = 1'b1;
                ssegValues = early;
                led = 1'b0;
            end
            TOO_SLOW:
            begin
                en = 1'b1;
                ssegValues = slow;
            end
            DONE:
                en = 1'b1;
            default: 
                if(clearButton == 1'b1)
                    state_next = CLEAR;
        endcase 
     end
        
    
endmodule
