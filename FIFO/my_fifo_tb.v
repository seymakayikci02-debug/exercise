`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module my_fifo_tb(

    );
    parameter DATA_WIDTH=32;
    parameter FIFO_DEPTH=8;
    reg clock=0;
    reg reset;
    reg cs;
    reg  [DATA_WIDTH-1:0] data_inp;
    wire  [DATA_WIDTH-1:0] data_outp;
    reg write_ena;
    reg read_ena;
    
    my_fifo f1(
    .clk(clock),
    .reset(reset),
    .cs(cs),
    .data_in(data_inp),
    .data_out(data_outp),
    .w_ena(write_ena),
    .r_ena(read_ena)
    );
    
    always #10 clock=~clock;
    
    task write(input [DATA_WIDTH-1:0] data_in_write);
        begin
            @(posedge clock);
            cs=1;
            data_inp=data_in_write;
            write_ena=1;
            @(posedge clock);
            cs=1;
            write_ena=0;      
        end
    endtask
    
    
    task read();
        begin
            @(posedge clock);
            cs=1;
            read_ena=1;
            @(posedge clock);
            cs=1;
            read_ena=0;
                  
        end
    endtask
    
    initial
        begin
        @(posedge clock);
        reset=0;
        @(posedge clock);
        reset=1;
        write(100);
        write(10);
        write(1);       
        read();        
        read();        
        read();
        end
endmodule
