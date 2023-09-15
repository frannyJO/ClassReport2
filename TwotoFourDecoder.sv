`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 06:38:01 PM
// Design Name: 
// Module Name: TwotoFourDecoder
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


module TwotoFourDecoder(
    input logic [1:0] TwoIn,
    output logic [3:0] FourOut
    );
    
    always_comb
        case (TwoIn)
            2'b00: FourOut = 4'b0111;
            2'b01: FourOut = 4'b1011;
            2'b10: FourOut = 4'b1101;
            default: FourOut = 4'b1110;
        endcase 
            
endmodule
