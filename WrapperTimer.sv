`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 01:33:57 PM
// Design Name: 
// Module Name: top_sseg
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
module WrapperTimer(
    input logic [15:0] SW,
    input logic CLK100MHZ,
    input logic BTNC, 
    input logic BTNL,
    input logic BTNR,
    output logic [6:0] SSEG,
    output logic [7:0] AN,
    output logic [15:0] LED
    );


Reaction_Timer timer(
    .clk(CLK100MHZ), 
    .rst(SW[1]),
    .clearButton(BTNL), 
    .startButton(BTNR), 
    .stopButton(BTNC),
    .sseg(SSEG),
    .an(AN[3:0]), 
    .led(LED[0])
    );
    
endmodule