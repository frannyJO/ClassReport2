`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 01:25:23 PM
// Design Name: 
// Module Name: mux_sseg
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


module mux_sseg#(parameter N=7)(
    input logic [N-1:0] in0,
    input logic [N-1:0] in1,
    input logic [N-1:0] in2,
    input logic [N-1:0] in3,
    input logic [1:0] sel,
    output logic [N-1:0] sseg
    );
    
    parameter [6:0] A=2'b00;
    parameter [6:0] B=2'b01;
    parameter [6:0] C=2'b10;
    parameter [6:0] D=2'b11;
    
    always_comb
        case(sel)
        A: sseg = in0;
        B: sseg = in1;
        C: sseg = in2;
        D: sseg = in3;
        default: sseg = 7'bzzzzzzz;
        endcase
    
endmodule
