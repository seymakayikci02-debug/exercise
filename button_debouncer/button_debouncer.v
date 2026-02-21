`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module button_debouncer(
    input clk,
    input rst,
    input button_in,
    output wire button_out,
    output reg clk_out
    );
    
    reg [15:0] counter;
    wire Q1,Q2;

    //Edge detect logic
    //This part make output button High when slow clock is in its second clock edge (t2) .
    //signal stays high only in the middle moment.
    
    D_ff d1(
       .D(button_in),
       .Q(Q1),
       .clk(clk_out)    
       );   
       
    D_ff d2(
       .D(Q1),
       .Q(Q2),
       .clk(clk_out)    
       );

    
    assign button_out = Q1 & (~Q2) ;
    
    
    
    always @(posedge clk)
    begin
    if(rst==1)
        begin
            counter<=0;
            clk_out<=0;
  
        end
        
    //Clock Divider=Slow clock generator
    else
        begin
            clk_out<=(counter<250) ? 0:1;
            counter<=(counter<500) ? (counter+1):0;
        end
    
    end
endmodule

