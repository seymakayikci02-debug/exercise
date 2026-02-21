`timescale 1ns / 1ps

module D_ff(
    input D,
    output reg Q,
    input clk    
    );
    
    always@(posedge clk)
    begin
    Q<=D;
    end
    
endmodule
