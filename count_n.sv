module count_n#(parameter N=20)(
    input logic clk,
    input logic rst,
    input logic cw,
    input logic en,
    //output logic tic,
    output logic [N-1:0] count
    );
    
    parameter ZERO={N,(1'b0)};
    logic [N-1:0] counter, n_counter;
    
    always_ff @(posedge clk, posedge rst)
    if(rst)
       counter<=ZERO;
    else
       counter<=n_counter;
       
    always_comb 
       if(en)
          if(cw)
             n_counter = counter+1;
          else
             n_counter=counter-1;
       else
          n_counter=counter;    
     
    assign count=counter;
    //assign tic=1;
    
endmodule
