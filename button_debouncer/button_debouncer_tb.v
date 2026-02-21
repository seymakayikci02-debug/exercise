`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module button_debouncer_tb(

    );
        
    reg clk=0;
    reg rst;
    reg button_in=0;
    wire button_out;
    wire clk_out;
    
    button_debouncer uut(
    .clk(clk),
    .rst(rst),
    .button_in(button_in),
    .button_out(button_out),
    .clk_out(clk_out)
    );
        
    always #10 clk=~clk;
    
    
    
    initial
        begin  
        #5     
        rst=1;       
        #10;
        
        rst=0;
        
        #1000;
        
        button_in=1;
        
        #100000;
        button_in=0;
        
        #100000;
        button_in=1;
        
        #100000;
        button_in=0;
        
        #100000;
        button_in=1;
        
        #100000;
        button_in=0;
        
        #100000;
        button_in=0;
        
        #100000;
        button_in=1;
        
        #100000;
        button_in=0;
        
        $stop;
        end    
        
endmodule
