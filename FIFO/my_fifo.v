`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module my_fifo #(parameter DATA_WIDTH=32,parameter FIFO_DEPTH=8)(
    input clk,
    input reset,
    input cs,
    input  [DATA_WIDTH-1:0] data_in,
    output reg  [DATA_WIDTH-1:0]data_out,
    input w_ena,
    input r_ena
    ); 
    //parameter DATA_WIDTH=32;
    //parameter FIFO_DEPTH=8;
    localparam FIFO_DEPTH_LOG=$clog2(FIFO_DEPTH);
    reg [DATA_WIDTH-1:0] FIFO [0:FIFO_DEPTH-1];
    reg [FIFO_DEPTH_LOG-1:0]read_pointer,write_pointer;
    integer i=0;
    wire full,empty;
    
 //////////WRITE///////////   
    always@(posedge clk or negedge reset)
    begin
    if(reset==0)
        begin
            write_pointer <=0;
        end
    
    else
        begin
        if(w_ena && cs && !full)
            begin
            FIFO[write_pointer]<=data_in;
            write_pointer<=write_pointer+1;
            end
        
        end        
    end
    
    
  //////////READ/////  
    always@(posedge clk or negedge reset)
    begin
    if(reset==0)
        begin
          read_pointer <=0;  
        end
    
    else
        begin
        if(r_ena && cs && !empty)
            begin
            data_out<=FIFO[read_pointer];
            read_pointer<=read_pointer+1;
            end
        
        end        
    end
    
    
    assign empty=(read_pointer==write_pointer);
    assign full=(write_pointer==FIFO_DEPTH-1);
 
       
endmodule
