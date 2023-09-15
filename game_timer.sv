module game_timer(
    input logic en,
    input logic cw,
    input logic clk,
    input logic rst,
    output logic [6:0] sseg,
    output logic [3:0] an,
    output logic done,
    output logic [27:0] time_sseg
    );
    
    logic [29:0] count1;
    logic [29:0] count2;
    logic [19:0] tic;
    logic [10:0] increment;
    logic [27:0] ssegValues;
    logic done;
    
    assign tic = 20'b11111111111111111111;
    assign increment = 0;
    
    count_n# (.N(16)) DUT1(
    .clk(clk),          
    .rst(rst),          
    .cw(cw),           
    .en(en),            
    .count(count1),
    );

    if(count1 == tic)
    begin
        assign increment = increment + 1;
//        begin
//            if (incremnt == 1)
//                assign ssegValues = 28'b0011100111111111111111111111;
//        end
        always_comb
            case (increment)
                1: ssegValues = 28'b1000000100000010000001000000;
                2: ssegValues = 28'b1000000111100110000001000000;
                3: ssegValues = 28'b1000000010010010000001000000;
                4: ssegValues = 28'b1000000011000010000001000000;
                5: ssegValues = 28'b1000000001100110000001000000;
                6: ssegValues = 28'b1000000001001010000001000000;
                7: ssegValues = 28'b1000000000001010000001000000;
                8: ssegValues = 28'b1000000111100010000001000000;
                9: ssegValues = 28'b1000000000000010000001000000;
                10: ssegValues =28'b1000000001100010000001000000;
            default: 
                begin
                    ssegValues=28'b1111001100000010000001000000;
                    done = 1'b1;
                end
            endcase
    end
    
    if (rst)
        assign time_sseg = ssegValues; 
    
    mux_sseg# (.N(7)) DUT1(
        .in0(ssegValues[27:21]), 
        .in1(ssegValues[20:14]), 
        .in2(ssegValues[13:7]), 
        .in3(ssegValues[6:0]), 
        .sel(count2[10-1:10-2]),   
        .sseg(sseg)
     );
     
     count_n# (.N(10)) C2(
        .clk(clk),          
        .rst(rst),        
        .en(en),          
        .count(count2)
     );
    
//Decoder for count1
    TwotoFourDecoder deco(
        .TwoIn(count2[10-1:10-2]),
        .FourOut(an)
    );
    

endmodule
