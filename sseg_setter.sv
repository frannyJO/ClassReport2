`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 07:27:48 PM
// Design Name: 
// Module Name: sseg_setter
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


module sseg_setter(
    input logic [27:0] ssegValues, 
    input logic en,
    input logic clk, rst,
    output logic [6:0] sseg,
    output logic [3:0] an
    );
    
    logic [19:0] count2;
    
    mux_sseg# (.N(7)) DUT(
        .in0(ssegValues[27:21]), 
        .in1(ssegValues[20:14]), 
        .in2(ssegValues[13:7]), 
        .in3(ssegValues[6:0]), 
        .sel(count2[20-1:20-2]),   
        .sseg(sseg)
     );
     
     count_n# (.N(20)) DUT2(
        .clk(clk),          
        .rst(rst),        
        .en(en),          
        .count(count2)
     );
     
     TwotoFourDecoder deco(
        .TwoIn(count2[20-1:20-2]),
        .FourOut(an)
    );
    
endmodule
